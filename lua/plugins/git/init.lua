return {
    -- git集成
    {
        "lewis6991/gitsigns.nvim",
        event = "VeryLazy",
        dependencies = { "plenary.nvim" },
        config = function()
            require("gitsigns").setup({
                signs = {
                    add = { text = "▎" },
                    change = { text = "▎" },
                    delete = { text = "" },
                    topdelete = { text = "" },
                    changedelete = { text = "▎" },
                    untracked = { text = "★" },
                },
            })
            require("scrollbar.handlers.gitsigns").setup()
        end,
        keys = {
            { "<leader>gi", "<cmd>Gitsigns<CR>", desc = "Open Gitsigns Select Args" },
            { "<leader>gs", "<cmd>Gitsigns toggle_signs<CR>", desc = "Gitsigns Toggle Sings" },
            { "<leader>gl", "<cmd>Gitsigns toggle_numhl<CR>", desc = "Gitsigns Toggle Numhl" },
            { "<leader>ge", "<cmd>Gitsigns toggle_linehl<CR>", desc = "Gitsigns Toggle Linehl" },
            { "<leader>gw", "<cmd>Gitsigns toggle_word_diff<CR>", desc = "Gitsigns Toggle Word Diff" },
            {
                "<leader>gc",
                "<cmd>Gitsigns toggle_current_line_blame<CR>",
                desc = "Gitsigns Toggle Current Line Blame",
            },
            { "<leader>gd", "<cmd>Gitsigns diffthis<CR>", desc = "Gitsigns This Diif" },
        },
    },
}
