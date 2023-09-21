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
            { "<leader>wfo", "<cmd>FocusMaxOrEqual<CR>", desc = "Swtich Equalises And Maximises" },
        },
        opts = {},
    },
    -- 预定义窗口布局
    {
        "folke/edgy.nvim",
        event = "VeryLazy",
        keys = {
            {
                "<leader>ue",
                function()
                    require("edgy").toggle()
                end,
                desc = "Toggle Edgy",
            },
            {
                "<leader>uE",
                function()
                    require("edgy").select()
                end,
                desc = "Edgy Select Window",
            },
        },
        opts = {
            bottom = {
                {
                    ft = "toggleterm",
                    size = { height = 0.4 },
                    filter = function(buf, win)
                        return vim.api.nvim_win_get_config(win).relative == ""
                    end,
                },
                {
                    ft = "noice",
                    size = { height = 0.4 },
                    filter = function(buf, win)
                        return vim.api.nvim_win_get_config(win).relative == ""
                    end,
                },
                {
                    ft = "lazyterm",
                    title = "LazyTerm",
                    size = { height = 0.4 },
                    filter = function(buf)
                        return not vim.b[buf].lazyterm_cmd
                    end,
                },
                "Trouble",
                { ft = "qf", title = "QuickFix" },
                {
                    ft = "help",
                    size = { height = 20 },
                    filter = function(buf)
                        return vim.bo[buf].buftype == "help"
                    end,
                },
                { ft = "spectre_panel", size = { height = 0.4 } },
            },
            left = {
                {
                    title = "Neo-Tree",
                    ft = "neo-tree",
                    filter = function(buf)
                        return vim.b[buf].neo_tree_source == "filesystem"
                    end,
                    pinned = true,
                    open = function()
                        vim.api.nvim_input("<esc><space>ng")
                    end,
                    size = { height = 0.5 },
                },
                {
                    title = "Neo-Tree Git",
                    ft = "neo-tree",
                    filter = function(buf)
                        return vim.b[buf].neo_tree_source == "git_status"
                    end,
                    pinned = true,
                    open = "Neotree position=right git_status",
                },
                {
                    title = "Neo-Tree Buffers",
                    ft = "neo-tree",
                    filter = function(buf)
                        return vim.b[buf].neo_tree_source == "buffers"
                    end,
                    pinned = true,
                    open = "Neotree position=top buffers",
                },
                "neo-tree",
            },
            keys = {
                -- increase width
                ["<C-Right>"] = function(win)
                    win:resize("width", 2)
                end,
                -- decrease width
                ["<C-Left>"] = function(win)
                    win:resize("width", -2)
                end,
                -- increase height
                ["<C-Up>"] = function(win)
                    win:resize("height", 2)
                end,
                -- decrease height
                ["<C-Down>"] = function(win)
                    win:resize("height", -2)
                end,
            },
        },
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
                exclude_filetypes = { "help", "vimdoc", "log", "txt", "text" },
                window_border = "rounded",
            })
        end,
    },
}
