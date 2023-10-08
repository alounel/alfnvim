return {
    {
        "kevinhwang91/nvim-fundo",
        enabled = false,
        build = function()
            require("fundo").install()
        end,
        lazy = true,
        event = "BufReadPre",
        dependencies = {
            {
                "kevinhwang91/promise-async",
                lazy = true,
            },
        },
        init = function()
            vim.bo.undofile = true
        end,
        opts = {},
    },
}
