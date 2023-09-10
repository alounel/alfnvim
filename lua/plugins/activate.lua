return {
    {
        "roobert/activate.nvim",
        lazy = true,
        keys = {
            { "<leader>pm", "<cmd>lua require('activate').list_plugins()<CR>", desc = "Plugin List" },
        },
    },
}

