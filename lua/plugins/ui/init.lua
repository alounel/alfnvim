return {
    -- 高度实验性插件
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        config = function()
            require("noice").setup({
                lsp = {
                    override = {
                        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                        ["vim.lsp.util.stylize_markdown"] = true,
                        ["cmp.entry.get_documentation"] = true,
                    },
                    hover = {
                        silent = true,
                    },
                },
                presets = {
                    bottom_search = true,
                    command_palette = true,
                    long_message_to_split = true,
                    inc_rename = true,
                    lsp_doc_border = true,
                },
                views = {
                    split = {
                        enter = true,
                    },
                },
                routes = {
                    filter = {
                        event = "msg_show",
                    },
                },
            })
        end,
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
        },
    },
    -- 精美弹窗
    {
        "rcarriga/nvim-notify",
        event = "VeryLazy",
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
    -- 显示十六进制颜色
    {
        "NvChad/nvim-colorizer.lua",
        lazy = true,
        keys = {
            { "<leader>hrh", "<cmd>ColorizerAttachToBuffer<CR>", desc = "Show Highlight" },
            { "<leader>hrr", "<cmd>ColorizerReloadAllBuffers<CR>", desc = "Load All Buffer HSHighlight" },
            { "<leader>hrd", "<cmd>ColorizerDetachFromBuffer<CR>", desc = "Detach Buffer HSHighlight" },
            { "<leader>hrt", "<cmd>ColorizerToggle<CR>", desc = "Toggle Buffer HSHighlight" },
        },
        opts = {
            filetypes = {
                "*",
                cmp_docs = { always_update = true },
            },
            user_default_options = {
                RRGGBBAA = true,
                AARRGGBB = true,
                tailwind = true,
            },
        },
    },
    -- 缩进样式
    {
        "shellRaining/hlchunk.nvim",
        lazy = true,
        event = { "BufReadPost", "BufNewFile" },
        opts = {},
    },
    -- 显示滚动条
    {
        "petertriho/nvim-scrollbar",
        event = "VeryLazy",
        config = function()
            local colors = {
                Handle = "#892E42",
                Search = "#FFC860",
                Error = "#FD6883",
                Warn = "#FFD886",
                Info = "#A9DC76",
                Hint = "#78DCE8",
                Misc = "#AB9DF2",
            }
            require("scrollbar").setup({
                handle = {
                    -- 滚动条颜色
                    color = colors.Handle,
                },
                marks = {
                    -- 诊断颜色
                    Search = { color = colors.Search },
                    Error = { color = colors.Error },
                    Warn = { color = colors.Warn },
                    Info = { color = colors.Info },
                    Hint = { color = colors.Hint },
                    Misc = { color = colors.Misc },
                },
                handlers = {
                    gitsigns = true,
                    search = true,
                },
            })
        end,
    },
    -- 彩虹括号
    {
        "HiPhish/rainbow-delimiters.nvim",
        lazy = true,
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            local rainbow_delimiters = require("rainbow-delimiters")
            require("rainbow-delimiters.setup")({
                strategy = {
                    [""] = rainbow_delimiters.strategy["global"],
                },
                query = {
                    [""] = "rainbow-delimiters",
                },
                highlight = {
                    "RainbowDelimiterRed",
                    "RainbowDelimiterYellow",
                    "RainbowDelimiterBlue",
                    "RainbowDelimiterOrange",
                    "RainbowDelimiterGreen",
                    "RainbowDelimiterViolet",
                    "RainbowDelimiterCyan",
                },
            })
        end,
    },
    -- 显示光标下相同词汇
    {
        "RRethy/vim-illuminate",
        lazy = true,
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require("illuminate").configure()
        end,
        keys = {
            { "<leader>ig", "<cmd>IlluminateToggle<CR>", desc = "Toggle Illuminate" },
            { "<leader>ib", "<cmd>IlluminateToggleBuf<CR>", desc = "Toggle Local Buffer Illuminate" },
        },
    },
    {
        import = "plugins.ui.launch",
    },
    {
        import = "plugins.ui.filetree",
    },
    {
        import = "plugins.ui.line",
    },
}

