return {
    {
        "tiagovla/scope.nvim",
        lazy = true,
        keys = {
            { "<leader>sp", ":ScopeMoveBuf", desc = "Move Current Buffer To The Specified Tab" },
            { "<leader>sP", "<cmd>Telescope scope buffers<CR>", desc = "Find Scope Buffers" },
        },
        opts = {},
    },
}
