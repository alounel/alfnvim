return {
    {
        "gorbit99/codewindow.nvim",
        lazy = true,
        keys = {
            {
                "<leader>sm",
                function()
                    require("codewindow").toggle_minimap()
                end,
                desc = "Toggle Minimap",
            },
            {
                "<leader>sf",
                function()
                    require("codewindow").toggle_focus()
                end,
                desc = "Focus Minimap",
            },
        },
        config = function()
            require("codewindow").setup({
                exclude_filetypes = { "help", "vimdoc", "log", "txt", "tex" },
                window_border = "rounded",
            })
        end,
    },
}
