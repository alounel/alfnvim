return {
    {
        "j-hui/fidget.nvim",
        lazy = true,
        event = "LspAttach",
        opts = {
            window = {
                border = "rounded",
            },
            logger = {
                level = vim.log.levels.ERROR,
            },
        },
    },
}
