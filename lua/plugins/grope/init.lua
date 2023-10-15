local Util = require("core.util")
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
                    Util.on_load("telescope.nvim", function()
                        require("telescope").load_extension("fzf")
                    end)
                end,
            },
            -- 暂时和noice.nvim插件冲突 2023-10-11,23:12
            {
                "nvim-telescope/telescope-frecency.nvim",
                enabled = false,
                lazy = true,
                config = function()
                    Util.on_load("telescope.nvim", function()
                        require("telescope").load_extension("frecency")
                    end)
                end,
            },
            { "nvim-telescope/telescope-file-browser.nvim", lazy = true },
            { "nvim-telescope/telescope-ui-select.nvim", lazy = true },
            { "plenary.nvim" },
        },
        config = function()
            local actions = require("telescope.actions")

            local open_with_trouble = function(...)
                return require("trouble.providers.telescope").open_with_trouble(...)
            end
            local open_selected_with_trouble = function(...)
                return require("trouble.providers.telescope").open_selected_with_trouble(...)
            end
            local find_files_no_ignore = function()
                local action_state = require("telescope.actions.state")
                local line = action_state.get_current_line()
                Util.telescope("find_files", { no_ignore = true, default_text = line })()
            end
            local find_files_with_hidden = function()
                local action_state = require("telescope.actions.state")
                local line = action_state.get_current_line()
                Util.telescope("find_files", { hidden = true, default_text = line })()
            end

            require("telescope").setup({
                defaults = {
                    prompt_prefix = " ",
                    selection_caret = " ",
                    mappings = {
                        i = {
                            ["<M-w>"] = "which_key",
                            ["<M-t>"] = open_with_trouble,
                            ["<M-a>"] = open_selected_with_trouble,
                            ["<M-i>"] = find_files_no_ignore,
                            ["<M-h>"] = find_files_with_hidden,
                            ["<C-Down>"] = actions.cycle_history_next,
                            ["<C-Up>"] = actions.cycle_history_prev,
                            ["<C-F>"] = actions.preview_scrolling_down,
                            ["<C-B>"] = actions.preview_scrolling_up,
                        },
                        n = {
                            ["q"] = actions.close,
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
                        require("telescope.themes").get_dropdown({}),
                    },
                },
            })
            require("telescope").load_extension("ui-select")
            require("telescope").load_extension("file_browser")
            require("telescope").load_extension("projects")
            require("telescope").load_extension("notify")
            require("telescope").load_extension("noice")
        end,
        keys = {
            { "<leader>fsc", "<cmd>Telescope commands<CR>", desc = "Find Commands" },
            { "<leader>fsC", "<cmd>Telescope command_history<CR>", desc = "Find Command History" },
            { "<leader>fsi", "<cmd>Telescope registers<CR>", desc = "Find Registers" },
            { "<leader>fs<space>", Util.telescope("files"), desc = "Find Files (root dir)" },
            { "<leader>fsw", "<cmd>Telescope find_files theme=ivy<CR>", desc = "Find Files" },
            { "<leader>fsg", "<cmd>Telescope live_grep theme=ivy<CR>", desc = "Grep Word" },
            { "<leader>fsb", "<cmd>Telescope buffers show_all_buffer=true theme=ivy<CR>", desc = "Find Buffers" },
            { "<leader>fsh", "<cmd>Telescope help_tags theme=ivy<CR>", desc = "Find Help Tags" },
            { "<leader>fso", "<cmd>Telescope oldfiles theme=ivy<CR>", desc = "Find Old Files" },
            { "<leader>fsm", "<cmd>Telescope marks theme=ivy<CR>", desc = "Find Marks" },
            {
                "<leader>fsd",
                Util.telescope("colorscheme", { enable_preview = true }),
                desc = "Colorscheme with preview",
            },
            { "<leader>fsn", "<cmd>Telescope notify theme=ivy<CR>", desc = "Notify History" },
            { "<leader>fsp", "<cmd>Telescope projects<CR>", desc = "Find Projects" },
            {
                "<leader>fse",
                "<cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>",
                desc = "Use Buffer Location Open Browser",
            },
            -- { "<leader>fsr", "<cmd>Telescope frecency theme=ivy<CR>", desc = "Find Frecency" },
        },
    },
    -- fzf模糊查找
    {
        import = "plugins.extras.search.fzf",
    },
}
