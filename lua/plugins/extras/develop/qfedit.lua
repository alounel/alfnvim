return {
    -- QuickFix窗口可编辑
    {
        "gabrielpoca/replacer.nvim",
        lazy = true,
        opts = {
            rename_files = false,
            save_on_write = false,
        },
        keys = {
            { "<leader>xpr", "<cmd>lua require('replacer').run()<CR>", desc = "Quickfix Editable" },
            { "<leader>xps", "<cmd>lua require('replacer').save()<CR>", desc = "Save Quickfix Edit Text" },
        },
    },
}
