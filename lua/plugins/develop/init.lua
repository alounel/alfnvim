return {
    -- 工程管理
    {
        "ahmedkhalf/project.nvim",
        event = "VimEnter",
        config = function()
            require("project_nvim").setup()
        end,
    },
    -- 会话管理
    {
        "folke/persistence.nvim",
        lazy = true,
        event = "BufReadPre",
        opts = {
            options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp" },
        },
        keys = {
            {
                "<leader>qs",
                "<cmd>lua require('persistence').load()<CR>",
                desc = "Restore The Session For The Current Directory",
            },
            {
                "<leader>ql",
                "<cmd>lua require('persistence').load({ last = true })<CR>",
                desc = "Restore The Last Session",
            },
            { "<leader>qd", "<cmd>lua require('persistence').stop()<CR>", desc = "Session Won't Be Saved On Exit" },
        },
    },
    -- 构建和运行代码
    {
        "Zeioth/compiler.nvim",
        lazy = true,
        keys = {
            { "<leader>epo", "<cmd>CompilerOpen<CR>", desc = "Open Compiler Face" },
            { "<leader>epr", "<cmd>CompilerToggleResults<CR>", desc = "Result Compiler" },
            { "<leader>epd", "<cmd>CompilerRedo<CR>", desc = "Redo Compiler" },
            { "<leader>eps", "<cmd>CompilerStop<CR>", desc = "Stop Compiler" },
        },
        dependencies = {
            {
                "stevearc/overseer.nvim",
                lazy = true,
                opts = {
                    task_list = {
                        direction = "bottom",
                        min_height = 25,
                        max_height = 25,
                        default_detail = 1,
                        bindings = {
                            ["q"] = function()
                                vim.cmd("OverseerClose")
                            end,
                        },
                    },
                },
            },
        },
        opts = {},
    },
    -- 图标选择器
    {
        "ziontee113/icon-picker.nvim",
        lazy = true,
        keys = {
            { "<leader>ic", "<cmd>IconPickerNormal<CR>", desc = "Nomal Mode Pick Icon Insert Buffer" },
            { "<leader>iy", "<cmd>IconPickerYank<CR>", desc = "Pick Icon And Yank To Regeister" },
        },
        dependencies = { "telescope.nvim" },
        opts = {
            disable_legacy_commands = true,
        },
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
    {
        import = "plugins.develop.comment",
    },
}
