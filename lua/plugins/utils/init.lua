-- 功能加强和优化
return {
    -- 改进了Yank和Put功能
    {
        "gbprod/yanky.nvim",
        lazy = true,
        event = { "BufReadPost", "BufNewFile" },
        keys = {
            { "<leader>yr", "<cmd>YankyRingHistory<CR>", desc = "Show Yank History" },
            { "<leader>yc", "<cmd>YankyClearHistory<CR>", desc = "Clear Yank History" },
        },
        dependencies = { "sqlite.lua" },
        config = function()
            require("yanky").setup({
                ring = {
                    history_length = 200,
                    storage = "sqlite",
                },
                preserve_cursor_position = {
                    enable = true,
                },
            })
            vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
            vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
            vim.keymap.set({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)")
            vim.keymap.set({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)")

            vim.keymap.set({ "n", "x" }, "y", "<Plug>(YankyYank)")

            vim.keymap.set("n", "]p", "<Plug>(YankyPutIndentAfterLinewise)")
            vim.keymap.set("n", "[p", "<Plug>(YankyPutIndentBeforeLinewise)")
            vim.keymap.set("n", "]P", "<Plug>(YankyPutIndentAfterLinewise)")
            vim.keymap.set("n", "[P", "<Plug>(YankyPutIndentBeforeLinewise)")

            vim.keymap.set("n", ">p", "<Plug>(YankyPutIndentAfterShiftRight)")
            vim.keymap.set("n", "<p", "<Plug>(YankyPutIndentAfterShiftLeft)")
            vim.keymap.set("n", ">P", "<Plug>(YankyPutIndentBeforeShiftRight)")
            vim.keymap.set("n", "<P", "<Plug>(YankyPutIndentBeforeShiftLeft)")

            vim.keymap.set("n", "=p", "<Plug>(YankyPutAfterFilter)")
            vim.keymap.set("n", "=P", "<Plug>(YankyPutBeforeFilter)")
        end,
    },
    -- 预览寄存器内容
    {
        "tversteeg/registers.nvim",
        name = "registers",
        lazy = true,
        cmd = "Registers",
        keys = {
            { '"', mode = { "n", "v" } },
            { "<C-R>", mode = "i" },
        },
        opts = {},
    },
    -- 弹出按键绑定和输入命令窗口
    {
        "folke/which-key.nvim",
        lazy = true,
        event = "VeryLazy",
        opts = {
            window = {
                border = "shadow",
            },
            defaults = {
                mode = { "n", "v" },
                ["g"] = { name = "+goto" },
                ["]"] = { name = "+next" },
                ["["] = { name = "+prev" },
                ["<leader>a"] = { name = "+outline" },
                ["<leader>b"] = { name = "+buffer" },
                ["<leader>c"] = { name = "+command" },
                ["<leader>cd"] = { name = "+legend" },
                ["<leader>d"] = { name = "+debug/diff" },
                ["<leader>dl"] = { name = "+lua debug" },
                ["<leader>dv"] = { name = "+diff" },
                ["<leader>dw"] = { name = "+widget debug" },
                ["<leader>e"] = { name = "+generate/editor" },
                ["<leader>ep"] = { name = "+compiler" },
                ["<leader>f"] = { name = "+find/format" },
                ["<leader>fs"] = { name = "+telescope" },
                ["<leader>fm"] = { name = "+format" },
                ["<leader>g"] = { name = "+git" },
                ["<leader>ga"] = { name = "+cellular" },
                ["<leader>gf"] = { name = "+conflict" },
                ["<leader>gh"] = { name = "+hack" },
                ["<leader>gn"] = { name = "+neogit" },
                ["<leader>h"] = { name = "+highlight" },
                ["<leader>hr"] = { name = "+hshighlight" },
                ["<leader>i"] = { name = "icon/illuminate" },
                ["<leader>j"] = { name = "+json/splj" },
                ["<leader>l"] = { name = "+lsp" },
                ["<leader>lg"] = { name = "+lspsaga" },
                ["<leader>m"] = { name = "+manager/mark" },
                ["<leader>mh"] = { name = "+harpoon" },
                ["<leader>mg"] = { name = "+grapple" },
                ["<leader>n"] = { name = "+notice/dir" },
                ["<leader>nl"] = { name = "+lspconfig" },
                ["<leader>nu"] = { name = "+null-ls" },
                ["<leader>no"] = { name = "+noice" },
                ["<leader>p"] = { name = "+portal/process" },
                ["<leader>pc"] = { name = "+changelist" },
                ["<leader>pg"] = { name = "+grapple" },
                ["<leader>ph"] = { name = "+harpoon" },
                ["<leader>pj"] = { name = "+jumplist" },
                ["<leader>pq"] = { name = "+quickfix" },
                ["<leader>q"] = { name = "+session" },
                ["<leader>r"] = { name = "+reach/replace" },
                ["<leader>rn"] = { name = "+muren" },
                ["<leader>s"] = { name = "+show/style/fixed" },
                ["<leader>sk"] = { name = "+fixed" },
                ["<leader>t"] = { name = "+trail/terminal/todo" },
                ["<leader>td"] = { name = "+todo" },
                ["<leader>tt"] = { name = "+terminal" },
                ["<leader>w"] = { name = "+window" },
                ["<leader>x"] = { name = "+diagnostics/quickfix" },
                ["<leader>y"] = { name = "+operate/yank" },
            },
        },
        config = function(_, opts)
            local wk = require("which-key")
            wk.setup(opts)
            wk.register(opts.defaults)
        end,
    },
    -- 测量启动时间
    {
        "dstein64/vim-startuptime",
        lazy = true,
        keys = {
            { "<leader>st", "<cmd>StartupTime<CR>", desc = "Show Neovim Start Time" },
        },
    },
    -- 更好的模式切换
    {
        "max397574/better-escape.nvim",
        lazy = true,
        event = "InsertEnter",
        opts = {
            mapping = { "jk", "jj" },
            timeout = vim.o.timeoutlen,
            clear_empty_lines = false,
            keys = "<Esc>",
        },
    },
    -- 平滑滚动
    {
        "karb94/neoscroll.nvim",
        event = "VimEnter",
        opts = {},
    },
    -- 输入命令查看缓冲区
    {
        "nacro90/numb.nvim",
        lazy = true,
        event = "CmdlineEnter",
        opts = {
            number_only = true,
        },
        keys = {
            { "<leader>bc", "<cmd>lua require('numb').setup()<CR>", desc = "Start Command Show Current Buffer" },
            { "<leader>bk", "<cmd>lua require('numb').disable()<CR>", desc = "Disable Command Show Current Buffer" },
        },
    },
    -- 改进位置列表导航
    {
        "cbochs/portal.nvim",
        lazy = true,
        cmd = "Portal",
        keys = {
            { "<leader>pjb", "<cmd>Portal jumplist backward<CR>", desc = "Portal Jumplist Backward" },
            { "<leader>pjf", "<cmd>Portal jumplist forward<CR>", desc = "Portal Jumplist Forward" },
            { "<leader>phb", "<cmd>Portal harpoon backward<CR>", desc = "Portal Harpoon Backward" },
            { "<leader>phf", "<cmd>Portal harpoon forward<CR>", desc = "Portal Harpoon Forward" },
            { "<leader>pqb", "<cmd>Portal quickfix backward<CR>", desc = "Portal Quickfix Backward" },
            { "<leader>pqf", "<cmd>Portal quickfix forward<CR>", desc = "Portal Quickfix Forward" },
            { "<leader>pcb", "<cmd>Portal changelist backward<CR>", desc = "Portal Changelist Backward" },
            { "<leader>pcf", "<cmd>Portal changelist forward<CR>", desc = "Portal Changelist Forward" },
            { "<leader>pgb", "<cmd>Portal grapple backward<CR>", desc = "Portal Grapple Backward" },
            { "<leader>pgf", "<cmd>Portal grapple forward<CR>", desc = "Portal Grapple Forward" },
        },
        dependencies = {
            { "harpoon" },
            { "grapple.nvim" },
        },
    },
    -- 改进缓冲区删除
    {
        "ojroques/nvim-bufdel",
        lazy = true,
        keys = {
            { "<leader>bd", "<cmd>BufDel<CR>", desc = "Close Current Buffer" },
            { "<leader>bi", "<cmd>BufDel!<CR>", desc = "Close Current Buffer And Ignore Modify" },
            { "<leader>ba", "<cmd>BufDelAll<CR>", desc = "Close All Buffers" },
            { "<leader>bo", "<cmd>BufDelOthers<CR>", desc = "Close Others Buffer" },
            { "<leader>bs", ":BufDel ", desc = "Close Specify Buffer(Name Number Use '')" },
        },
        opts = {
            quit = false,
        },
    },
    -- 页面切换
    {
        "toppair/reach.nvim",
        lazy = true,
        keys = {
            { "<leader>rb", "<cmd>ReachOpen buffers<CR>", desc = "Switch Buffers Page" },
            { "<leader>rc", "<cmd>ReachOpen colorschemes<CR>", desc = "Switch Scheme Page" },
            { "<leader>rm", "<cmd>ReachOpen marks<CR>", desc = "Switch Mark Page" },
            { "<leader>rt", "<cmd>ReachOpen tabpages<CR>", desc = "Switch Tab Page" },
        },
        opts = {},
    },
    -- 命令面板
    {
        "mrjones2014/legendary.nvim",
        lazy = true,
        keys = {
            { "<leader>cdy", "<cmd>Legendary<CR>", desc = "Show Legendary" },
            { "<leader>cdk", "<cmd>Legendary keymaps<CR>", desc = "Search Keymaps" },
            { "<leader>cdc", "<cmd>Legendary commands<CR>", desc = "Search Commands" },
            { "<leader>cdf", "<cmd>Legendary functions<CR>", desc = "Search Functions" },
            { "<leader>cda", "<cmd>Legendary autocmds<CR>", desc = "Search Autocmds" },
        },
        dependencies = { "telescope.nvim" },
        opts = {
            lazy_nvim = {
                auto_register = true,
            },
            which_key = {
                auto_register = true,
            },
        },
    },
    -- 非活动代码变暗
    {
        "folke/twilight.nvim",
        lazy = true,
        keys = {
            { "<leader>el", "<cmd>Twilight<CR>", desc = "Inactive Code Shade" },
        },
        opts = {
            dimming = {
                inactive = true,
            },
            exclude = { "txt", "markdown", "log", "help" },
        },
    },
    -- 禅模式
    {
        "folke/zen-mode.nvim",
        lazy = true,
        keys = {
            { "<leader>ez", "<cmd>ZenMode<CR>", desc = "Zen Mode" },
        },
        opts = {},
    },
    -- 尾随空白行
    {
        "echasnovski/mini.trailspace",
        version = false,
        lazy = true,
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require("mini.trailspace").setup()
        end,
        keys = {
            { "<leader>te", ":lua MiniTrailspace.trim()<CR>", desc = "Trail All Space" },
            { "<leader>tn", ":lua MiniTrailspace.trim_last_lines()<CR>", desc = "Trail All Space Lines" },
        },
    },
}
