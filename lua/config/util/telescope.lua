local uv = vim.loop or vim.uv
local Util = require("config.util")

local M = setmetatable({}, {
    __call = function(m, ...)
        return m.telescope(...)
    end,
})

function M.telescope(builtin, opts)
    local params = { builtin = builtin, opts = opts }
    return function()
        builtin = params.builtin
        opts = params.opts
        opts = vim.tbl_deep_extend("force", { cwd = Util.root() }, opts or {})
        if builtin == "files" then
            if uv.fs_stat((opts.cwd or uv.cwd()) .. "/.git") then
                opts.show_untracked = true
                builtin = "git_files"
            else
                builtin = "find_files"
            end
        end
        if opts.cwd and opts.cwd ~= uv.cwd() then
            opts.attach_mappings = function(_, map)
                map("i", "<a-c>", function()
                    local action_state = require("telescope.actions.state")
                    local line = action_state.get_current_line()
                    M.telescope(
                        params.builtin,
                        vim.tbl_deep_extend("force", {}, params.opts or {}, { cwd = false, default_text = line })
                    )()
                end)
                return true
            end
        end

        require("telescope.builtin")[builtin](opts)
    end
end

function M.config_files()
    return Util.telescope("find_files", { cwd = vim.fn.stdpath("config") })
end

return M
