return {
    -- 自动关闭和重命名标签
    {
        "windwp/nvim-ts-autotag",
        lazy = true,
        ft = {
            "xml",
            "html",
            "markdown",
            "javascript",
            "typescript",
            "javascriptreact",
            "typescriptreact",
            "jsx",
            "tsx",
        },
        dependencies = { "nvim-treesitter" },
        opts = {
            filetypes = {
                "xml",
                "html",
                "markdown",
                "javascript",
                "typescript",
                "javascriptreact",
                "typescriptreact",
                "jsx",
                "tsx",
            },
        },
    },
}
