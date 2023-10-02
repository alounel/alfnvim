return {
    -- 自动保存
    {
        "okuuva/auto-save.nvim",
        event = { "InsertLeave", "BufWinLeave" },
        keys = {
            { "<leader>at", "<cmd>ASToggle<CR>", desc = "Toggle Auto Save" },
        },
        opts = {
            debug = true,
        },
    },
    -- 自动恢复光标位置
    {
        "vladdoster/remember.nvim",
        lazy = true,
        event = "BufReadPost",
        opts = {
            --这些 buffer 类型不记录光标位置
            ignore_buftype = { "quickfix", "nofile", "help", "starter" },
            -- 这些文件类型不记录光标位置
            ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit" },
            -- 代码折叠时，恢复光标时展开
            open_folds = true,
        },
    },
    -- 自动匹配括号
    {
        "windwp/nvim-autopairs",
        event = { "InsertEnter", "CmdlineEnter" },
        -- 使用treesitter来检查
        config = function()
            local npairs = require("nvim-autopairs")
            local Rule = require("nvim-autopairs.rule")

            npairs.setup({
                disable_filetype = { "TelescopePrompt", "spectre_panel" },
                check_ts = true,
                ts_config = {
                    lua = { "string" },
                    javascript = { "template_string" },
                    java = false,
                },
                enable_check_bracket_line = false,
                fast_wrap = {
                    map = "<M-e>",
                    chars = { "{", "[", "(", '"', "'" },
                    pattern = [=[[%'%"%>%]%)%}%,]]=],
                    end_key = "$",
                    keys = "qwertyuiopzxcvbnmasdfghjkl",
                    check_comma = true,
                    highlight = "Search",
                    highlight_grey = "Comment",
                },
            })
            local ts_conds = require("nvim-autopairs.ts-conds")
            npairs.add_rules({
                Rule("%", "%", "lua"):with_pair(ts_conds.is_ts_node({ "string", "comment" })),
                Rule("$", "$", "lua"):with_pair(ts_conds.is_not_ts_node({ "function" })),
            })
        end,
    },
    -- 自动缩进样式检测
    {
        "NMAC427/guess-indent.nvim",
        lazy = true,
        keys = {
            { "<leader>si", "<cmd>GuessIndent<CR>", desc = "Guess Indent Check" },
        },
        opts = {
            filetype_exclude = {
                "netrw",
                "tutor",
                "neo-tree",
                "aerial",
                "Outline",
            },
            buftype_exclude = {
                "help",
                "nofile",
                "terminal",
                "prompt",
                "qf",
                "Trouble",
                "log",
            },
        },
    },
}
