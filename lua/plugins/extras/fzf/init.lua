return {
    {
        "ibhagwan/fzf-lua",
        lazy = true,
        cmd = "FzfLua",
        keys = {
            { "<leader>qq", "<cmd>FzfLua<CR>", desc = "Fuzzy List" },
            { "<leader>qf", "<cmd>FzfLua files<CR>", desc = "Fuzzy Files" },
            { "<leader>qg", "<cmd>FzfLua live_grep<CR>", desc = "Fuzzy Text" },
        },
        dependencies = { "nvim-web-devicons" },
        config = function()
            require("fzf-lua").setup({
                winopts = {
                    title = "FZF Search",
                    title_pos = "center",
                    preview = {
                        default = "bat",
                        winopts = {
                            relativenumber = true,
                        },
                    },
                },
                files = {
                    previewer = "bat",
                },
                lsp = {
                    git_icons = true,
                    finder = {
                        git_icons = true,
                    },
                },
                diagnostics = {
                    git_icons = true,
                },
                complete_file = {
                    git_icons = true,
                },
            })
        end,
    },
}
