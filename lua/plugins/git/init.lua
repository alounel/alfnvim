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
                    untracked = { text = "▎" },
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
    -- 补充gitsigns功能
    {
        "chrisgrieser/nvim-tinygit",
        lazy = true,
        keys = {
            {
                "<leader>gtm",
                "<cmd>lua require('tinygit').amendOnlyMsg ({ forcePush = false })<CR>",
                desc = "Change Last Commit Message",
            },
            {
                "<leader>gtn",
                "<cmd>lua require('tinygit').amendNoEdit ({ forcePush = false })<CR>",
                desc = "Keep Last Commit Message",
            },
            {
                "<leader>gti",
                "<cmd>lua require('tinygit').issuesAndPrs({ type = 'all', state = 'all' })<CR>",
                desc = "Search Issues & PRs",
            },
            {
                "<leader>gtu",
                "<cmd>require('tinygit').githubUrl('file')<CR>",
                mode = { "n", "v" },
                desc = "Open At Github And Copy URL To Clipboard",
            },
            {
                "<leader>gtp",
                "<cmd>require('tinygit').push({ pullBefore = false, force = false })<CR>",
                desc = "Git Push",
            },
        },
        dependencies = "dressing.nvim",
    },
    -- neovim的magit
    {
        "NeogitOrg/neogit",
        lazy = true,
        cmd = "Neogit",
        keys = {
            { "<leader>gnt", "<cmd>Neogit<CR>", desc = "Open Neoget Tab Page" },
            { "<leader>gnc", "<cmd>Neogit commit<CR>", desc = "Open Neogit Commit Page" },
            { "<leader>gnd", ":Neogit cwd=", desc = "Open Neoget Overrride CWD" },
            { "<leader>gnk", ":Neogit kind=", desc = "Open Neogit Overrride Kind" },
        },
        dependencies = {
            { "plenary.nvim" },
            { "diffview.nvim" },
            { "telescope.nvim" },
        },
        opts = {
            integrations = {
                telescope = true,
                diffview = true,
            },
        },
    },
    -- 环浏览任何 git 版本的所有修改文件的差异
    {
        "sindrets/diffview.nvim",
        lazy = true,
        keys = {
            { "<leader>dvh", ":DiffviewFileHistory", desc = "View Files History Diff" },
            { "<leader>dvt", "<cmd>DiffviewToggleFiles<CR>", desc = "Toggle File Diff Panel" },
            { "<leader>dvl", "<cmd>DiffviewLog<CR>", desc = "Show File Log" },
            { "<leader>dvr", "<cmd>DiffviewRefresh<CR>", desc = "Update Current Entries And File List" },
            { "<leader>dvu", "<cmd>DiffviewFocusFiles<CR>", desc = "Bring Focus To The File Panel" },
        },
        opts = {
            view = {
                default = {
                    winbar_info = true,
                },
            },
        },
    },
}
