local uv = vim.loop or vim.uv

local M = {}

function M.get_signs(buf, lnum)
    local signs = {}

    if vim.fn.has("nvim-0.10") == 0 then
        for _, sign in ipairs(vim.fn.sign_getplaced(buf, { group = "*", lnum = lnum })[1].signs) do
            local ret = vim.fn.sign_getdefined(sign.name)[1]
            if ret then
                ret.priority = sign.priority
                signs[#signs + 1] = ret
            end
        end
    end

    local extmarks = vim.api.nvim_buf_get_extmarks(
        buf,
        -1,
        { lnum - 1, 0 },
        { lnum - 1, -1 },
        { details = true, type = "sign" }
    )
    for _, extmark in pairs(extmarks) do
        signs[#signs + 1] = {
            name = extmark[4].sign_hl_group or "",
            text = extmark[4].sign_text,
            texthl = extmark[4].sign_hl_group,
            priority = extmark[4].priority,
        }
    end

    table.sort(signs, function(a, b)
        return (a.priority or 0) < (b.priority or 0)
    end)

    return signs
end

function M.get_mark(buf, lnum)
    local marks = vim.fn.getmarklist(buf)
    vim.list_extend(marks, vim.fn.getmarklist())
    for _, mark in ipairs(marks) do
        if mark.pos[1] == buf and mark.pos[2] == lnum and mark.mark:match("[a-zA-Z]") then
            return { text = mark.mark:sub(2), texthl = "DiagnosticHint" }
        end
    end
end

function M.icon(sign, len)
    sign = sign or {}
    len = len or 2
    local text = vim.fn.strcharpart(sign.text or "", 0, len)
    text = text .. string.rep(" ", len - vim.fn.strchars(text))
    return sign.texthl and ("%#" .. sign.texthl .. "#" .. text .. "%*") or text
end

function M.foldtext()
    local ok = pcall(vim.treesitter.get_parser, vim.api.nvim_get_current_buf())
    local ret = ok and vim.treesitter.foldtext and vim.treesitter.foldtext()
    if not ret or type(ret) == "string" then
        ret = { { vim.api.nvim_buf_get_lines(0, vim.v.lnum - 1, vim.v.lnum, false)[1], {} } }
    end
    table.insert(ret, { " " .. require("core.icons").icons.misc.dots })

    if not vim.treesitter.foldtext then
        return table.concat(
            vim.tbl_map(function(line)
                return line[1]
            end, ret),
            " "
        )
    end
    return ret
end

function M.statuscolumn()
    local win = vim.g.statusline_winid
    local buf = vim.api.nvim_win_get_buf(win)
    local is_file = vim.bo[buf].buftype == ""
    local show_signs = vim.wo[win].signcolumn ~= "no"

    local components = { "", "", "" }

    if show_signs then
        local left, right, fold
        for _, s in ipairs(M.get_signs(buf, vim.v.lnum)) do
            if s.name and s.name:find("GitSign") then
                right = s
            else
                left = s
            end
        end
        if vim.v.virtnum ~= 0 then
            left = nil
        end
        vim.api.nvim_win_call(win, function()
            if vim.fn.foldclosed(vim.v.lnum) >= 0 then
                fold = { text = vim.opt.fillchars:get().foldclose or "", texthl = "Folded" }
            end
        end)
        components[1] = M.icon(M.get_mark(buf, vim.v.lnum) or left)
        components[3] = is_file and M.icon(fold or right) or ""
    end

    local is_num = vim.wo[win].number
    local is_relnum = vim.wo[win].relativenumber
    if (is_num or is_relnum) and vim.v.virtnum == 0 then
        if vim.v.relnum == 0 then
            components[2] = is_num and "%l" or "%r" -- the current line
        else
            components[2] = is_relnum and "%r" or "%l" -- other lines
        end
        components[2] = "%=" .. components[2] .. " " -- right align
    end

    return table.concat(components, "")
end

function M.fg(name)
    local hl = vim.api.nvim_get_hl and vim.api.nvim_get_hl(0, { name = name })
        or vim.api.nvim_get_hl_by_name(name, true)
    local fg = hl and (hl.fg or hl.foreground)
    return fg and { fg = string.format("#%06x", fg) } or nil
end

M.skip_foldexpr = {}
local skip_check = assert(uv.new_check())

function M.foldexpr()
    local buf = vim.api.nvim_get_current_buf()

    if M.skip_foldexpr[buf] then
        return "0"
    end

    if vim.bo[buf].buftype ~= "" then
        return "0"
    end

    if vim.bo[buf].filetype == "" then
        return "0"
    end

    local ok = pcall(vim.treesitter.get_parser, buf)

    if ok then
        return vim.treesitter.foldexpr()
    end

    M.skip_foldexpr[buf] = true
    skip_check:start(function()
        M.skip_foldexpr = {}
        skip_check:stop()
    end)
    return "0"
end

return M
