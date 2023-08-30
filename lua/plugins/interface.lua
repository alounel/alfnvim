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
    -- 显示界面
    {
        "echasnovski/mini.starter",
        version = false,
        event = "VimEnter",
        opts = function()
            local logo = table.concat({
                "███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗",
                "████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║",
                "██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║",
                "██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║",
                "██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║",
                "╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝",
            }, "\n")
            local pad = string.rep(" ", 0)
            local new_section = function(name, action, section)
                return { name = name, action = action, section = pad .. section }
            end

            local starter = require("mini.starter")
            local config = {
                evaluate_single = true,
                header = logo,
                items = {
                    new_section("Find file ", "Telescope find_files", "Inquiry"),
                    -- new_section("Recent files ",      "Telescope oldfiles",   "Inquiry"),
                    new_section("Grep text ", "Telescope live_grep", "Inquiry"),
                    new_section("Open last projects ", "Telescope projects", "Inquiry"),
                    new_section("MRU ", "Telescope frecency", "Inquiry"),
                    -- new_section("Settings ",          "e $MYVIMRC",           "Config"),
                    new_section("Session ", "lua require('persistence').load()", "Session"),
                    new_section("Lazy 鈴", "Lazy", "Config"),
                    new_section("New file ", "ene | startinsert", "Built-in"),
                    new_section("Quit ", "qa", "Built-in"),
                },
                content_hooks = {
                    starter.gen_hook.adding_bullet(pad .. "░ ", false),
                    starter.gen_hook.aligning("center", "center"),
                },
            }
            return config
        end,
        config = function(_, config)
            if vim.o.filetype == "lazy" then
                vim.cmd.close()
                vim.api.nvim_create_autocmd("User", {
                    pattern = "MiniStarterOpened",
                    callback = function()
                        require("lazy").show()
                    end,
                })
            end
            local starter = require("mini.starter")
            starter.setup(config)
        end,
    },
}
