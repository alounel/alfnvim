-- 语言服务器增强插件
return {
    -- C/C++
    {
        "p00f/clangd_extensions.nvim",
        lazy = true,
        ft = { "c", "cpp" },
        config = function()
            require("ftconfig.clangd")
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
            require("ftconfig.java")
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
        },
    },
    -- yaml
    {
        "cuducos/yaml.nvim",
        lazy = true,
        ft = "yaml",
        keys = {
            { "<leader>jv", "<cmd>YAMLView<CR>", desc = "YAML Current Value/Key Paris Full Path" },
            { "<leader>jf", "<cmd>YAMLQuickfix<CR>", desc = "YAML Generates Quickfix Key/Value Pairs" },
            { "<leader>jt", "<cmd>YAMLTelescope<CR>", desc = "YAML Find Key/Value Pairs" },
        },
        dependencies = { { "nvim-treesitter" }, { "telescope.nvim" } },
    },
    -- json,yaml
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
            require("ftconfig.tst")
        end,
    },
}
