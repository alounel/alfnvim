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

            local htop = Terminal:new({
                cmd = "htop",
                hidden = true,
                direction = "float",
                float_opts = {
                    border = "curved",
                },
            })

            function _htop_toggle()
                htop:toggle()
            end

            local procs = Terminal:new({
                cmd = "procs -t",
                hidden = true,
                direction = "float",
                float_opts = {
                    border = "curved",
                },
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
                ["]"] = { name = "+next" },
                ["["] = { name = "+prev" },
                ["<leader>a"] = { name = "+outline" },
                ["<leader>b"] = { name = "+buffer" },
                ["<leader>c"] = { name = "+command" },
                ["<leader>d"] = { name = "+debug/diff" },
                ["<leader>dl"] = { name = "+lua debug" },
                ["<leader>dv"] = { name = "+diff" },
                ["<leader>dw"] = { name = "+widget debug" },
                ["<leader>e"] = { name = "+generate/editor" },
                ["<leader>ep"] = { name = "+compiler" },
                ["<leader>f"] = { name = "+find/format" },
                ["<leader>fd"] = { name = "+legendary" },
                ["<leader>fl"] = { name = "+fzf" },
                ["<leader>fs"] = { name = "+telescope" },
                ["<leader>g"] = { name = "+git" },
                ["<leader>gn"] = { name = "+neogit" },
                ["<leader>gt"] = { name = "+tinygit" },
                ["<leader>h"] = { name = "+highlight" },
                ["<leader>hr"] = { name = "+hshighlight" },
                ["<leader>i"] = { name = "icon/illuminate" },
                ["<leader>j"] = { name = "+json/splj" },
                ["<leader>k"] = { name = "+context" },
                ["<leader>l"] = { name = "+lsp" },
                ["<leader>lg"] = { name = "+lspsaga" },
                ["<leader>m"] = { name = "+manager/mark" },
                ["<leader>mh"] = { name = "+harpoon" },
                ["<leader>mg"] = { name = "+grapple" },
                ["<leader>n"] = { name = "+filetree" },
                ["<leader>p"] = { name = "+portal/process" },
                ["<leader>pc"] = { name = "+changelist" },
                ["<leader>pg"] = { name = "+grapple" },
                ["<leader>ph"] = { name = "+harpoon" },
                ["<leader>pj"] = { name = "+jumplist" },
                ["<leader>pq"] = { name = "+quickfix" },
                ["<leader>q"] = { name = "+session" },
                ["<leader>r"] = { name = "+replace/rule" },
                ["<leader>rr"] = { name = "+muren" },
                ["<leader>rs"] = { name = "+switch" },
                ["<leader>s"] = { name = "+show/style" },
                ["<leader>sc"] = { name = "+clangdinfo" },
                ["<leader>t"] = { name = "+trail/terminal/todo" },
                ["<leader>td"] = { name = "+todo" },
                ["<leader>tt"] = { name = "+terminal" },
                ["<leader>u"] = { name = "+ui/message" },
                ["<leader>w"] = { name = "+window" },
                ["<leader>wf"] = { name = "+focus" },
                ["<leader>x"] = { name = "+diagnostics/quickfix" },
                ["<leader>xp"] = { name = "+replacer" },
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
            exclude = { "help", "log", "tex", "text", "vimdoc" },
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
    -- 自动动作完成
    {
        import = "plugins.extras.fulfill",
    },
    -- 平滑滚动
    {
        import = "plugins.extras.utils.scroll",
    },
    -- 查看特定行内容
    {
        import = "plugins.extras.utils.numb",
    },
    -- 函数，命令，按键绑定示例
    {
        import = "plugins.extras.utils.legendary",
    },
    -- 测量启动时间
    {
        import = "plugins.extras.utils.startuptime",
    },
}
