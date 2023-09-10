return {
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

