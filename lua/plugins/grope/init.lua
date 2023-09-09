return {
    -- telescope模糊查找
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        lazy = true,
        cmd = "Telescope",
        dependencies = {
            {
                "nvim-telescope/telescope-frecency.nvim",
                lazy = true,
                config = function()
                    require("telescope").load_extension("frecency")
                end,
                dependencies = { "sqlite.lua" },
            },
            { "nvim-telescope/telescope-file-browser.nvim", lazy = true },
            { "nvim-telescope/telescope-ui-select.nvim", lazy = true },
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make", lazy = true },
            { "plenary.nvim" },
        },
        config = function()
            local trouble = require("trouble.providers.telescope")
            require("telescope").setup({
                defaults = {
                    mappings = {
                        i = {
                            ["<M-w>"] = "which_key",
                            ["<M-a>"] = trouble.open_with_trouble,
                        },
                        n = {
                            ["<M-a>"] = trouble.open_with_trouble,
                        },
                    },
                },
                pickers = {
                    find_files = {
                        theme = "ivy",
                    },
                },
                extensions = {
                    file_browser = {
                        theme = "ivy",
                        hijack_netrw = true,
                    },
                    fzf = {
                        fuzzy = true,
                        override_generic_sorter = true,
                        override_file_sorter = true,
                        case_mode = "smart_case",
                    },
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown({
                            -- cmake-tools插件需要用到
                            -- width = 0.8,
                            -- previewer = false,
                            -- prompt_title = false,
                            -- borderchars = {
                            --     { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
                            --     prompt = { "─", "│", " ", "│", "┌", "┐", "│", "│" },
                            --     results = { "─", "│", "─", "│", "├", "┤", "┘", "└" },
                            --     preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
                            -- }
                        }),
                    },
                },
            })
            require("telescope").load_extension("ui-select")
            require("telescope").load_extension("notify")
            require("telescope").load_extension("file_browser")
            require("telescope").load_extension("projects")
            require("telescope").load_extension("noice")
            require("telescope").load_extension("harpoon")
            require("telescope").load_extension("yank_history")
        end,
        keys = {
            { "<leader>fsw", "<cmd>Telescope find_files theme=ivy<CR>", desc = "Find Files" },
            { "<leader>fsg", "<cmd>Telescope live_grep theme=ivy<CR>", desc = "Grep Word" },
            { "<leader>fsb", "<cmd>Telescope buffers theme=ivy<CR>", desc = "Find Buffers" },
            { "<leader>fsh", "<cmd>Telescope help_tags theme=ivy<CR>", desc = "Find Help Tags" },
            { "<leader>fso", "<cmd>Telescope oldfiles theme=ivy<CR>", desc = "Find Old Files" },
            { "<leader>fsm", "<cmd>Telescope marks theme=ivy<CR>", desc = "Find Marks" },
            { "<leader>fsn", "<cmd>Telescope notify theme=ivy<CR>", desc = "Find Notify History" },
            { "<leader>fsp", "<cmd>Telescope projects<CR>", desc = "Find Projects" },
            { "<leader>fse", "<cmd>Telescope file_browser<CR>", desc = "Find File browser Tree" },
            { "<leader>fss", "<cmd>Telescope harpoon marks<CR>", desc = "Find Harpoon File Marks" },
            { "<leader>fsr", "<cmd>Telescope frecency theme=ivy<CR>", desc = "Find Frecency" },
            { "<leader>fsy", "<cmd>Telescope yank_history<CR>", desc = "Find Yank History" },
        },
    },
    -- fzf模糊查找
    {
        "ibhagwan/fzf-lua",
        enabled = false,
        lazy = true,
        cmd = "FzfLua",
        keys = {
            { "<leader>fl", "<cmd>FzfLua<CR>", desc = "Open Fzf inquiry" },
            { "<leader>ff", "<cmd>FzfLua files<CR>", desc = "Fzf inquiry files" },
            { "<leader>fb", "<cmd>FzfLua buffers<CR>", desc = "Fzf inquiry buffers" },
            { "<leader>fa", "<cmd>FzfLua args<CR>", desc = "Show Fzf args list" },
            { "<leader>fh", "<cmd>FzfLua oldfiles<CR>", desc = "Show files history" },
            { "<leader>fq", "<cmd>FzfLua quickfix<CR>", desc = "Open quickfix list" },
            { "<leader>ft", "<cmd>FzfLua tabs<CR>", desc = "Fzf inquiry tab list" },
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
