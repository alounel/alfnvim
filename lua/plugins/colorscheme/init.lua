return {
    {
        "EdenEast/nightfox.nvim",
        enabled = false,
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
    {
        "folke/tokyonight.nvim",
        priority = 1000,
        config = function()
            require("tokyonight").setup({
                style = "moon",
                styles = {
                    comments = { italic = true },
                    keywords = { italic = false, bold = true },
                    functions = { bold = true },
                    variables = {},
                    sidebars = "dark",
                    floats = "dark",
                },
                sidebars = { "qf", "terminal" },
            })
            vim.cmd("colorscheme tokyonight")
        end,
    },
    {
        "loctvl842/monokai-pro.nvim",
        enabled = false,
        priority = 1000,
        config = function()
            require("monokai-pro").setup({
                styles = {
                    comment = { italic = true },
                    keyword = { italic = false, bold = true },
                    type = { italic = false },
                    storageclass = { italic = true },
                    structure = { italic = true },
                    parameter = { italic = true },
                    annotation = { italic = true },
                    tag_attribute = { italic = true },
                },
                filter = "octagon",
            })
            vim.cmd("colorscheme monokai-pro")
        end,
    },
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
                    keywords = "bold",
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
}
