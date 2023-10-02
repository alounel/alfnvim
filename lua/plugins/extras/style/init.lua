return {
    -- 美化注释
    {
        "LudoPinelli/comment-box.nvim",
        enabled = false,
        lazy = true,
        keys = {
            -- ll,lc,lr/box
            {
                "<leader>sbl",
                "<cmd>lua require('comment-box').llbox()<CR>",
                mode = { "n", "v" },
                desc = "Left Align Box Left Align",
            },
            {
                "<leader>sbc",
                "<cmd>lua require('comment-box').lcbox()<CR>",
                mode = { "n", "v" },
                desc = "Left Align Box Center Align",
            },
            {
                "<leader>sbr",
                "<cmd>lua require('comment-box').lrbox()<CR>",
                mode = { "n", "v" },
                desc = "Left Align Box Right Align",
            },
            -- cl,cc,cr/box
            {
                "<leader>sbL",
                "<cmd>lua require('comment-box').clbox()<CR>",
                mode = { "n", "v" },
                desc = "Center Box Left Algin",
            },
            {
                "<leader>sbC",
                "<cmd>lua require('comment-box').ccbox()<CR>",
                mode = { "n", "v" },
                desc = "Center Box Center Align",
            },
            {
                "<leader>sbR",
                "<cmd>lua require('comment-box').crbox()<CR>",
                mode = { "n", "v" },
                desc = "Center Box Right Align",
            },
            -- rl,rc,rr/box
            {
                "<leader>sbi",
                "<cmd>lua require('comment-box').rlbox()<CR>",
                mode = { "n", "v" },
                desc = "Right Algin Box Left Algin",
            },
            {
                "<leader>sbj",
                "<cmd>lua require('comment-box').rcbox()<CR>",
                mode = { "n", "v" },
                desc = "Right Align Box Center Algin",
            },
            {
                "<leader>sbk",
                "<cmd>lua require('comment-box').rrbox()<CR>",
                mode = { "n", "v" },
                desc = "Right Align Box Right Algin",
            },
            -- al,ac,ar/box
            {
                "<leader>sbo",
                "<cmd>lua require('comment-box').albox()<CR>",
                mode = { "n", "v" },
                desc = "Left Aligned Adapted Box",
            },
            {
                "<leader>sbp",
                "<cmd>lua require('comment-box').acbox()<CR>",
                mode = { "n", "v" },
                desc = "Centered adapted box",
            },
            {
                "<leader>sbq",
                "<cmd>lua require('comment-box').arbox()<CR>",
                mode = { "n", "v" },
                desc = "Right Aligned Adapted Box",
            },
        },
        opts = {},
    },
    -- 显示缩进线
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        enabled = false,
        lazy = true,
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            local highlight = {
                "RainbowRed",
                "RainbowYellow",
                "RainbowBlue",
                "RainbowOrange",
                "RainbowGreen",
                "RainbowViolet",
                "RainbowCyan",
            }
            local hooks = require("ibl.hooks")
            hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
                vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
                vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
                vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
                vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
                vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
                vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
                vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
            end)

            vim.g.rainbow_delimiters = { highlight = highlight }
            require("ibl").setup({
                scope = { highlight = highlight },
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
                        "lazy",
                        "mason",
                        "notify",
                        "toggleterm",
                    },
                },
            })

            hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
        end,
    },
}
