return {
    -- 自动保存
    {
        "okuuva/auto-save.nvim",
        event = { "InsertLeave", "BufWinLeave" },
        keys = {
            { "<leader>at", "<cmd>ASToggle<CR>", desc = "Toggle Auto Save" },
        },
        opts = {
            condition = function(buf)
                local fn = vim.fn
                local utils = require("auto-save.utils.data")
                local exclude_filetypes = {
                    "neo-tree",
                    "Trouble",
                    "Outline",
                    "aerial",
                    "sagaoutline",
                    "starter",
                    "alpha",
                    "dashboard",
                    "qf",
                    "noice",
                    "notify",
                    "NeogitStatus",
                }

                -- 不保存指定文件类型
                if utils.not_in(fn.getbufvar(buf, "&filetype"), exclude_filetypes) then
                    return true
                end
                return false
            end,
        },
    },
    -- 自动恢复光标位置
    {
        "vladdoster/remember.nvim",
        lazy = true,
        event = "BufReadPost",
        opts = {
            ignore_buftype = {
                "acwrite",
                "quickfix",
                "nofile",
                "nowrite",
                "help",
                "terminal",
                "popup",
                "main",
                "prompt",
            },
            ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit", "starter", "alpha" },
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
}
