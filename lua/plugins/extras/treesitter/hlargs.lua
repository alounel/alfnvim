return {
    -- 突出显示参数的定义和用法
    {
        "m-demare/hlargs.nvim",
        lazy = true,
        ft = { "c", "cpp", "java", "javascript", "lua", "python", "typescript", "vim" },
        opts = {},
        keys = {
            { "<leader>ha", "<cmd>lua require('hlargs').toggle()<CR>", desc = "Toggle Highlight Args" },
        },
    },
}
