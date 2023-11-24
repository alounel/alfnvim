return {
    {
        "ibhagwan/fzf-lua",
        lazy = true,
        cmd = "FzfLua",
        keys = {
            { "<leader>kl", "<cmd>FzfLua<CR>", desc = "Fuzzy List" },
            { "<leader>kf", "<cmd>FzfLua files<CR>", desc = "Fuzzy Find Files" },
            { "<leader>kg", "<cmd>FzfLua live_grep<CR>", desc = "Fuzzy Find Text" },
            { "<leader>kc", "<cmd>FzfLua colorschemes<CR>", desc = "Fuzzy Find Colorschemes" },
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
