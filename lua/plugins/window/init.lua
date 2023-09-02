return {
    -- 窗口分割
    {
        "nvim-focus/focus.nvim",
        version = false,
        lazy = true,
        keys = {
            { "<leader>wfg", "<cmd>FocusToggle<CR>", desc = "Toggle Focus" },
            { "<leader>wfn", "<cmd>FocusSplitNicely<CR>", desc = "Nicely Split Focus" },
            { "<leader>wfc", "<cmd>FocusSplitCycle<CR>", desc = "Cycle Split Foucus" },
            { "<leader>wfw", "<cmd>FocusToggleWindow<CR>", desc = "Again Toggle Window" },
            { "<leader>wfl", ":FocusSplitLeft", desc = "Left Split + Open File Or Custom Command" },
            { "<leader>wfd", ":FocusSplitDown", desc = "Down Split + Open File Or Custom Command" },
            { "<leader>wfu", ":FocusSplitUp", desc = "Up Split + Open File Or Custom Command" },
            { "<leader>wfr", ":FocusSplitRight", desc = "Right Split + Open File Or Custom Command" },
            { "<leader>wfe", "<cmd>FocusEqualise<CR>", desc = "Temporarily Equalises The Splits" },
            { "<leader>wfm", "<cmd>FocusMaximise<CR>", desc = "Temporarily Maximises The Focussed Window" },
            { "<leader>wfo", "<cmd>FocusMaxOrEqual<CR>", desc = "Swtich Equalises And Maximises" },
        },
        opts = {},
    },
    -- 预定义窗口布局
    {
        "folke/edgy.nvim",
        enabled = false,
        event = "VeryLazy",
        opts = {},
    },
    -- 将缓冲区锁定到窗口
    {
        "stevearc/stickybuf.nvim",
        lazy = true,
        keys = {
            { "<leader>skf", "<cmd>PinBuffer<CR>", desc = "Fix Before Buffer In Window" },
            { "<leader>skt", "<cmd>PinBuftype<CR>", desc = "Set Before Buftype Fix In Window" },
            { "<leader>ske", "<cmd>PinFiletype<CR>", desc = "Set Before Filetype Fix In Window" },
            { "<leader>sku", "<cmd>UnpinBuffer<CR>", desc = "Cancel Everything Fix Window" },
        },
        opts = {},
    },
    -- 右侧小地图
    {
        "gorbit99/codewindow.nvim",
        lazy = true,
        keys = {
            {
                "<leader>sm",
                function()
                    require("codewindow").toggle_minimap()
                end,
                desc = "Toggle Minimap",
            },
            {
                "<leader>sf",
                function()
                    require("codewindow").toggle_focus()
                end,
                desc = "Focus Minimap",
            },
        },
        config = function()
            require("codewindow").setup({
                exclude_filetypes = { "help", "vimdoc", "log", "txt" },
                window_border = "rounded",
            })
        end,
    },
}
