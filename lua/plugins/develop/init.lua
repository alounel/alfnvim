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
    -- 从终端缓冲区打开文件
    {
        "willothy/flatten.nvim",
        event = "VimEnter",
        opts = {},
    },
    -- QuickFix窗口可编辑
    {
        "gabrielpoca/replacer.nvim",
        lazy = true,
        opts = {
            rename_files = false,
            save_on_write = false,
        },
        keys = {
            { "<leader>xpr", "<cmd>lua require('replacer').run()<CR>", desc = "Quickfix Editable" },
            { "<leader>xps", "<cmd>lua require('replacer').save()<CR>", desc = "Save Quickfix Edit Text" },
        },
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
    -- 函数重构
    -- dependencies neovim nighty
    {
        "ThePrimeagen/refactoring.nvim",
        enabled = false,
        lazy = true,
        cmd = "Refactor",
        keys = {
            { "<leader>rfe", mode = "x", desc = "Extract Function" },
            { "<leader>rft", mode = "x", desc = "Extract Function To File" },
            { "<leader>rfv", mode = "x", desc = "Extract Variable" },
            { "<leader>rfi", mode = { "n", "x" }, desc = "Inline Variable" },
            { "<leader>rfb", desc = "Extract Block" },
            { "<leader>rfk", desc = "Extract Block To File" },
        },
        dependencies = {
            { "plenary.nvim" },
            { "nvim-treesitter" },
        },
        config = function()
            require("refactoring").setup({
                prompt_func_return_type = {
                    go = false,
                    java = true,

                    cpp = true,
                    c = true,
                    h = true,
                    hpp = true,
                    cxx = true,
                },
                prompt_func_param_type = {
                    go = false,
                    java = false,

                    cpp = true,
                    c = true,
                    h = true,
                    hpp = true,
                    cxx = true,
                },
            })
            vim.keymap.set("x", "<leader>rfe", function()
                require("refactoring").refactor("Extract Function")
            end)
            vim.keymap.set("x", "<leader>rft", function()
                require("refactoring").refactor("Extract Function To File")
            end)
            vim.keymap.set("x", "<leader>rfv", function()
                require("refactoring").refactor("Extract Variable")
            end)
            vim.keymap.set({ "n", "x" }, "<leader>rfi", function()
                require("refactoring").refactor("Inline Variable")
            end)
            vim.keymap.set("n", "<leader>rfb", function()
                require("refactoring").refactor("Extract Block")
            end)
            vim.keymap.set("n", "<leader>rfk", function()
                require("refactoring").refactor("Extract Block To File")
            end)
        end,
    },
    -- 大文件控制
    {
        "LunarVim/bigfile.nvim",
        priority = 100,
        opts = {
            filesize = 2,
            pattern = { "*" },
            features = {
                "indent_blankline",
                "illuminate",
                "lsp",
                "treesitter",
                "syntax",
                "matchparen",
                "vimopts",
                "filetype",
            },
        },
    },
    -- 良好工作流程
    {
        import = "plugins.extras.develop.process",
    },
    -- 优雅的注释
    {
        import = "plugins.extras.develop.comments",
    },
    -- 正则表达式解释器
    {
        import = "plugins.extras.develop.regex",
    },
    -- 选择器
    {
        import = "plugins.extras.develop.pick",
    },
}
