return {
    {
        "ibhagwan/fzf-lua",
        lazy = true,
        cmd = "FzfLua",
        keys = {
            { "<leader>flz", "<cmd>FzfLua<CR>", desc = "Select FzfLua Module" },
            { "<leader>flf", "<cmd>FzfLua files<CR>", desc = "Fzf inquiry files" },
            { "<leader>flb", "<cmd>FzfLua buffers<CR>", desc = "Fzf inquiry buffers" },
            { "<leader>fla", "<cmd>FzfLua args<CR>", desc = "Fzf args list" },
            { "<leader>flh", "<cmd>FzfLua oldfiles<CR>", desc = "Fzf Show files history" },
            { "<leader>flq", "<cmd>FzfLua quickfix<CR>", desc = "Fzf Open quickfix list" },
            { "<leader>flt", "<cmd>FzfLua tabs<CR>", desc = "Fzf inquiry tab list" },
            { "<leader>flg", "<cmd>FzfLua grep<CR>", desc = "Fzf Grep Text" },
            { "<leader>fli", "<cmd>FzfLua live_grep<CR>", desc = "Fzf Live Grep Text" },
            { "<leader>fll", "<cmd>FzfLua lines<CR>", desc = "Fzf Open lines" },
            { "<leader>flc", "<cmd>FzfLua colorschemes<CR>", desc = "Fzf Colorscheme" },
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
