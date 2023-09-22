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
                    require("conform").format({ async = true, lsp_fallback = true })
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
                markdown = { "mdformat" },
                javascript = { "biome" },
                javascriptreact = { "biome" },
                typescript = { "biome" },
                typescriptreact = { "biome" },
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
                    if err and err:match("timeout$") then
                        slow_format_filetypes[vim.bo[bufnr].filetype] = true
                    end
                end
                return { timeout_ms = 200, lsp_fallback = true }, on_format
            end,
            format_after_save = function(bufnr)
                if not slow_format_filetypes[vim.bo[bufnr].filetype] then
                    return
                end
                return { lsp_fallback = true }
            end,
        },
        init = function()
            vim.bo.formatexpr = "v:lua.require'conform'.formatexpr()"
        end,
        config = function(_, opts)
            vim.list_extend(require("conform.formatters.shfmt").args, { "-i", "4" })
            require("conform").setup(opts)
        end,
    },
}
