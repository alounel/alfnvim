return {
    {
        "numToStr/Comment.nvim",
        lazy = true,
        keys = {
            { "gc", mode = { "v", "n" }, desc = "Comment toggle linewise" },
            { "gb", mode = { "v", "n" }, desc = "Comment toggle blockwise" },
        },
        config = function()
            require("Comment").setup({
                padding = true,
                sticky = true,
                ignore = "^$",
                toggler = {
                    line = "gcc",
                    block = "gbc",
                },
                opleader = {
                    line = "gc",
                    block = "gb",
                },
                extra = {
                    above = "gcO",
                    below = "gco",
                    eol = "gcA",
                },
                mappings = {
                    basic = true,
                    extra = true,
                },
                pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
                post_hook = nil,
            })
        end,
    },
    {
        "folke/todo-comments.nvim",
        lazy = true,
        cmd = { "TodoTrouble", "TodoTelescope" },
        keys = {
            {
                "[t",
                function()
                    require("todo-comments").jump_prev()
                end,
                desc = "Prev Jump Todo",
            },
            {
                "]t",
                function()
                    require("todo-comments").jump_next()
                end,
                desc = "Next Jump Todo",
            },
            -- 查找TODO标签
            { "<leader>tdt", "<cmd>TodoTelescope theme=ivy<CR>", desc = "Find Todo Tag" },
            -- 筛选关键词
            { "<leader>tdg", ":TodoTelescope keywords=", desc = "Filter keyswords" },
            -- 指定搜索目录
            { "<leader>tdd", ":TodoTrouble cwd=", desc = "Search Specify Directory" },
            -- 使用快速修复列表显示项目中的所有代办事项
            { "<leader>tdq", "<cmd>TodoQuickFix<CR>", desc = "Use QuickFix Show Todo Projects" },
            -- 使用位置列表显示项目中的所有代办事项
            { "<leader>tdl", "<cmd>TodoLocList<CR>", desc = "Use Localist Show Todo Projects" },
        },
        dependencies = { "plenary.nvim" },
        opts = {
            keywords = {
                FIX = { icon = " ", color = "#DC2626", alt = { "FIXME", "BUG", "FIXIT", "ISSUE", "!" } },
                TODO = { icon = " ", color = "#10B981" },
                HACK = { icon = " ", color = "#7C3AED" },
                WARN = { icon = " ", color = "#FBBF24", alt = { "WARNING", "XXX" } },
                PERF = { icon = " ", color = "#FC9868", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
                NOTE = { icon = " ", color = "#2563EB", alt = { "INFO" } },
                TEST = { icon = "⏲ ", color = "#FF00FF", alt = { "TESTING", "PASSED", "FAILED" } },
            },
        },
    },
    -- 注释生成器
    {
        "danymat/neogen",
        lazy = true,
        cmd = "Neogen",
        keys = {
            { "<leader>eg", "<cmd>Neogen<CR>", desc = "Generate Comment" },
            { "<leader>ef", "<cmd>Neogen func<CR>", desc = "Generate Function Comment" },
            { "<leader>ec", "<cmd>Neogen class<CR>", desc = "Generate Class Comment" },
            { "<leader>et", "<cmd>Neogen type<CR>", desc = "Generate Type Comment" },
            { "<leader>ei", "<cmd>Neogen file<CR>", desc = "Generate File Comment" },
        },
        opts = {
            snippet_engine = "luasnip",
        },
    },
}
