return {
    -- 添加内联注释以忽略规则
    {
        "chrisgrieser/nvim-rulebook",
        lazy = true,
        keys = {
            {
                "<leader>ri",
                function()
                    require("rulebook").ignoreRule()
                end,
                desc = "Rule Ignore",
            },
            {
                "<leader>rl",
                function()
                    require("rulebook").lookupRule()
                end,
                desc = "Rule Lookup",
            },
        },
        dependencies = { "dressing.nvim" },
    },
}
