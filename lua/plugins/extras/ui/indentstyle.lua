return {
    -- 缩进线
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        lazy = true,
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require("ibl").setup({
                scope = { enabled = false },
                indent = {
                    char = "│",
                    tab_char = "│",
                },
                exclude = {
                    filetypes = {
                        "help",
                        "starter",
                        "neo-tree",
                        "Trouble",
                        "trouble",
                        "lazy",
                        "mason",
                        "notify",
                        "toggleterm",
                    },
                },
            })
        end,
    },
    -- 可视化缩进范围
    {
        "echasnovski/mini.indentscope",
        version = false,
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            symbol = "│",
            options = { try_as_border = true },
        },
        init = function()
            vim.api.nvim_create_autocmd("FileType", {
                pattern = {
                    "help",
                    "alpha",
                    "dashboard",
                    "neo-tree",
                    "Trouble",
                    "trouble",
                    "lazy",
                    "mason",
                    "notify",
                    "toggleterm",
                    "lazyterm",
                },
                callback = function()
                    vim.b.miniindentscope_disable = true
                end,
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
                "norg",
                "aerial",
                "sagaoutline",
                "Trouble",
                "trouble",
                "qf",
                "tex",
                "text",
                "alpha",
                "starter",
                "dashboard",
            },
            buftype_exclude = {
                "help",
                "nofile",
                "terminal",
                "prompt",
                "quickfix",
            },
        },
    },
}
