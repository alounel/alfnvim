return {
    {
        "smjonas/inc-rename.nvim",
        lazy = true,
        keys = {
            { "<leader>in", ":IncRename ", desc = "Rename" },
        },
        config = function()
            require("inc_rename").setup({
                preview_empty_name = true,
            })
        end,
    },
}
