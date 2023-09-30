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
                json = { "biome" },
                jsonc = { "biome" },
                javascript = { "biome" },
                javascriptreact = { "biome" },
                typescript = { "biome" },
                typescriptreact = { "biome" },
                lua = { "stylua" },
                markdown = { "mdformat", "injected" },
                norg = { "injected" },
                python = { "isort", "black" },
                sh = { "shellharden", "shfmt" },
                yaml = { "yamlfmt" },
                ["_"] = { "trim_whitespace", "trim_newlines" },
            },
            log_level = vim.log.levels.DEBUG,
            format_after_save = { timeout_ms = 5000, lsp_fallback = true },
        },
        init = function()
            vim.bo.formatexpr = "v:lua.require'conform'.formatexpr()"
        end,
        config = function(_, opts)
            local util = require("conform.util")
            util.add_formatter_args(require("conform.formatters.shfmt"), { "-i", "4" })
            require("conform").setup(opts)
        end,
    },
}
