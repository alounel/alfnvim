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
                desc = "Center Box Left Align",
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
                desc = "Right Align Box Left Align",
            },
            {
                "<leader>sbj",
                "<cmd>lua require('comment-box').rcbox()<CR>",
                mode = { "n", "v" },
                desc = "Right Align Box Center Align",
            },
            {
                "<leader>sbk",
                "<cmd>lua require('comment-box').rrbox()<CR>",
                mode = { "n", "v" },
                desc = "Right Align Box Right Align",
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
                "Outline",
                "Trouble",
                "qf",
                "tex",
                "text",
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
    -- hlchunk缩进实现
    {
        "shellRaining/hlchunk.nvim",
        enabled = false,
        lazy = true,
        event = { "BufReadPost", "BufNewFile" },
        opts = {},
    },
}
