local Util = require("config.util")
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
                    get_selection_window = function()
                        local wins = vim.api.nvim_list_wins()
                        table.insert(wins, 1, vim.api.nvim_get_current_win())
                        for _, win in ipairs(wins) do
                            local buf = vim.api.nvim_win_get_buf(win)
                            if vim.bo[buf].buftype == "" then
                                return win
                            end
                        end
                        return 0
                    end,
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
            {
                "<leader>fb",
                "<cmd>Telescope buffers sort_mru=true sort_lastused=true theme=ivy<CR>",
                desc = "Find Buffers",
            },
            { "<leader>fc", "<cmd>Telescope commands<CR>", desc = "Find Commands" },
            { "<leader>fC", "<cmd>Telescope command_history<CR>", desc = "Find Command History" },
            { "<leader>ff", Util.telescope("files"), desc = "Find Files (Root Dir)" },
            { "<leader>fF", Util.telescope("files", { cwd = false }), desc = "Find Files (CWD)" },
            { "<leader>fh", "<cmd>Telescope help_tags theme=ivy<CR>", desc = "Find Help Tags" },
            { "<leader>fg", Util.telescope("live_grep"), desc = "Grep Text (Root Dir)" },
            { "<leader>fG", Util.telescope("live_grep", { cwd = false }), desc = "Grep Text (CWD)" },
            { "<leader>fm", "<cmd>Telescope marks theme=ivy<CR>", desc = "Find Marks" },
            { "<leader>fr", "<cmd>Telescope oldfiles theme=ivy<CR>", desc = "Find Old Files" },
            {
                "<leader>fd",
                Util.telescope("colorscheme", { enable_preview = true }),
                desc = "Colorscheme with preview",
            },
            { "<leader>fi", "<cmd>Telescope registers<CR>", desc = "Find Registers" },
            { "<leader>fn", "<cmd>Telescope notify theme=ivy<CR>", desc = "Notify History" },
            { "<leader>fp", "<cmd>Telescope projects<CR>", desc = "Find Projects" },
            { "<leader>fw", Util.telescope("grep_string", { word_match = "-w" }), desc = "Word (Root Dir)" },
            { "<leader>fo", "<cmd>Telescope vim_options<cr>", desc = "Find Options" },
            {
                "<leader>fe",
                "<cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>",
                desc = "Use Buffer Location Open Browser",
            },
            {
                "<leader>fl",
                function()
                    require("telescope.builtin").lsp_document_symbols({
                        symbols = require("config.confinit").get_kind_filter(),
                    })
                end,
                desc = "Goto Symbol",
            },
            {
                "<leader>fL",
                function()
                    require("telescope.builtin").lsp_dynamic_workspace_symbols({
                        symbols = require("config.confinit").get_kind_filter(),
                    })
                end,
                desc = "Goto Symbol (Workspace)",
            },
            -- { "<leader>fr", "<cmd>Telescope frecency theme=ivy<CR>", desc = "Find Frecency" },
        },
    },
    -- fzf模糊查找
    {
        import = "plugins.extras.search.fzf",
    },
}
