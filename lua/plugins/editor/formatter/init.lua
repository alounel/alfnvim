return {
    {
        "mhartington/formatter.nvim",
        lazy = true,
        keys = {
            { "<leader>fme", "<cmd>Format<CR>", desc = "Format" },
            { "<leader>fmw", "<cmd>FormatWrite<CR>", desc = "Format Write" },
            { "<leader>fml", "<cmd>FormatLock<CR>", desc = "Format Lock" },
            { "<leader>fmn", "<cmd>FormatWriteLock<CR>", desc = "Format Write And Lock" },
        },
        config = function()
            require("formatter").setup({
                filetype = {
                    javascript = {
                        require("formatter.filetypes.javascript").prettier,
                    },
                    typescript = {
                        require("formatter.filetypes.typescript").prettier,
                    },
                    markdown = {
                        require("formatter.filetypes.markdown").prettier,
                    },
                },
            })
        end,
    },
    -- 作为对formatter.nvim的补充
    {
        "stevearc/conform.nvim",
        lazy = true,
        ft = { "lua", "python", "sh", "cmake", "json", "yaml" },
        config = function()
            require("conform").setup({
                formatters_by_ft = {
                    cmake = { "cmake_format" },
                    json = { "jq" },
                    lua = { "stylua" },
                    python = {
                        formatters = { "black", "isort" },
                        run_all_formatters = true,
                    },
                    sh = { "shfmt" },
                    yaml = { "yamlfmt" },

                    format_on_save = {
                        timeout_ms = 500,
                        lsp_fallback = true,
                    },
                },
            })
            vim.api.nvim_create_autocmd("BufWritePre", {
                pattern = "*",
                callback = function(args)
                    require("conform").format({ buf = args.buf })
                end,
            })
        end,
    },
}
