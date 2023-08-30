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
    {
        import = "plugins.elevate.fulfill",
    },
}