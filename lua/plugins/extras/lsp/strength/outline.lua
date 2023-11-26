return {
    {
        "hedyhli/outline.nvim",
        lazy = true,
        keys = {
            { "<leader>ao", "<cmd>Outline<CR>", desc = "Toggle Outline" },
        },
        opts = {
            show_number = true,
            preview_window = {
                open_hover_on_preview = true,
            },
            providers = {
                priority = { "lsp", "markdown", "norg" },
                lsp = {
                    blacklist_clients = {},
                },
            },
        },
    },
}
