return {
    -- 终端
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        lazy = true,
        cmd = "ToggleTerm",
        keys = {
            { "<leader>ttf", "<cmd>ToggleTerm<CR>", desc = "Toggle Terminal" },
            { "<leader>ttg", "<cmd>ToggleTermToggleAll<CR>", desc = "Toggle All Terminal" },
            { "<leader>ttv", "<cmd>ToggleTerm direction=vertical size=45<CR>", desc = "Open Vertical Terminal" },
            { "<leader>tth", "<cmd>ToggleTerm direction=horizontal<CR>", desc = "Open Horizontal Terminal" },
            { "<leader>ttb", "<cmd>ToggleTerm direction=tab<CR>", desc = "Open Tab Terminal" },
            { "<leader>ttl", "<cmd>lua _lazygit_toggle()<CR>", desc = "Open Lazygit Terminal" },
            { "<leader>ttp", "<cmd>lua _htop_toggle()<CR>", desc = "Open Htop Terminal" },
            { "<leader>ttr", "<cmd>lua _procs_toggle()<CR>", desc = "Open Procs Terminal" },
            { "<leader>tte", ":TermExec ", desc = "Use Custom Operate Open Terminal" },
            { "<leader>ttc", ":ToggleTermSendCurrentLine ", desc = "Send Current Line To The Terminal" },
            { "<leader>tts", ":ToggleTermSendVisualLines ", desc = "Send Visual Line To The Terminal" },
            { "<leader>ttn", ":ToggleTermSendVisualSelection ", desc = "Send Visual Select Line To The Terminal" },
        },
        config = function()
            local Terminal = require("toggleterm.terminal").Terminal

            -- Lazygit终端
            local lazygit = Terminal:new({
                cmd = "lazygit",
                hidden = true,
                dir = "git_dir",
                direction = "float",
                float_opts = {
                    border = "single",
                },
                on_open = function(term)
                    vim.cmd("startinsert!")
                    vim.api.nvim_buf_set_keymap(
                        term.bufnr,
                        "n",
                        "q",
                        "<cmd>close<CR>",
                        { noremap = true, silent = true }
                    )
                end,
                on_close = function(term)
                    vim.cmd("startinsert!")
                end,
            })
            function _lazygit_toggle()
                lazygit:toggle()
            end

            -- htop终端
            local htop = Terminal:new({
                cmd = "htop",
                hidden = true,
                direction = "float",
                float_opts = {
                    border = "curved",
                },
                on_open = function(term)
                    vim.cmd("startinsert!")
                    vim.api.nvim_buf_set_keymap(
                        term.bufnr,
                        "n",
                        "q",
                        "<cmd>close<CR>",
                        { noremap = true, silent = true }
                    )
                end,
                on_close = function(term)
                    vim.cmd("startinsert!")
                end,
            })
            function _htop_toggle()
                htop:toggle()
            end

            -- procs终端
            local procs = Terminal:new({
                cmd = "procs -t",
                hidden = true,
                direction = "float",
                float_opts = {
                    border = "curved",
                },
                on_open = function(term)
                    vim.cmd("startinsert!")
                    vim.api.nvim_buf_set_keymap(
                        term.bufnr,
                        "n",
                        "q",
                        "<cmd>close<CR>",
                        { noremap = true, silent = true }
                    )
                end,
                on_close = function(term)
                    vim.cmd("startinsert!")
                end,
            })
            function _procs_toggle()
                procs:toggle()
            end

            require("toggleterm").setup({
                persist_size = false,
                direction = "float",
                float_opts = {
                    border = "shadow",
                },
                winbar = {
                    enable = true,
                },
            })
        end,
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
                ["z"] = { name = "+fold/scroll" },
                ["]"] = { name = "+next" },
                ["["] = { name = "+prev" },
                ["<leader><tab>"] = { name = "+tabs" },
                ["<leader>a"] = { name = "+auto/outline" },
                ["<leader>b"] = { name = "+buffer" },
                ["<leader>c"] = { name = "+command" },
                ["<leader>d"] = { name = "+debug/diff" },
                ["<leader>dl"] = { name = "+lua debug" },
                ["<leader>dv"] = { name = "+diff" },
                ["<leader>dw"] = { name = "+widget debug" },
                ["<leader>e"] = { name = "+generate/editor" },
                ["<leader>ep"] = { name = "+compiler" },
                ["<leader>f"] = { name = "+find" },
                ["<leader>g"] = { name = "+git" },
                ["<leader>gn"] = { name = "+neogit" },
                ["<leader>h"] = { name = "+highlight" },
                ["<leader>i"] = { name = "picker" },
                ["<leader>j"] = { name = "+json/splj" },
                ["<leader>k"] = { name = "+context" },
                ["<leader>l"] = { name = "+lsp" },
                ["<leader>lg"] = { name = "+lspsaga" },
                ["<leader>m"] = { name = "+manager/mark" },
                ["<leader>mh"] = { name = "+harpoon" },
                ["<leader>n"] = { name = "+filetree" },
                ["<leader>p"] = { name = "+portal" },
                ["<leader>q"] = { name = "+session" },
                ["<leader>r"] = { name = "+replace" },
                ["<leader>rr"] = { name = "+muren" },
                ["<leader>s"] = { name = "+show/style" },
                ["<leader>sc"] = { name = "+clangdinfo" },
                ["<leader>t"] = { name = "+terminal/todo" },
                ["<leader>td"] = { name = "+todo" },
                ["<leader>tt"] = { name = "+terminal" },
                ["<leader>u"] = { name = "+ui/message" },
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
    -- 模式切换
    {
        "max397574/better-escape.nvim",
        lazy = true,
        event = "InsertEnter",
        opts = {
            mapping = { "jk", "jj" },
            timeout = vim.go.timeoutlen,
            clear_empty_lines = false,
            keys = "<Esc>",
        },
    },
    -- 改进位置列表导航
    {
        "cbochs/portal.nvim",
        lazy = true,
        cmd = "Portal",
        keys = {
            { "<leader>pb", "<cmd>Portal jumplist backward<CR>", desc = "Jumplist Backward" },
            { "<leader>pc", "<cmd>Portal jumplist forward<CR>", desc = "Jumplist Forward" },
            { "<leader>pd", "<cmd>Portal quickfix forward<CR>", desc = "Quickfix Forward" },
            { "<leader>pe", "<cmd>Portal quickfix backward<CR>", desc = "Quickfix Backward" },
            { "<leader>pf", "<cmd>Portal changelist backward<CR>", desc = "Changelist Backward" },
            { "<leader>pg", "<cmd>Portal changelist forward<CR>", desc = "Changelist Forward" },
            { "<leader>ph", "<cmd>Portal harpoon backward<CR>", desc = "Harpoon Backward" },
            { "<leader>pi", "<cmd>Portal harpoon forward<CR>", desc = "Harpoon Forward" },
        },
        opts = {
            log_level = "error",
            window_options = {
                border = "rounded",
            },
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
    -- 非活动代码变暗
    {
        "folke/twilight.nvim",
        lazy = true,
        keys = {
            { "<leader>el", "<cmd>Twilight<CR>", desc = "Non active Code Shade" },
        },
        opts = {
            dimming = {
                inactive = true,
            },
            exclude = { "help", "log", "markdown", "tex", "text", "vimdoc" },
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
    -- 测量启动时间
    {
        import = "plugins.extras.utils.startuptime",
    },
}
