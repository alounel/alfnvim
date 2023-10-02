return {
    -- 在悬浮窗中运行ranger
    {
        "kevinhwang91/rnvimr",
        lazy = true,
        keys = {
            { "<leader>nr", "<cmd>RnvimrToggle<CR>", desc = "Toggle Ranger in Float Window" },
            { "<leader>nz", "<cmd>RnvimrResize<CR>", desc = "Resize Ranger in Window" },
        },
    },
}
