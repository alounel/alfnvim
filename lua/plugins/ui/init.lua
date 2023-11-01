return {
    -- 高度实验性插件
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            lsp = {
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true,
                },
            },
            presets = {
                bottom_search = true,
                command_palette = true,
                long_message_to_split = true,
                inc_rename = true,
                lsp_doc_border = true,
            },
            routes = {
                filter = {
                    event = "msg_show",
                    any = {
                        { find = "%d+L, %d+B" },
                        { find = "; after #%d+" },
                        { find = "; before #%d+" },
                    },
                },
                view = "mini",
            },
        },
        keys = {
            {
                "<S-Enter>",
                function()
                    require("noice").redirect(vim.fn.getcmdline())
                end,
                mode = "c",
                desc = "Redirect Cmdline",
            },
            {
                "<leader>ul",
                function()
                    require("noice").cmd("last")
                end,
                desc = "Noice Last Message",
            },
            {
                "<leader>uh",
                function()
                    require("noice").cmd("history")
                end,
                desc = "Noice History",
            },
            {
                "<leader>ua",
                function()
                    require("noice").cmd("all")
                end,
                desc = "Noice All",
            },
            {
                "<leader>ud",
                function()
                    require("noice").cmd("dismiss")
                end,
                desc = "Dismiss All",
            },
        },
    },
    -- 消息弹窗
    {
        "rcarriga/nvim-notify",
        event = "VeryLazy",
        keys = {
            {
                "<leader>uy",
                function()
                    require("notify").dismiss({ silent = true, pending = true })
                end,
                desc = "Dismiss All Notifications",
            },
        },
        init = function()
            local Util = require("core.util")
            if not Util.has("noice.nvim") then
                Util.on_very_lazy(function()
                    vim.notify = require("notify")
                end)
            end
        end,
        opts = {
            stages = "fade",
            timeout = 6000,
            max_height = function()
                return math.floor(vim.o.lines * 0.75)
            end,
            max_width = function()
                return math.floor(vim.o.columns * 0.75)
            end,
        },
    },
    -- 滚动条
    {
        "petertriho/nvim-scrollbar",
        event = "VeryLazy",
        opts = {
            handle = { color = "#892E42" },
            marks = {
                Cursor = { color = "#FD5622" },
                Search = { color = "#FFC860" },
                Error = { color = "#FD6883" },
                Warn = { color = "#FFD886" },
                Info = { color = "#A9DC76" },
                Hint = { color = "#78DCE8" },
                Misc = { color = "#AB9DF2" },
                GitAdd = { color = "#E85236" },
                GitChange = { color = "#D89D80" },
                GitDelete = { color = "#AB56B5" },
            },
            excluded_buftypes = { "terminal", "help", "nofile", "quickfix" },
            handlers = {
                gitsigns = true,
                search = true,
            },
        },
    },
    -- 显示光标下相同词汇
    {
        "RRethy/vim-illuminate",
        lazy = true,
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require("illuminate").configure({
                providers = {
                    "lsp",
                    "treesitter",
                },
                delay = 200,
                large_file_cutoff = 2000,
                large_file_overrides = {
                    providers = {
                        "lsp",
                        "treesitter",
                    },
                },
            })
            vim.keymap.set(
                "n",
                "[l",
                "<cmd>lua require('illuminate').goto_prev_reference()<CR>",
                { desc = "Goto Prev Referencce" }
            )
            vim.keymap.set(
                "n",
                "]l",
                "<cmd>lua require('illuminate').goto_next_reference()<CR>",
                { desc = "Goto Next Referencce" }
            )
        end,
        keys = {
            { "<leader>hi", "<cmd>IlluminateToggle<CR>", desc = "Toggle Overall Word Illuminate" },
            { "<leader>hb", "<cmd>IlluminateToggleBuf<CR>", desc = "Toggle Local Buffer Word Illuminate" },
        },
    },
    -- 启动界面
    {
        -- {
        --     import = "plugins.extras.ui.starter",
        -- },
        {
            import = "plugins.extras.ui.alpha",
        },
        -- {
        --     import = "plugins.extras.ui.dashboard",
        -- },
    },
    -- 预定义布局
    {
        import = "plugins.extras.ui.edgy",
    },
    -- 彩虹括号
    {
        import = "plugins.extras.ui.rainbow",
    },
    -- 16进制颜色
    {
        import = "plugins.extras.ui.colorizer",
    },
    -- 搜索高亮条目
    {
        import = "plugins.extras.ui.hlslens",
    },
    -- 缩进样式
    {
        import = "plugins.extras.ui.indentstyle",
    },
    -- 注释美化
    -- {
    --     import = "plugins.extras.ui.annotbox",
    -- },
}
