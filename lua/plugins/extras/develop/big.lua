return {
    -- 大文件控制
    {
        "LunarVim/bigfile.nvim",
        opts = {
            filesize = 2,
            pattern = { "*" },
            features = {
                "indent_blankline",
                "illuminate",
                "lsp",
                "treesitter",
                "syntax",
                "matchparen",
                "vimopts",
                "filetype",
            },
        },
    },
}
