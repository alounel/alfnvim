local Util = require("config.util")

local M = {}

M.filter = {
    kind_filter = {
        default = {
            "Class",
            "Constructor",
            "Enum",
            "Field",
            "Function",
            "Interface",
            "Method",
            "Module",
            "Namespace",
            "Package",
            "Property",
            "Struct",
            "Trait",
        },
        markdown = false,
        help = false,
        lua = {
            "Class",
            "Constructor",
            "Enum",
            "Field",
            "Function",
            "Interface",
            "Method",
            "Module",
            "Namespace",
            "Property",
            "Struct",
            "Trait",
        },
    },
}

function M.setup()
    local group = vim.api.nvim_create_augroup("Alfnvim", { clear = true })
    vim.api.nvim_create_autocmd("User", {
        group = group,
        pattern = "VeryLazy",
        callback = function()
            Util.root.setup()
        end,
    })
end

function M.get_kind_filter(buf)
    buf = (buf == nil or buf == 0) and vim.api.nvim_get_current_buf() or buf
    local ft = vim.bo[buf].filetype
    if M.filter.kind_filter == false then
        return
    end
    if M.filter.kind_filter[ft] == false then
        return
    end
    return type(M.filter.kind_filter) == "table"
            and type(M.filter.kind_filter.default) == "table"
            and M.filter.kind_filter.default
        or nil
end

function M.sign()
    for name, icon in pairs(require("core.magic").icons.diagnostics) do
        name = "DiagnosticSign" .. name
        vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
    end
end

return M
