local function get_lsp_fallback(bufnr)
    local formatters = require("conform").list_formatters(bufnr)
    if #formatters > 0 and formatters[1].name == "trim_whitespace" then
        return "always"
    else
        return true
    end
end

local slow_format_filetypes = {}
return {
    {
        "stevearc/conform.nvim",
        lazy = true,
        event = "BufWritePre",
        keys = {
            {
                "<leader>fm",
                function()
                    require("conform").format({ async = true, lsp_fallback = get_lsp_fallback(0) })
                end,
                mode = "",
                desc = "Format Buffer",
            },
        },
        opts = {
            formatters_by_ft = {
                c = { "clang_format" },
                cpp = { "clang_format" },
                cmake = { "cmake_format" },
                json = { "jq" },
                jsonc = { "jq" },
                lua = { "stylua" },
                markdown = { "markdownlint" },
                javascript = { "prettierd", "prettier" },
                javascriptreact = { "prettierd", "prettier" },
                typescript = { "prettierd", "prettier" },
                typescriptreact = { "prettierd", "prettier" },
                python = { "isort", "black" },
                sh = { "shellharden", "shfmt" },
                yaml = { "yamlfmt" },
                ["_"] = { "trim_whitespace", "trim_newlines" },
            },
            log_level = vim.log.levels.DEBUG,
            format_on_save = function(bufnr)
                local ignore_filetypes = { "java", "vim", "xml" }
                if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
                    return
                end
                if slow_format_filetypes[vim.bo[bufnr].filetype] then
                    return
                end
                local function on_format(err)
                    if err and err:match("timed out$") then
                        slow_format_filetypes[vim.bo[bufnr].filetype] = true
                    end
                end
                return { timeout_ms = 200, lsp_fallback = get_lsp_fallback(bufnr) }, on_format
            end,
            format_after_save = function(bufnr)
                if not slow_format_filetypes[vim.bo[bufnr].filetype] then
                    return
                end
                return { lsp_fallback = get_lsp_fallback(bufnr) }
            end,
        },
        config = function(_, opts)
            vim.list_extend(require("conform.formatters.shfmt").args, { "-i", "4" })
            if vim.g.started_by_firenvim then
                opts.format_on_save = false
                opts.format_after_save = false
            end
            require("conform").setup(opts)
        end,
    },
}
