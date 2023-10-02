return {
    -- 多个参数替换
    {
        "AckslD/muren.nvim",
        lazy = true,
        keys = {
            { "<leader>rrg", "<cmd>MurenToggle<CR>", desc = "Switch User Face In Muren" },
            { "<leader>rrf", "<cmd>MurenFresh<CR>", desc = "Fresh User Face In Muren" },
            { "<leader>rru", "<cmd>MurenUnique<CR>", desc = "Unique Muren" },
        },
        opts = {},
    },
}
