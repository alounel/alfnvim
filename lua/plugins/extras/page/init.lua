return {
    -- 屏保
    {
        "folke/drop.nvim",
        enabled = false,
        event = "VimEnter",
        config = function()
            math.randomseed(os.time())
            local themes = ({ "stars", "snow", "xmas", "leaves" })[math.random(1, 4)]
            require("drop").setup({
                theme = themes,
            })
        end,
    },
}

