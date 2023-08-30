-- 笔记和任务清单
return {
    -- 结构化笔记、项目和任务管理、时间跟踪、幻灯片、编写排版文档
    {
        "nvim-neorg/neorg",
        build = ":Neorg sync-parsers",
        lazy = true,
        ft = "norg",
        opts = {
            load = {
                ["core.defaults"] = {},
                ["core.concealer"] = {},
                ["core.dirman"] = {
                    config = {
                        workspaces = {
                            notes = "~/Notes",
                            work = "~/Notes/work",
                            home = "~/Notes/home",
                        },
                    },
                },
            },
        },
    },
    -- 处理文本
    {
        "renerocksai/telekasten.nvim",
        lazy = true,
        cmd = "Telekasten",
        keys = {
            { "<leader>ea", ":Telekasten", desc = "Telekasten commands" },
        },
        dependencies = { "telescope.nvim" },
        opts = {
            home = vim.fn.expand("~/Notes/zettelkasten"),
        },
    },
}
