return {
    -- 补充gitsigns功能
    {
        "chrisgrieser/nvim-tinygit",
        lazy = true,
        keys = {
            {
                "<leader>gts",
                function()
                    require("tinygit").smartCommit({ push = false, openReferencedIssue = false })
                end,
                desc = "Smart Commit",
            },
            {
                "<leader>gtm",
                function()
                    require("tinygit").amendOnlyMsg({ forcePush = false })
                end,
                desc = "Change Last Commit Message",
            },
            {
                "<leader>gtn",
                function()
                    require("tinygit").amendNoEdit({ forcePush = false })
                end,
                desc = "Keep Last Commit Message",
            },
            {
                "<leader>gti",
                function()
                    require("tinygit").issuesAndPrs({ type = "all", state = "all" })
                end,
                desc = "Search Issues & PRs",
            },
            {
                "<leader>gtu",
                function()
                    require("tinygit").githubUrl("file")
                end,
                mode = { "n", "v" },
                desc = "Open At Github And Copy URL To Clipboard",
            },
            {
                "<leader>gtp",
                function()
                    require("tinygit").push({ pullBefore = false, force = false })
                end,
                desc = "Git Push",
            },
            {
                "<leader>gts",
                function()
                    require("tinygit").searchFileHistory()
                end,
                desc = "Search File History",
            },
        },
        dependencies = { "dressing.nvim" },
    },
}
