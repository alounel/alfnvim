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
                desc = "Format buffer",
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
                ["*"] = { "trim_whitespace" },
            },
            log_level = vim.log.levels.DEBUG,
            format_on_save = function(bufnr)
                local ignore_filetypes = { "java", "vim", "xml" }
                if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
                    return
                end
                local async_format = vim.g.async_format_filetypes[vim.bo[bufnr].filetype]
                if async_format or vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                    return
                end
                return { timeout_ms = 500, lsp_fallback = true }
            end,
            format_after_save = function(bufnr)
                local async_format = vim.g.async_format_filetypes[vim.bo[bufnr].filetype]
                if not async_format or vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                    return
                end
                return { lsp_fallback = true }
            end,
            user_async_format_filetypes = {
                c = true,
                cpp = true,
                cmake = true,
                json = true,
                jsonc = true,
                lua = true,
                markdown = true,
                javascript = true,
                javascriptreact = true,
                typescript = true,
                typescriptreact = true,
                python = true,
                sh = true,
                yaml = true,
            },
        },
        config = function(_, opts)
            vim.list_extend(require("conform.formatters.shfmt").args, { "-i", "2" })
            if vim.g.started_by_firenvim then
                opts.format_on_save = false
                opts.format_after_save = false
            end
            vim.g.async_format_filetypes = opts.user_async_format_filetypes
            require("conform").setup(opts)
        end,
    },
}
