return {
    {
        "j-hui/fidget.nvim",
        lazy = true,
        event = "LspAttach",
        opts = {
            notification = {
                override_vim_notify = true,
                window = {
                    border = "rounded",
                },
            },
            logger = {
                level = vim.log.levels.ERROR,
            },
        },
    },
}
