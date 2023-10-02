return {
    -- 窗口分割
    {
        "nvim-focus/focus.nvim",
        version = false,
        lazy = true,
        keys = {
            { "<leader>wfn", "<cmd>FocusToggle<CR>", desc = "Toggle Focus" },
            { "<leader>wfn", "<cmd>FocusSplitNicely<CR>", desc = "Nicely Split Focus" },
            { "<leader>wfc", "<cmd>FocusSplitCycle<CR>", desc = "Cycle Split Foucus" },
            { "<leader>wfw", "<cmd>FocusToggleWindow<CR>", desc = "Again Toggle Window" },
            { "<leader>wfl", ":FocusSplitLeft", desc = "Left Split + Open File Or Custom Command" },
            { "<leader>wfd", ":FocusSplitDown", desc = "Down Split + Open File Or Custom Command" },
            { "<leader>wfu", ":FocusSplitUp", desc = "Up Split + Open File Or Custom Command" },
            { "<leader>wfr", ":FocusSplitRight", desc = "Right Split + Open File Or Custom Command" },
            { "<leader>wfe", "<cmd>FocusEqualise<CR>", desc = "Temporarily Equalises The Splits" },
            { "<leader>wfm", "<cmd>FocusMaximise<CR>", desc = "Temporarily Maximises The Focussed Window" },
            { "<leader>wfo", "<cmd>FocusMaxOrEqual<CR>", desc = "Switch Equalises And Maximises" },
        },
        opts = {},
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
