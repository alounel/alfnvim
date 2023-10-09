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
    -- 文件导航
    {
        "echasnovski/mini.files",
        version = false,
        lazy = true,
        keys = {
            {
                "<leader>nm",
                "<cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0), true)<CR>",
                desc = "Open Mini Files(Current File Dir)",
            },
            {
                "<leader>nM",
                "<cmd>lua MiniFiles.open(vim.loop.cwd(), true)<CR>",
                desc = "Open Mini Files(Root Dir)",
            },
        },
        config = function()
            require("mini.files").setup({
                windows = {
                    preview = true,
                    width_focus = 30,
                    width_preview = 30,
                },
            })
        end,
    },
}
