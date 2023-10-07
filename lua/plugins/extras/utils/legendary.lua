return {
    -- keyamps,command,functions示例
    {
        "mrjones2014/legendary.nvim",
        lazy = true,
        cmd = { "LegendaryLog", "LegendaryRepeat" },
        keys = {
            { "<leader>fdy", "<cmd>Legendary<CR>", desc = "Show Legendary" },
            { "<leader>fdk", "<cmd>Legendary keymaps<CR>", desc = "Search Keymaps" },
            { "<leader>fdc", "<cmd>Legendary commands<CR>", desc = "Search Commands" },
            { "<leader>fdf", "<cmd>Legendary functions<CR>", desc = "Search Functions" },
            { "<leader>fda", "<cmd>Legendary autocmds<CR>", desc = "Search Autocmds" },
        },
        dependencies = { "telescope.nvim" },
        opts = {
            lazy_nvim = {
                auto_register = true,
            },
            which_key = {
                auto_register = true,
            },
            log_level = "error",
        },
    },
}
