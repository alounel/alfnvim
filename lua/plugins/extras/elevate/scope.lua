return {
    {
        "tiagovla/scope.nvim",
        lazy = true,
        cmd = { "ScopeLoadState", "ScopeSaveState" },
        keys = {
            { "<leader>sl", "<cmd>ScopeList<CR>", desc = "Show Buffer List" },
            { "<leader>sp", ":ScopeMoveBuf", desc = "Move Current Buffer To The Specified Tab" },
        },
        opts = {},
    },
}
