return {
    -- 显示十六进制颜色
    {
        "NvChad/nvim-colorizer.lua",
        lazy = true,
        keys = {
            { "<leader>hrh", "<cmd>ColorizerAttachToBuffer<CR>", desc = "Show Highlight" },
            { "<leader>hrr", "<cmd>ColorizerReloadAllBuffers<CR>", desc = "Load All Buffer HSHighlight" },
            { "<leader>hrd", "<cmd>ColorizerDetachFromBuffer<CR>", desc = "Detach Buffer HSHighlight" },
            { "<leader>hrt", "<cmd>ColorizerToggle<CR>", desc = "Toggle Buffer HSHighlight" },
        },
        opts = {
            filetypes = {
                "*",
                cmp_docs = { always_update = true },
            },
            user_default_options = {
                RRGGBBAA = true,
                AARRGGBB = true,
                tailwind = true,
            },
        },
    },
}
