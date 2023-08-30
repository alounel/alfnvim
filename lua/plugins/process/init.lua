return {
    -- 良好工作流程
    {
        "m4xshen/hardtime.nvim",
        lazy = true,
        cmd = "Hardtime",
        keys = {
            { "<leader>pt", "<cmd>Hardtime toggle<CR>", desc = "Toggle Hardtime" },
            { "<leader>pr", "<cmd>Hardtime report<CR>", desc = "Report Hardtime" },
        },
        dependencies = {
            { "nui.nvim" },
            { "plenary.nvim" },
        },
        opts = {
            disabled_filetypes = { "qf", "netrw", "new-tree", "lazy", "mason", "aerial", "Outline" },
            disable_mouse = false,
        },
    },
}
