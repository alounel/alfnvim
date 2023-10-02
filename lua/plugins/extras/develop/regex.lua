return {
    -- 解释和测试正则表达式
    {
        "tomiis4/hypersonic.nvim",
        enabled = false,
        lazy = true,
        event = "CmdlineEnter",
        keys = {
            { "<leader>rx", ":Hypersonic", desc = "Explain Or Test Regex" },
        },
        opts = {},
    },
}
