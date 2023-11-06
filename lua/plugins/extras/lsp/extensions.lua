-- 语言服务器增强插件
return {
    -- C/C++
    {
        "p00f/clangd_extensions.nvim",
        lazy = true,
        ft = { "c", "cpp" },
        config = function()
            require("ftplugin.cld")
            vim.keymap.set("n", "<leader>scs", "<cmd>ClangdSymbolInfo<CR>", { desc = "Show Cursor Local Symbol Info" })
            -- stylua: ignore
            vim.keymap.set("n", "<leader>scl", "<cmd>ClangdTypeHierarchy<CR>", { desc = "Show Cursor Local Type Hierarchy" })
            -- stylua: ignore
            vim.keymap.set("n", "<leader>scg", "<cmd>ClangdMemoryUsage expand_preamble<CR>", { desc = "Show Memory Use Status" })
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
        keys = {
            { "<leader>jl", ":JqxList", desc = "Json List" },
            { "<leader>jq", ":JqxQuery", desc = "Json Query" },
        },
    },
    {
        "b0o/SchemaStore.nvim",
        lazy = true,
    },
    -- typescript,javascript
    {
        "pmizio/typescript-tools.nvim",
        lazy = true,
        ft = { "typescript", "javascript", "javascriptreact", "typescriptreact" },
        dependencies = { { "plenary.nvim" }, { "nvim-lspconfig" } },
        config = function()
            require("ftplugin.tst")
        end,
    },
}
