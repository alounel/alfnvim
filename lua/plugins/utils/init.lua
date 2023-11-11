return {
    -- 终端
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        lazy = true,
        cmd = "ToggleTerm",
        keys = {
            { "<leader>ttg", "<cmd>ToggleTerm<CR>", desc = "Toggle Terminal" },
            { "<leader>tta", "<cmd>ToggleTermToggleAll<CR>", desc = "Toggle All Terminal" },
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
                ["]"] = { name = "+next" },
                ["["] = { name = "+prev" },
                ["<leader><tab>"] = { name = "+tabs" },
                ["<leader>a"] = { name = "+auto/outline" },
                ["<leader>b"] = { name = "+buffer" },
                ["<leader>c"] = { name = "+command" },
                ["<leader>d"] = { name = "+debug/diff" },
                ["<leader>dv"] = { name = "+diff" },
                ["<leader>dw"] = { name = "+widget debug" },
                ["<leader>e"] = { name = "+generate/editor" },
                ["<leader>ep"] = { name = "+compiler" },
                ["<leader>f"] = { name = "+find" },
                ["<leader>g"] = { name = "+git" },
                ["<leader>gn"] = { name = "+neogit" },
                ["<leader>h"] = { name = "+highlight" },
                ["<leader>i"] = { name = "+icon/rename" },
                ["<leader>j"] = { name = "+json/yaml" },
                ["<leader>k"] = { name = "+context/spj" },
                ["<leader>l"] = { name = "+lsp" },
                ["<leader>lg"] = { name = "+lspsaga" },
                ["<leader>m"] = { name = "+manager/mark" },
                ["<leader>n"] = { name = "+filetree" },
                ["<leader>o"] = { name = "+option" },
                ["<leader>p"] = { name = "+portal" },
                ["<leader>q"] = { name = "+fuzzy/session" },
                ["<leader>r"] = { name = "+replace" },
                ["<leader>rr"] = { name = "+muren" },
                ["<leader>s"] = { name = "+show/search" },
                ["<leader>sc"] = { name = "+clangdinfo" },
                ["<leader>t"] = { name = "+terminal/todo" },
                ["<leader>td"] = { name = "+todo" },
                ["<leader>tt"] = { name = "+toggleterm" },
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
            exclude = { "norg", "log", "markdown", "tex", "text" },
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
}
