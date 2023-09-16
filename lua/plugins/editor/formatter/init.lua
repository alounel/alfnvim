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
        config = function()
            local slow_format_filetypes = {}
            require("conform").setup({
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
                    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
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
                    return { timeout_ms = 500, lsp_fallback = true }, on_format
                end,
                format_after_save = function(bufnr)
                    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                        return
                    end
                    if not slow_format_filetypes[vim.bo[bufnr].filetype] then
                        return
                    end
                    return { lsp_fallback = true }
                end,
            })
            vim.list_extend(require("conform.formatters.shfmt").args, { "-i", "4" })
        end,
    },
}
