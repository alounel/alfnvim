return {
    -- 窗口分割
    {
        "nvim-focus/focus.nvim",
        version = false,
        lazy = true,
        keys = {
            { "<leader>wg", "<cmd>FocusToggle<CR>", desc = "Toggle Focus" },
            { "<leader>wn", "<cmd>FocusSplitNicely<CR>", desc = "Nicely Split Focus" },
            { "<leader>wc", "<cmd>FocusSplitCycle<CR>", desc = "Cycle Split Foucus" },
            { "<leader>ww", "<cmd>FocusToggleWindow<CR>", desc = "Again Toggle Window" },
            { "<leader>wf", ":FocusSplitLeft", desc = "Left Split + Open File Or Custom Command" },
            { "<leader>wd", ":FocusSplitDown", desc = "Down Split + Open File Or Custom Command" },
            { "<leader>wu", ":FocusSplitUp", desc = "Up Split + Open File Or Custom Command" },
            { "<leader>wr", ":FocusSplitRight", desc = "Right Split + Open File Or Custom Command" },
            { "<leader>we", "<cmd>FocusEqualise<CR>", desc = "Temporarily Equalises The Splits" },
            { "<leader>wm", "<cmd>FocusMaximise<CR>", desc = "Temporarily Maximises The Focussed Window" },
            { "<leader>wo", "<cmd>FocusMaxOrEqual<CR>", desc = "Switch Equalises And Maximises" },
        },
        opts = {
            split = {
                bufnew = true,
                tmux = true,
            },
            ui = {
                number = true,
                relativenumber = true,
                absolutenumber_unfocussed = true,
                cursorline = true,
                cursorcolumn = false,
            },
            winhighlight = true,
        },
    },
    -- 预定义窗口布局
    {
        import = "plugins.extras.window.edgy",
    },
    -- 右侧小地图
    {
        import = "plugins.extras.window.codewindow",
    },
}
