return {
    {
        "cbochs/portal.nvim",
        lazy = true,
        cmd = "Portal",
        keys = {
            { "<leader>pb", "<cmd>Portal jumplist backward<CR>", desc = "Jumplist Backward" },
            { "<leader>pc", "<cmd>Portal jumplist forward<CR>", desc = "Jumplist Forward" },
            { "<leader>pd", "<cmd>Portal quickfix forward<CR>", desc = "Quickfix Forward" },
            { "<leader>pe", "<cmd>Portal quickfix backward<CR>", desc = "Quickfix Backward" },
            { "<leader>pf", "<cmd>Portal changelist backward<CR>", desc = "Changelist Backward" },
            { "<leader>pg", "<cmd>Portal changelist forward<CR>", desc = "Changelist Forward" },
            { "<leader>ph", "<cmd>Portal harpoon backward<CR>", desc = "Harpoon Backward" },
            { "<leader>pi", "<cmd>Portal harpoon forward<CR>", desc = "Harpoon Forward" },
        },
        opts = {
            log_level = "error",
            window_options = {
                border = "rounded",
            },
        },
    },
}
