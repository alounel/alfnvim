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
                ["core.presenter"] = {
                    config = {
                        zen_mode = "zen-mode",
                    },
                },
            },
        },
    },
    -- 处理markdown,zettelkasten,wiki
    {
        "renerocksai/telekasten.nvim",
        lazy = true,
        cmd = "Telekasten",
        keys = {
            { "<leader>ea", "<cmd>Telekasten panel<CR>", desc = "Open Telekasten Commands Panel" },
        },
        dependencies = { "telescope.nvim" },
        opts = {
            home = vim.fn.expand("~/Notes/zettelkasten"),
        },
    },
}
