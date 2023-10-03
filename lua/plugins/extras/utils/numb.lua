return {
    -- 输入命令查看缓冲区
    {
        "nacro90/numb.nvim",
        lazy = true,
        event = "CmdlineEnter",
        opts = {
            number_only = true,
        },
        keys = {
            { "<leader>bc", "<cmd>lua require('numb').setup()<CR>", desc = "Start Command Show Current Buffer" },
            { "<leader>bk", "<cmd>lua require('numb').disable()<CR>", desc = "Disable Command Show Current Buffer" },
        },
    },
}
