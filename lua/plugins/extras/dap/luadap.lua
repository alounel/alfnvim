return {
    ------ 特定语言调试插件 ------
    -- lua
    {
        "jbyuki/one-small-step-for-vimkind",
        lazy = true,
        keys = {
            { "<leader>dlr", "<cmd>lua require('osv').run_this()<CR>", desc = "Lua Debug Run" },
            { "<leader>dlt", "<cmd>lua require('osv').start_trace()<CR>", desc = "Lua Debug Start Trace" },
            { "<leader>dls", "<cmd>lua =require('osv').stop_trace()<CR>", desc = "Lua Debug Stop Trace" },
            { "<leader>dll", "<cmd>lua require('osv').launch({port = 8086})<CR>", desc = "Lua Debug Launch" },
        },
        dependencies = "nvim-dap",
    },
}
