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
                        "aerial",
                        "alpha",
                        "dashboard",
                        "help",
                        "jqx",
                        "lazy",
                        "lazyterm",
                        "lspinfo",
                        "mason",
                        "neo-tree",
                        "notify",
                        "Outline",
                        "qf",
                        "sagaoutline",
                        "starter",
                        "Trouble",
                        "trouble",
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
                    "aerial",
                    "alpha",
                    "dashboard",
                    "help",
                    "jqx",
                    "lazy",
                    "lazyterm",
                    "lspinfo",
                    "mason",
                    "neo-tree",
                    "notify",
                    "Outline",
                    "qf",
                    "sagaoutline",
                    "starter",
                    "Trouble",
                    "trouble",
                    "toggleterm",
                },
                callback = function()
                    vim.b.miniindentscope_disable = true
                end,
            })
        end,
    },
}
