return {
    -- telescope模糊查找
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        lazy = true,
        cmd = "Telescope",
        dependencies = {
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
                lazy = true,
                config = function()
                    require("periph.util").on_load("telescope.nvim", function()
                        require("telescope").load_extension("fzf")
                    end)
                end,
            },
            {
                "nvim-telescope/telescope-frecency.nvim",
                lazy = true,
                config = function()
                    require("telescope").load_extension("frecency")
                    vim.keymap.set("n", "<leader>fv", "<cmd>FrecencyValidate<CR>", { desc = "Clean Frecency DB" })
                end,
            },
            { "nvim-telescope/telescope-file-browser.nvim", lazy = true },
            { "nvim-telescope/telescope-ui-select.nvim", lazy = true },
            { "plenary.nvim" },
        },
        config = function()
            local trouble = require("trouble.providers.telescope")
            local actions = require("telescope.actions")

            require("telescope").setup({
                defaults = {
                    prompt_prefix = " ",
                    selection_caret = " ",
                    mappings = {
                        i = {
                            ["<M-w>"] = "which_key",
                            ["<M-a>"] = trouble.open_with_trouble,
                            ["<C-Down>"] = actions.cycle_history_next,
                            ["<C-Up>"] = actions.cycle_history_prev,
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
            require("telescope").load_extension("file_browser")
            require("telescope").load_extension("projects")
            require("telescope").load_extension("notify")
            require("telescope").load_extension("noice")
            require("telescope").load_extension("harpoon")
            require("telescope").load_extension("scope")
            require("telescope").load_extension("yank_history")
        end,
        keys = {
            { "<leader>fsc", "<cmd>Telescope commands<CR>", desc = "Find Commands" },
            { "<leader>fsi", "<cmd>Telescope registers<CR>", desc = "Find Registers" },
            { "<leader>fsw", "<cmd>Telescope find_files theme=ivy<CR>", desc = "Find Files" },
            { "<leader>fsg", "<cmd>Telescope live_grep theme=ivy<CR>", desc = "Grep Word" },
            { "<leader>fsb", "<cmd>Telescope buffers theme=ivy<CR>", desc = "Find Buffers" },
            { "<leader>fsh", "<cmd>Telescope help_tags theme=ivy<CR>", desc = "Find Help Tags" },
            { "<leader>fso", "<cmd>Telescope oldfiles theme=ivy<CR>", desc = "Find Old Files" },
            { "<leader>fsm", "<cmd>Telescope marks theme=ivy<CR>", desc = "Find Marks" },
            { "<leader>fsn", "<cmd>Telescope notify theme=ivy<CR>", desc = "Notify History" },
            { "<leader>fsp", "<cmd>Telescope projects<CR>", desc = "Find Projects" },
            {
                "<leader>fse",
                "<cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>",
                desc = "Use Current Buffer Open Browser",
            },
            { "<leader>fss", "<cmd>Telescope harpoon marks<CR>", desc = "Find Harpoon File Marks" },
            { "<leader>fsr", "<cmd>Telescope frecency theme=ivy<CR>", desc = "Find Frecency" },
            { "<leader>fsy", "<cmd>Telescope yank_history<CR>", desc = "Find Yank History" },
            { "<leader>fst", "<cmd>Telescope scope buffers<CR>", desc = "Find Scope Buffer" },
        },
    },
    -- fzf模糊查找
    {
        import = "plugins.extras.search.fzf",
    },
}
