return {
    {
        "olimorris/onedarkpro.nvim",
        priority = 1000,
        config = function()
            require("onedarkpro").setup({
                styles = {
                    comments = "italic",
                    keywords = "bold",
                    functions = "bold",
                },
            })
            vim.cmd.colorscheme("onedark")
        end,
    },
}
