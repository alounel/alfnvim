-- 语言服务器增强插件
return {
    -- C/C++
    {
        "p00f/clangd_extensions.nvim",
        lazy = true,
        ft = { "c", "cpp" },
        config = function()
            require("clangd_extensions").setup({
                ast = {
                    role_icons = {
                        type = "",
                        declaration = "",
                        expression = "",
                        specifier = "",
                        statement = "",
                        ["template argument"] = "",
                    },
                    kind_icons = {
                        Compound = "",
                        Recovery = "",
                        TranslationUnit = "",
                        PackExpansion = "",
                        TemplateTypeParm = "",
                        TemplateTemplateParm = "",
                        TemplateParamObject = "",
                    },
                },
                memory_usage = {
                    border = "rounded",
                },
                symbol_info = {
                    border = "single",
                },
            })
            vim.keymap.set("n", "<leader>scs", "<cmd>ClangdSymbolInfo<CR>", { desc = "Show Cursor Local Symbol Info" })
            vim.keymap.set(
                "n",
                "<leader>scl",
                "<cmd>ClangdTypeHierarchy<CR>",
                { desc = "Show Cursor Local Type Hierarchy" }
            )
            vim.keymap.set(
                "n",
                "<leader>scg",
                "<cmd>ClangdMemoryUsage expand_preamble<CR>",
                { desc = "Show Memory Use Status" }
            )
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
        ft = { "typescript", "javascript", "tsx", "jsx", "javascriptreact", "typescriptreact" },
        dependencies = {
            { "plenary.nvim" },
            { "nvim-lspconfig" },
        },
        opts = {},
    },
}

