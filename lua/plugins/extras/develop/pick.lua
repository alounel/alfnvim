return {
    -- 图标选择器
    {
        "ziontee113/icon-picker.nvim",
        enabled = false,
        lazy = true,
        keys = {
            { "<leader>ic", "<cmd>IconPickerNormal<CR>", desc = "Nomal Mode Pick Icon Insert Buffer" },
            { "<leader>iy", "<cmd>IconPickerYank<CR>", desc = "Pick Icon And Yank To Register" },
        },
        dependencies = { "telescope.nvim" },
        opts = {
            disable_legacy_commands = true,
        },
    },
}
