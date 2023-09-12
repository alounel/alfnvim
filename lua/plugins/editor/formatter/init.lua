return {
    {
        "stevearc/conform.nvim",
        lazy = true,
        ft = { "lua", "python", "sh", "cmake", "json", "yaml", "javascript", "typescript", "markdown" },
        config = function()
            require("conform").setup({
                formatters_by_ft = {
                    cmake = { "cmake_format" },
                    json = { "jq" },
                    jsonc = { "jq" },
                    javascript = { "prettier", "prettierd" },
                    javascriptreact = { "prettier", "prettierd" },
                    typescript = { "prettier", "prettierd" },
                    typescriptreact = { "prettier", "prettierd" },
                    markdown = { "prettier", "prettierd" },
                    lua = { "stylua" },
                    python = { "black", "isort" },
                    sh = { "shellharden", "shfmt" },
                    yaml = { "yamlfmt" },
                    ["*"] = { "trim_whitespace" },
                },
                log_level = vim.log.levels.DEBUG,
            })
            vim.keymap.set("", "<leader>fm", function()
                require("conform").format({ async = true, lsp_fallback = true })
            end, { desc = "Format Buffer" })
            vim.api.nvim_create_autocmd("BufWritePre", {
                pattern = "*",
                callback = function(args)
                    local ignore_filetypes = { "c", "cpp", "java", "vim", "xml" }
                    if vim.tbl_contains(ignore_filetypes, vim.bo[args.buf].filetype) then
                        return
                    end
                    require("conform").format({ timeout_ms = 500, lsp_fallback = true, buf = args.buf })
                end,
            })
        end,
    },
}

