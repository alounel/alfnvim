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
            { "<leader>jl", "<cmd>JqxList<CR>", desc = "Json List" },
            { "<leader>jn", "<cmd>JqxList null<CR>", desc = "Json Null List" },
            { "<leader>jm", "<cmd>JqxList number<CR>", desc = "Json Number List" },
            { "<leader>js", "<cmd>JqxList string<CR>", desc = "Json String List" },
            { "<leader>ja", "<cmd>JqxList array<CR>", desc = "Json Array List" },
            { "<leader>jo", "<cmd>JqxList object<CR>", desc = "Json Object List" },
            { "<leader>jb", "<cmd>JqxList boolean<CR>", desc = "Json Boolean List" },
            { "<leader>jq", "<cmd>JqxQuery<CR>", desc = "Json Query" },
            { "<leader>jj", "<cmd>JqxQuery json<CR>", desc = "Json Query Json" },
            { "<leader>jt", "<cmd>JqxQuery linter<CR>", desc = "Json Query Linter" },
            { "<leader>jf", "<cmd>JqxQuery formatter<CR>", desc = "Json Query Formatter" },
            { "<leader>ji", "<cmd>JqxQuery organizeImports<CR>", desc = "Json Query Organize Imports" },
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
