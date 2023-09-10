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
        enabled = false,
        lazy = true,
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require("indent_blankline").setup({
                -- 显示当前所在区域
                show_current_context = true,
                -- 显示当前所在区域的开始位置
                show_current_context_start = true,
                -- 显示行尾符
                show_end_of_line = true,
                -- 空格字符缩进样式
                space_char_blankline = " ",
            })
        end,
    },
}

