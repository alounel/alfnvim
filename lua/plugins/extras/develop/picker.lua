return {
    -- 图标选择器
    {
        "ziontee113/icon-picker.nvim",
        -- enabled = false,
        lazy = true,
        keys = {
            { "<leader>ic", "<cmd>IconPickerNormal<CR>", desc = "Normal Mode Pick Icon Insert Buffer" },
            { "<leader>iy", "<cmd>IconPickerYank<CR>", desc = "Pick Icon And Yank To Register" },
        },
        dependencies = { "telescope.nvim" },
        opts = {
            disable_legacy_commands = true,
        },
    },
    -- nerdfont图标选择
    {
        "2KAbhishek/nerdy.nvim",
        enabled = false,
        lazy = true,
        cmd = "Nerdy",
        dependencies = {
            { "dressing.nvim" },
            { "telescope.nvim" },
        },
    },
}
