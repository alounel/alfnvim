return {
    {
        "stevearc/conform.nvim",
        lazy = true,
        cmd = "ConformInfo",
        event = "BufWritePre",
        keys = {
            {
                "<leader>F",
                function()
                    require("conform").format({ async = true, lsp_fallback = true }, function(err)
                        if not err then
                            if vim.startswith(vim.api.nvim_get_mode().mode:lower(), "v") then
                                vim.api.nvim_feedkeys(
                                    vim.api.nvim_replace_termcodes("<Esc>", true, false, true),
                                    "n",
                                    true
                                )
                            end
                        end
                    end)
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
                markdown = { "markdownlint", "injected" },
                norg = { "injected" },
                python = { "isort", "black" },
                sh = { "shellharden", "shfmt" },
                toml = { "taplo" },
                yaml = { "yamlfmt" },
                ["_"] = { "trim_whitespace", "trim_newlines" },
            },
            log_level = vim.log.levels.ERROR,
            format_after_save = { timeout_ms = 5000, lsp_fallback = true },
            formatters = {
                injected = {
                    options = { ignore_errors = true },
                },
            },
        },
        init = function()
            vim.bo.formatexpr = "v:lua.require'conform'.formatexpr()"
        end,
        config = function(_, opts)
            local util = require("conform.util")
            util.add_formatter_args(require("conform.formatters.shfmt"), { "-i", "4" })

            for name, formatter in pairs(opts.formatters or {}) do
                if type(formatter) == "table" then
                    if formatter.extra_args then
                        formatter.prepend_args = formatter.extra_args
                        require("core.util").deprecate(
                            ("opts.formatters.%s.extra_args"):format(name),
                            ("opts.formatters.%s.prepend_args"):format(name)
                        )
                    end
                end
            end
            require("conform").setup(opts)
        end,
    },
}
