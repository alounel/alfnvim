return {
    -- 工程管理
    {
        "ahmedkhalf/project.nvim",
        lazy = true,
        event = "VeryLazy",
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
            options = vim.opt.sessionoptions:get(),
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
            {
                "<leader>qd",
                "<cmd>lua require('persistence').stop()<CR>",
                desc = "Session Won't Be Saved On Exit",
            },
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
    -- 优雅的注释
    {
        import = "plugins.extras.develop.comments",
    },
    -- 大文件控制
    {
        import = "plugins.extras.develop.bigfile",
    },
    -- 选择器
    {
        import = "plugins.extras.develop.picker",
    },
    -- 重构代码
    {
        import = "plugins.extras.develop.refactor",
    },
}
