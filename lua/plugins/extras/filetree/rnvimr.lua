return {
    -- 在悬浮窗中运行ranger
    {
        "kevinhwang91/rnvimr",
        enabled = false,
        lazy = true,
        keys = {
            { "<leader>na", "<cmd>RnvimrToggle<CR>", desc = "Toggle Ranger in Float Window" },
        },
    },
}

