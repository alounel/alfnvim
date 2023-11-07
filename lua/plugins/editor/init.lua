return {
    -- 跳转
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        keys = {
            {
                "s",
                mode = { "n", "x", "o" },
                function()
                    require("flash").jump()
                end,
                desc = "Flash",
            },
            {
                "S",
                mode = { "n", "o", "x" },
                function()
                    require("flash").treesitter()
                end,
                desc = "Flash Treesitter",
            },
            {
                "r",
                mode = "o",
                function()
                    require("flash").remote()
                end,
                desc = "Remote Flash",
            },
            {
                "R",
                mode = { "o", "x" },
                function()
                    require("flash").treesitter_search()
                end,
                desc = "Treesitter Search",
            },
            {
                "<c-s>",
                mode = { "c" },
                function()
                    require("flash").toggle()
                end,
                desc = "Toggle Flash Search",
            },
        },
        opts = {
            jump = {
                pos = "ranger",
                register = true,
            },
            label = {
                rainbow = {
                    enabled = true,
                },
            },
            modes = {
                char = {
                    jump_labels = true,
                },
            },
        },
    },
    -- flash配置telescpe
    {
        "nvim-telescope/telescope.nvim",
        optional = true,
        opts = function(_, opts)
            if not require("config.util").has("flash.nvim") then
                return
            end
            local function flash(prompt_bufnr)
                require("flash").jump({
                    pattern = "^",
                    label = { after = { 0, 0 } },
                    search = {
                        mode = "search",
                        exclude = {
                            function(win)
                                return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "TelescopeResults"
                            end,
                        },
                    },
                    action = function(match)
                        local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
                        picker:set_selection(match.pos[1] - 1)
                    end,
                })
            end
            opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
                mappings = { n = { s = flash }, i = { ["<c-s>"] = flash } },
            })
        end,
    },
    -- 文本移动
    {
        "hinell/move.nvim",
        lazy = true,
        keys = {
            { "<M-j>", mode = { "n", "x" }, desc = "Down Move" },
            { "<M-k>", mode = { "n", "x" }, desc = "Up Move" },
            { "<M-R>", mode = { "n", "v" }, desc = "Right Move" },
            { "<M-E>", mode = { "n", "v" }, desc = "Left Move" },
            { "<leader>wl", desc = "Char Right Move" },
            { "<leader>wh", desc = "Char Left Move" },
        },
        config = function()
            local kopts = { noremap = true, silent = true }
            vim.keymap.set("n", "<M-j>", ":MoveLine 1<CR>", kopts)
            vim.keymap.set("n", "<M-k>", ":MoveLine -1<CR>", kopts)
            vim.keymap.set("n", "<M-R>", ":MoveHchar 1", kopts)
            vim.keymap.set("n", "<M-E>", ":MoveHchar -1<CR>", kopts)
            vim.keymap.set("n", "<leader>wl", ":MoveWord 1<CR>", kopts)
            vim.keymap.set("n", "<leader>wh", ":MoveWord -1<CR>", kopts)

            vim.keymap.set("x", "<M-j>", ":MoveBlock 1<CR>", kopts)
            vim.keymap.set("x", "<M-k>", ":MoveBlock -1<CR>", kopts)
            vim.keymap.set("v", "<M-R>", ":MoveHBlock 1<CR>", kopts)
            vim.keymap.set("v", "<M-E>", ":MoveHBlock -1<CR>", kopts)
        end,
    },
    -- 文本替换
    {
        "nvim-pack/nvim-spectre",
        lazy = true,
        cmd = "Spectre",
        keys = {
            { "<leader>rg", desc = "Toggle Spectre" },
            { "<leader>rw", desc = "Search Current Word" },
            { "<leader>rw", mode = "v", desc = "Search Current Word" },
            { "<leader>rf", desc = "Search On Current File" },
        },
        config = function()
            require("spectre").setup({
                open_cmd = "noswapfile vnew",
                live_update = true,
                is_block_ui_break = true,
                mapping = {
                    ["toggle_line"] = {
                        map = "<leader>ra",
                    },
                    ["enter_file"] = {
                        map = "<CR>",
                    },
                    ["send_to_qf"] = {
                        map = "<leader>rq",
                    },
                    ["replace_cmd"] = {
                        map = "<leader>rd",
                    },
                    ["show_option_menu"] = {
                        map = "<leader>re",
                    },
                    ["run_current_replace"] = {
                        map = "<leader>rr",
                    },
                    ["run_replace"] = {
                        map = "<leader>rp",
                    },
                    ["change_view_mode"] = {
                        map = "<leader>ri",
                    },
                    ["change_replace_sed"] = {
                        map = "<leader>ru",
                    },
                    ["change_replace_oxi"] = {
                        map = "<leader>rx",
                    },
                    ["toggle_live_update"] = {
                        map = "<leader>rj",
                    },
                    ["toggle_ignore_case"] = {
                        map = "<leader>rk",
                    },
                    ["toggle_ignore_hidden"] = {
                        map = "<leader>rs",
                    },
                    ["resume_last_search"] = {
                        map = "<leader>rl",
                    },
                },
            })
            vim.keymap.set("n", "<leader>rg", "<cmd>lua require('spectre').toggle()<CR>")
            vim.keymap.set("n", "<leader>rw", "<cmd>lua require('spectre').open_visual({select_word=true})<CR>")
            vim.keymap.set("v", "<leader>rw", "<esc><cmd>lua require('spectre').open_visual()<CR>")
            vim.keymap.set("n", "<leader>rf", "<cmd>lua require('spectre').open_file_search({select_word=true})<CR>")
        end,
    },
    -- 字符、颜色、数字增量/减量
    {
        "monaqa/dial.nvim",
        lazy = true,
        keys = {
            { "<M-c>", desc = "Word Increment" },
            { "<M-d>", desc = "Word Decrement" },
            { "<M-f>", desc = "Color Increment" },
            { "<M-g>", desc = "Color Decrement" },
            { "<M-x>", desc = "Date Increment" },
            { "<M-y>", desc = "Date Decrement" },
        },
        config = function()
            local augend = require("dial.augend")

            require("dial.config").augends:register_group({
                -- 字符循环跳转
                chars_dial = {
                    augend.constant.new({ elements = { "true", "false" }, word = true, cyclic = true }),
                    augend.constant.new({ elements = { "and", "or", "not" }, word = true, cyclic = true }),
                    augend.constant.new({ elements = { "if", "else" }, word = true, cyclic = true }),
                    augend.constant.new({ elements = { "yes", "no" }, word = true, cyclic = true }),
                    augend.constant.new({ elements = { "on", "off" }, word = true, cyclic = true }),
                    augend.constant.new({ elements = { "left", "right" }, word = true, cyclic = true }),
                    augend.constant.new({ elements = { "out", "in" }, word = true, cyclic = true }),
                    augend.constant.new({ elements = { "up", "down" }, word = true, cyclic = true }),
                    augend.constant.new({ elements = { "disable", "enable" }, word = true, cyclic = true }),
                    augend.constant.new({ elements = { "output", "input" }, word = true, cyclic = true }),
                    augend.constant.new({ elements = { "front", "rear" }, word = true, cyclic = true }),
                    augend.constant.new({ elements = { "start", "end" }, word = true, cyclic = true }),
                    augend.constant.new({ elements = { "+", "-" }, word = false, cyclic = true }),
                    augend.constant.new({ elements = { "*", "/" }, word = false, cyclic = true }),
                    augend.constant.new({ elements = { ">", "<" }, word = false, cyclic = true }),
                    augend.constant.new({ elements = { "=", "!=" }, word = false, cyclic = true }),
                    augend.constant.new({ elements = { "|", "&" }, word = false, cyclic = true }),
                    augend.constant.new({ elements = { "||", "&&" }, word = false, cyclic = true }),
                    augend.constant.new({
                        elements = { "0", "1", "2", "3", "4", "5", "6", "7", "8", "9" },
                        word = false,
                        cyclic = true,
                    }),
                },
                -- 颜色增加或减少
                color_dial = {
                    augend.hexcolor.new({
                        case = "lower",
                    }),
                },
                -- 日期增加/减少
                date_dial = {
                    augend.date.new({
                        pattern = "%Y/%m/%d",
                        default_kind = "day",
                        only_valid = true,
                        word = false,
                    }),
                    augend.date.new({
                        pattern = "%Y-%m-%d",
                        default_kind = "day",
                        only_valid = true,
                        word = false,
                    }),
                },
            })
            vim.keymap.set("n", "<M-c>", function()
                require("dial.map").manipulate("increment", "normal", "chars_dial")
            end, { noremap = true })
            vim.keymap.set("n", "<M-d>", function()
                require("dial.map").manipulate("decrement", "normal", "chars_dial")
            end, { noremap = true })
            vim.keymap.set("n", "<M-f>", function()
                require("dial.map").manipulate("increment", "normal", "color_dial")
            end, { noremap = true })
            vim.keymap.set("n", "<M-g>", function()
                require("dial.map").manipulate("decrement", "normal", "color_dial")
            end, { noremap = true })
            vim.keymap.set("n", "<M-x>", function()
                require("dial.map").manipulate("increment", "normal", "date_dial")
            end, { noremap = true })
            vim.keymap.set("n", "<M-y>", function()
                require("dial.map").manipulate("decrement", "normal", "date_dial")
            end, { noremap = true })
        end,
    },
    -- 处理空格和空白行
    {
        "echasnovski/mini.trailspace",
        version = false,
        lazy = true,
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require("mini.trailspace").setup()
        end,
        init = function()
            vim.api.nvim_create_autocmd("FileType", {
                pattern = {
                    "aerial",
                    "alpha",
                    "dashboard",
                    "help",
                    "jqx",
                    "lazy",
                    "lazyterm",
                    "mason",
                    "neo-tree",
                    "notify",
                    "qf",
                    "sagaoutline",
                    "starter",
                    "Trouble",
                    "trouble",
                    "toggleterm",
                },
                callback = function()
                    vim.b.minitrailspace_disable = true
                end,
            })
        end,
        keys = {
            { "<leader>rb", "<cmd>lua MiniTrailspace.trim()<CR>", desc = "Trail All End of Line Space" },
            { "<leader>rc", "<cmd>lua MiniTrailspace.trim_last_lines()<CR>", desc = "Trail All Blank Line" },
        },
    },
    -- 格式化
    {
        import = "plugins.extras.editor.formatter",
    },
    -- 诊断
    {
        import = "plugins.extras.editor.linter",
    },
    -- 参数替换
    {
        import = "plugins.extras.editor.replacer",
    },
    -- 自动处理工具
    {
        import = "plugins.extras.editor.autotools",
    },
    -- 修改定界符
    {
        import = "plugins.extras.editor.surround",
    },
    -- 文本标记
    {
        import = "plugins.extras.editor.stamps",
    },
}
