return {
    {
        "rmehri01/onenord.nvim",
        enabled = false,
        priority = 1000,
        config = function()
            require("onenord").setup({
                theme = "dark",
                fade_nc = true,
                styles = {
                    comments = "italic",
                    strings = "bold",
                    keywords = "bold",
                    functions = "bold,italic",
                    variables = "bold",
                    diagnostics = "underline",
                },
            })
        end,
    },
    {
        "navarasu/onedark.nvim",
        enabled = false,
        priority = 1000,
        config = function()
            require("onedark").setup({
                style = "cool",
                ending_tildes = true,
                code_style = {
                    comments = "italic",
                    keywords = "bold,italic",
                    functions = "bold",
                },
            })
            require("onedark").load()
        end,
    },
    {
        "rebelot/kanagawa.nvim",
        enabled = false,
        priority = 1000,
        config = function()
            require("kanagawa").setup({
                functionStyle = { bold = true },
                keywordStyle = { bold = true, italic = false },
                statementStyle = { bold = true, italic = true },
                dimInactive = true,
            })
            require("kanagawa").load()
        end,
    },
    {
        "EdenEast/nightfox.nvim",
        priority = 1000,
        config = function()
            require("nightfox").setup({
                options = {
                    styles = {
                        comments = "italic,bold",
                        functions = "bold",
                        keywords = "bold",
                        types = "bold",
                    },
                },
            })
            vim.cmd("colorscheme nightfox")
        end,
    },
}
