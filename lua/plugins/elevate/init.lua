return {
    -- 改进了默认vim.ui界面
    {
        "stevearc/dressing.nvim",
        lazy = true,
        init = function()
            vim.ui.select = function(...)
                require("lazy").load({ plugins = { "dressing.nvim" } })
                return vim.ui.select(...)
            end
            vim.ui.input = function(...)
                require("lazy").load({ plugins = { "dressing.nvim" } })
                return vim.ui.input(...)
            end
        end,
        opts = {},
    },
    -- 完善旧的quickfix窗口
    {
        "kevinhwang91/nvim-bqf",
        lazy = true,
        ft = "qf",
        config = function()
            vim.cmd([[
                hi BqfPreviewBorder guifg=#3e8e2d ctermfg=71
                hi BqfPreviewTitle guifg=#3e8e2d ctermfg=71
                hi BqfPreviewThumb guibg=#3e8e2d ctermbg=71
                hi link BqfPreviewRange Search
            ]])
            require("bqf").setup({
                auto_enable = true,
                auto_resize_height = true,
                preview = {
                    win_height = 12,
                    win_vheight = 12,
                    delay_syntax = 80,
                    border = { "┏", "━", "┓", "┃", "┛", "━", "┗", "┃" },
                },
                func_map = {
                    vsplit = "",
                    ptogglemode = "z,",
                    stoggleup = "",
                },
                filter = {
                    fzf = {
                        action_for = { ["ctrl-s"] = "split" },
                        extra_opts = { "--bind", "ctrl-o:toggle-all", "--prompt", "> " },
                    },
                },
            })
        end,
    },
    -- 增强了w,e,b,ge的功能
    {
        "chrisgrieser/nvim-spider",
        lazy = true,
        keys = {
            { "w", mode = { "n", "o", "x" } },
            { "e", mode = { "n", "o", "x" } },
            { "b", mode = { "n", "o", "x" } },
            { "ge", mode = { "n", "o", "x" } },
        },
        config = function()
            vim.keymap.set({ "n", "o", "x" }, "w", "<cmd>lua require('spider').motion('w')<CR>", { desc = "Spider-w" })
            vim.keymap.set({ "n", "o", "x" }, "e", "<cmd>lua require('spider').motion('e')<CR>", { desc = "Spider-e" })
            vim.keymap.set({ "n", "o", "x" }, "b", "<cmd>lua require('spider').motion('b')<CR>", { desc = "Spider-b" })
            vim.keymap.set(
                { "n", "o", "x" },
                "ge",
                "<cmd>lua require('spider').motion('ge')<CR>",
                { desc = "Spider-ge" }
            )
        end,
    },
    -- 代替substitue
    {
        "chrisgrieser/nvim-alt-substitute",
        enabled = false,
        lazy = true,
        event = "CmdlineEnter",
        opts = {},
    },
    -- 更加便捷文件操作
    {
        "chrisgrieser/nvim-genghis",
        lazy = true,
        keys = {
            { "<leader>yp", mode = "n", desc = "Copy File Path" },
            { "<leader>ym", mode = "n", desc = "Copy File Name" },
            { "<leader>yx", mode = "n", desc = "Make File Chmod +X" },
            { "<leader>yf", mode = "n", desc = "Rename File" },
            { "<leader>yo", mode = "n", desc = "Move And Rename File" },
            { "<leader>yn", mode = "n", desc = "Create New File" },
            { "<leader>yu", mode = "n", desc = "Duplicate File" },
            { "<leader>yR", mode = "n", desc = "File Trash" },
            { "<leader>ys", mode = "x", desc = "Move Selection To New File" },
        },
        init = function()
            vim.g.genghis_use_systemclipboard = true
            vim.g.genghis_disable_commands = true
        end,
        dependencies = { "dressing.nvim" },
        config = function()
            local genghis = require("genghis")
            vim.keymap.set("n", "<leader>yp", genghis.copyFilepath)
            vim.keymap.set("n", "<leader>ym", genghis.copyFilename)
            vim.keymap.set("n", "<leader>yx", genghis.chmodx)
            vim.keymap.set("n", "<leader>yf", genghis.renameFile)
            vim.keymap.set("n", "<leader>yo", genghis.moveAndRenameFile)
            vim.keymap.set("n", "<leader>yn", genghis.createNewFile)
            vim.keymap.set("n", "<leader>yu", genghis.duplicateFile)
            vim.keymap.set("n", "<leader>yR", function()
                genghis.trashFile({ trashLocation = "/home/colin/.cache/.Trash/" })
            end)
            vim.keymap.set("x", "<leader>ys", genghis.moveSelectionToNewFile)
        end,
    },
    -- 改进了Yank和Put功能
    {
        "gbprod/yanky.nvim",
        lazy = true,
        keys = {
            { "<leader>yr", "<cmd>YankyRingHistory<CR>", desc = "Show Yanky History" },
            { "<leader>yc", "<cmd>YankyClearHistory<CR>", desc = "clear Yanky History" },
            { "y", "<Plug>(YankyYank)", mode = { "n", "x" }, desc = "Yank Text" },
            { "[y", "<Plug>(YankyCycleForward)", desc = "Cycle forward through yank history" },
            { "]y", "<Plug>(YankyCycleBackward)", desc = "Cycle backward through yank history" },
            { "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" }, desc = "Put Yanked Text After Cursor" },
            { "P", "<Plug>(YankyPutBefore)", mode = { "n", "x" }, desc = "Put Yanked Text Before Cursor" },
            { "gp", "<Plug>(YankyGPutAfter)", mode = { "n", "x" }, desc = "Put yanked text after selection" },
            { "gP", "<Plug>(YankyGPutBefore)", mode = { "n", "x" }, desc = "Put yanked text before selection" },
            { "]p", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put indented after cursor (linewise)" },
            { "[p", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put indented before cursor (linewise)" },
            { "]P", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put indented after cursor (linewise)" },
            { "[P", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put indented before cursor (linewise)" },
            { ">p", "<Plug>(YankyPutIndentAfterShiftRight)", desc = "Put and indent right" },
            { "<p", "<Plug>(YankyPutIndentAfterShiftLeft)", desc = "Put and indent left" },
            { ">P", "<Plug>(YankyPutIndentBeforeShiftRight)", desc = "Put before and indent right" },
            { "<P", "<Plug>(YankyPutIndentBeforeShiftLeft)", desc = "Put before and indent left" },
            { "=p", "<Plug>(YankyPutAfterFilter)", desc = "Put after applying a filter" },
            { "=P", "<Plug>(YankyPutBeforeFilter)", desc = "Put before applying a filter" },
        },
        dependencies = { "sqlite.lua" },
        config = function()
            require("yanky").setup({
                ring = {
                    history_length = 200,
                    storage = "sqlite",
                    sync_with_numbered_registers = true,
                    cancel_event = "update",
                },
            })
        end,
    },
    -- 增强选项卡范围
    {
        "tiagovla/scope.nvim",
        lazy = true,
        keys = {
            { "<leader>sp", ":ScopeMoveBuf", desc = "Move Current Buffer To The Specified Tab" },
        },
        opts = {},
    },
}
