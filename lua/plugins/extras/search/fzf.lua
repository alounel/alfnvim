return {
    {
        "ibhagwan/fzf-lua",
        lazy = true,
        cmd = "FzfLua",
        keys = {
            { "<leader>S", "<cmd>FzfLua<CR>", desc = "Fzf Search" },
        },
        dependencies = {
            { "nvim-web-devicons" },
        },
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
