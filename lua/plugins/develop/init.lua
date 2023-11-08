return {
    -- 工程管理
    {
        "ahmedkhalf/project.nvim",
        lazy = true,
        event = "VeryLazy",
        opts = {
            manual_mode = true,
        },
        config = function(_, opts)
            require("project_nvim").setup(opts)
        end,
    },
    -- projects的telescope可选项
    {
        "nvim-telescope/telescope.nvim",
        optional = true,
        keys = {
            { "<leader>fp", "<cmd>Telescope projects<CR>", desc = "File Projects" },
        },
        opts = function()
            require("config.util").on_load("telescope.nvim", function()
                require("telescope").load_extension("projects")
            end)
        end,
    },
    -- 会话管理
    {
        "folke/persistence.nvim",
        lazy = true,
        event = "BufReadPre",
        opts = {
            options = vim.opt.sessionoptions:get(),
        },
        keys = {
            {
                "<leader>qs",
                "<cmd>lua require('persistence').load()<CR>",
                desc = "Restore The Session For The Current Directory",
            },
            {
                "<leader>ql",
                "<cmd>lua require('persistence').load({ last = true })<CR>",
                desc = "Restore The Last Session",
            },
            {
                "<leader>qd",
                "<cmd>lua require('persistence').stop()<CR>",
                desc = "Session Won't Be Saved On Exit",
            },
        },
    },
}
