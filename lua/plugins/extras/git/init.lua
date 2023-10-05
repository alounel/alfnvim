return {
    -- 补充gitsigns功能
    {
        "chrisgrieser/nvim-tinygit",
        lazy = true,
        keys = {
            {
                "<leader>gtm",
                "<cmd>lua require('tinygit').amendOnlyMsg ({ forcePush = false })<CR>",
                desc = "Change Last Commit Message",
            },
            {
                "<leader>gtn",
                "<cmd>lua require('tinygit').amendNoEdit ({ forcePush = false })<CR>",
                desc = "Keep Last Commit Message",
            },
            {
                "<leader>gti",
                "<cmd>lua require('tinygit').issuesAndPrs({ type = 'all', state = 'all' })<CR>",
                desc = "Search Issues & PRs",
            },
            {
                "<leader>gtu",
                "<cmd>require('tinygit').githubUrl('file')<CR>",
                mode = { "n", "v" },
                desc = "Open At Github And Copy URL To Clipboard",
            },
            {
                "<leader>gtp",
                "<cmd>require('tinygit').push({ pullBefore = false, force = false })<CR>",
                desc = "Git Push",
            },
        },
        dependencies = { "dressing.nvim" },
    },
}
