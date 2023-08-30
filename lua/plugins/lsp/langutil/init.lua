-- 语言服务器增强插件
return {
    -- C/C++
    {
        "p00f/clangd_extensions.nvim",
        lazy = true,
        ft = { "c", "cpp" },
        init = function()
            vim.keymap.set("n", "<leader>cs", "<cmd>ClangdSymbolInfo<CR>", { desc = "Show Cursor Local Symbol Info" })
            vim.keymap.set(
                "n",
                "<leader>cl",
                "<cmd>ClangdTypeHierarchy<CR>",
                { desc = "Show Cursor Local Type Hierarchy" }
            )
            vim.keymap.set(
                "n",
                "<leader>cg",
                "<cmd>ClangdMemoryUsage expand_preamble<CR>",
                { desc = "Show Memory Use Status" }
            )
        end,
        config = function()
            require("clangd_extensions").setup({
                extensions = {
                    memory_usage = {
                        border = "rounded",
                    },
                    symbol_info = {
                        border = "single",
                    },
                },
            })
        end,
    },
    -- java
    {
        "mfussenegger/nvim-jdtls",
        lazy = true,
        ft = "java",
        config = function()
            require("ftplugin.java")
        end,
    },
    -- json,yaml
    {
        "gennaro-tedesco/nvim-jqx",
        lazy = true,
        ft = { "json", "yaml" },
        init = function()
            vim.keymap.set("n", "<leader>jl", "<cmd>JqxList<CR>", { desc = "Json List" })
            vim.keymap.set("n", "<leader>jq", "<cmd>JqxQuery<CR>", { desc = "Json Query" })
        end,
    },
    -- 提供对SchemaStore目录的访问
    {
        "b0o/SchemaStore.nvim",
        lazy = true,
        ft = { "json", "yaml" },
    },
    -- typescript,javascript
    {
        "pmizio/typescript-tools.nvim",
        lazy = true,
        ft = { "typescript", "javascript", "tsx", "jsx", "javascriptreact", "typescriptreact" },
        opts = {},
    },
}
