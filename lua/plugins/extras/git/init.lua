return {
    -- neovim的magit
    {
        "NeogitOrg/neogit",
        lazy = true,
        cmd = "Neogit",
        keys = {
            { "<leader>gnn", "<cmd>Neogit<CR>", desc = "Open Neoget Tab Page" },
            { "<leader>gnc", "<cmd>Neogit commit<CR>", desc = "Open Neogit Commit Page" },
            { "<leader>gnd", "<cmd>Neogit cwd=%:p:h<CR>", desc = "Open Neoget Current Repository" },
            { "<leader>gnt", "<cmd>Neogit kind=tab<CR>", desc = "Open Neogit Tab Popup" },
            { "<leader>gnr", "<cmd>Neogit kind=replace<CR>", desc = "Open Neogit Replace Popup" },
            { "<leader>gnf", "<cmd>Neogit kind=floating<CR>", desc = "Open Neogit Float Popup" },
            { "<leader>gns", "<cmd>Neogit kind=split<CR>", desc = "Open Neogit Split Popup" },
            { "<leader>gnb", "<cmd>Neogit kind=split_above<CR>", desc = "Open Neogit Split Above Popup" },
            { "<leader>gnv", "<cmd>Neogit kind=vsplit<CR>", desc = "Open Neogit Vsplit Popup" },
            { "<leader>gna", "<cmd>Neogit kind=auto<CR>", desc = "Open Neogit Auto Popup" },
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
