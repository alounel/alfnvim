return {
    -- 工程管理
    {
        "ahmedkhalf/project.nvim",
        event = "VimEnter",
        config = function()
            require("project_nvim").setup()
        end,
    },
    -- 从终端缓冲区打开文件
    {
        "willothy/flatten.nvim",
        lazy = true,
        event = "VeryLazy",
        opts = {},
    },
    -- QuickFix窗口可编辑
    {
        "gabrielpoca/replacer.nvim",
        lazy = true,
        keys = {
            { "<leader>xpr", "<cmd>lua require('replacer').run()<CR>", desc = "Run Replacer" },
            { "<leader>xps", "<cmd>lua require('replacer').save()<CR>", desc = "Save Replacer" },
        },
        opts = {
            rename_files = false,
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
    -- 解释和测试正则表达式
    {
        "tomiis4/hypersonic.nvim",
        lazy = true,
        event = "CmdlineEnter",
        keys = {
            { "<leader>rx", ":Hypersonic", desc = "Explain Or Test Regex" },
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
            { "<leader>rfe", mode = "x" },
            { "<leader>rft", mode = "x" },
            { "<leader>rfv", mode = "x" },
            { "<leader>rfi", mode = { "n", "x" } },
            { "<leader>rfb", mode = "n" },
            { "<leader>rfk", mode = "n" },
        },
        dependencies = {
            { "plenary.nvim" },
            { "nvim-treesitter" },
        },
        config = function()
            require("refactoring").setup({})
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
    -- 大文件
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
    {
        import = "plugins.develop.comment",
    },
}
