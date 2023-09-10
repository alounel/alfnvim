return {
    -- 文件标记
    {
        "ThePrimeagen/harpoon",
        lazy = true,
        keys = {
            { "<leader>mha", "<cmd>lua require('harpoon.mark').add_file()<CR>", desc = "Mark Files" },
            { "<leader>mhq", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>", desc = "View All File Mark" },
            { "<leader>mhp", "<cmd>lua require('harpoon.ui').nav_prev()<CR>", desc = "Prev Mark Files" },
            { "<leader>mhn", "<cmd>lua require('harpoon.ui').nav_next()<CR>", desc = "Next Mark Files" },
            { "<leader>mht", "<cmd>lua require('harpoon.term').gotoTerminal(1)<CR>", desc = "Navigate to 1 Terminal" },
        },
        opts = {
            save_on_toggle = true,
            tabline = false,
        },
    },
    -- 标记重要文件
    {
        "cbochs/grapple.nvim",
        lazy = true,
        keys = {
            { "<leader>mgt", "<cmd>GrappleTag<CR>", desc = "Grapple Tag" },
            { "<leader>mgs", "<cmd>GrappleTags<CR>", desc = "Grapple Tags" },
            { "<leader>mgc", "<cmd>GrappleCycle<CR>", desc = "Grapple Cycle" },
            { "<leader>mgp", "<cmd>GrapplePopup<CR>", desc = "Grapple Popup" },
            { "<leader>mgr", "<cmd>GrappleReset<CR>", desc = "Grapple Reset" },
            { "<leader>mgu", "<cmd>GrappleUntag<CR>", desc = "Un Grapple Tag" },
            { "<leader>mgs", "<cmd>GrappleSelect<CR>", desc = "Grapple Select" },
            { "<leader>mgg", "<cmd>GrappleToggle<CR>", desc = "Toggle Grapple" },
        },
        dependencies = { "plenary.nvim" },
    },
}

