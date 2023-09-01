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
                    javascript = { "prettier" },
                    typescript = { "prettier" },
                    markdown = { "prettier" },
                    lua = { "stylua" },
                    python = {
                        formatters = { "black", "isort" },
                        run_all_formatters = true,
                    },
                    sh = { "shfmt" },
                    yaml = { "yamlfmt" },
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
