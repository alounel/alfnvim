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
                format_on_save = {
                    timeout_ms = 500,
                    lsp_fallback = true,
                },
            })
            vim.keymap.set("", "<leader>fm", function()
                require("conform").format({ async = true, lsp_fallback = true })
            end, { desc = "Format Buffer" })
            vim.api.nvim_create_autocmd("BufWritePre", {
                pattern = "*",
                callback = function(args)
                    require("conform").format({ buf = args.buf })
                end,
            })
        end,
    },
}
