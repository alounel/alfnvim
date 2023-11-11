return {
    -- LSP 进度提示
    {
        "j-hui/fidget.nvim",
        tag = "legacy",
        lazy = true,
        event = "LspAttach",
        opts = {
            window = {
                border = "rounded",
            },
        },
    },
    -- 基于LSP带有即时视觉反馈的重命名
    {
        "smjonas/inc-rename.nvim",
        lazy = true,
        keys = {
            { "<leader>in", ":IncRename ", desc = "Rename" },
        },
        config = function()
            require("inc_rename").setup({
                preview_empty_name = true,
            })
        end,
    },
    -- 改善 Neovim LSP 体验
    {
        "nvimdev/lspsaga.nvim",
        lazy = true,
        event = "LspAttach",
        keys = {
            -- callhierarchy
            { "<Leader>lgi", "<cmd>Lspsaga incoming_calls<CR>", desc = "Call Incoming" },
            { "<Leader>lgt", "<cmd>Lspsaga outgoing_calls<CR>", desc = "Call Outgoing" },
            -- code action
            { "<leader>lga", "<cmd>Lspsaga code_action<CR>", desc = "Show Code Action" },
            -- definition
            { "<leader>lgf", "<cmd>Lspsaga peek_definition<CR>", desc = "Peek Definition" },
            { "<leader>lgg", "<cmd>Lspsaga goto_definition<CR>", desc = "Goto Definition" },
            { "<leader>lgy", "<cmd>Lspsaga peek_type_definition<CR>", desc = "Peek Type Definition" },
            { "<leader>lgx", "<cmd>Lspsaga goto_type_definition<CR>", desc = "Goto Type Definition" },
            -- diagnostics
            { "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", desc = "Prev Diagnostics" },
            { "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", desc = "Next Diagnostics" },
            { "<leader>lgb", "<cmd>Lspsaga show_buf_diagnostics<CR>", desc = "Show Buffer Diagnostics" },
            { "<leader>lgc", "<cmd>Lspsaga show_cursor_diagnostics<CR>", desc = "Show Cursor Diagnostics" },
            { "<leader>lgl", "<cmd>Lspsaga show_line_diagnostics<CR>", desc = "Show Line Diagnostics" },
            { "<leader>lgw", "<cmd>Lspsaga show_workspace_diagnostics<CR>", desc = "Show Workspace Diagnostics" },
            -- finder
            { "<leader>lgn", "<cmd>Lspsaga finder<CR>", desc = "Shows Results For References And Implementation" },
            -- hover
            { "<leader>lgh", "<cmd>Lspsaga hover_doc<CR>", desc = "Show Hover Doc" },
            { "<leader>lgk", "<cmd>Lspsaga hover_doc ++keep<CR>", desc = "Hover In Upper Right Corner" },
            -- outline
            { "<leader>lgo", "<cmd>Lspsaga outline<CR>", desc = "Toggle Outline" },
            -- rename
            { "<leader>lgr", "<cmd>Lspsaga rename<CR>", desc = "Rename" },
            { "<leader>lgp", "<cmd>Lspsaga rename ++project<CR>", desc = "Rename LSP Integration" },
            { "<leader>lgs", ":Lspsaga project_replace", desc = "Project-wide Replace" },
            -- terminal
            { "<leader>lgm", "<cmd>Lspsaga term_toggle<CR>", desc = "Float Terminal" },
        },
        dependencies = { { "nvim-web-devicons" }, { "nvim-treesitter" } },
        config = function()
            require("lspsaga").setup({
                code_action = {
                    num_shortcut = true,
                    show_server_name = true,
                    extend_gitsigns = true,
                },
            })
            -- 带过滤器的诊断跳转
            vim.keymap.set("n", "[E", function()
                require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
            end, { desc = "Prev Diagnostics ERROR" })
            vim.keymap.set("n", "]E", function()
                require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
            end, { desc = "Next Diagnostics ERROR" })
            vim.keymap.set("n", "[W", function()
                require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.WARN })
            end, { desc = "Prev Diagnostics WARN" })
            vim.keymap.set("n", "]W", function()
                require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.WARN })
            end, { desc = "Next Diagnostics WARN" })
        end,
    },
    -- 显示光标下相同词汇
    {
        "RRethy/vim-illuminate",
        lazy = true,
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            providers = { "lsp", "treesitter" },
            delay = 200,
            large_file_cutoff = 2000,
            large_file_overrides = {
                providers = { "lsp", "treesitter" },
            },
        },
        config = function(_, opts)
            require("illuminate").configure(opts)
            vim.keymap.set("n", "[l", function()
                require("illuminate").goto_prev_reference()
            end, { desc = "Prev Match Word" })
            vim.keymap.set("n", "]l", function()
                require("illuminate").goto_next_reference()
            end, { desc = "Next Match Word" })
        end,
        keys = {
            { "<leader>hi", "<cmd>IlluminateToggle<CR>", desc = "Toggle Overall Word Illuminate" },
            { "<leader>hb", "<cmd>IlluminateToggleBuf<CR>", desc = "Toggle Local Buffer Word Illuminate" },
        },
    },
    -- 代码大纲
    {
        "stevearc/aerial.nvim",
        lazy = true,
        keys = {
            { "<leader>ag", "<cmd>AerialToggle<CR>", desc = "Toggle Aerial" },
            { "<leader>an", "<cmd>AerialNavToggle<CR>", desc = "Toggle Aerial Navigator" },
            { "<leader>ai", "<cmd>AerialInfo<CR>", desc = "Show Aerial Info" },
        },
        opts = function()
            local Config = require("config.confstrap")
            local icons = vim.deepcopy(require("core.icons").icons.kinds)

            icons.lua = { Package = icons.Control }

            local filter_kind = false
            if Config.filter.kind_filter then
                filter_kind = assert(vim.deepcopy(Config.filter.kind_filter))
                filter_kind._ = filter_kind.default
                filter_kind.default = nil
            end
            local opts = {
                backends = { "lsp", "treesitter", "markdown", "man" },
                layout = {
                    min_width = 20,
                    win_opts = {
                        winhl = "Normal:NormalFloat,FloatBorder:NormalFloat,SignColumn:SignColumnSB",
                        signcolumn = "yes",
                        statuscolumn = " ",
                    },
                    default_direction = "prefer_left",
                },
                filter_kind = filter_kind,
                icons = icons,
                attach_mode = "global",
                show_guides = true,
                guides = {
                    mid_item = "├╴",
                    last_item = "└╴",
                    nested_top = "│ ",
                    whitespace = "  ",
                },
                highlight_on_hover = true,
                autojump = true,
                ignore = {
                    filetypes = {
                        "neo-tree",
                        "sagaoutline",
                        "qf",
                        "Trouble",
                        "trouble",
                        "spectre_panel",
                        "notify",
                        "noice",
                    },
                },
                on_attach = function(bufnr)
                    vim.keymap.set(
                        "n",
                        "[a",
                        "<cmd>AerialPrev<CR>",
                        { buffer = bufnr, desc = "Goto Prev Aerial Symbol" }
                    )
                    vim.keymap.set(
                        "n",
                        "]a",
                        "<cmd>AerialNext<CR>",
                        { buffer = bufnr, desc = "Goto Next Aerial Symbol" }
                    )
                end,
            }
            return opts
        end,
    },
    -- aerial的telescope可选配置
    {
        "nvim-telescope/telescope.nvim",
        optional = true,
        opts = function()
            require("config.util").on_load("telescope.nvim", function()
                require("telescope").load_extension("aerial")
            end)
        end,
        keys = {
            {
                "<leader>fa",
                "<cmd>Telescope aerial<cr>",
                desc = "Goto Symbol (Aerial)",
            },
        },
    },
    -- 浮动导航窗口
    {
        "SmiteshP/nvim-navbuddy",
        lazy = true,
        keys = {
            { "<leader>ny", "<cmd>Navbuddy<CR>", desc = "Navbuddy Float Outline" },
        },
        dependencies = {
            {
                "SmiteshP/nvim-navic",
                lazy = true,
                opts = {
                    lsp = {
                        auto_attach = true,
                    },
                    highlight = true,
                },
            },
            { "nvim-lspconfig" },
        },
        opts = {
            window = {
                border = "rounded",
            },
            lsp = {
                auto_attach = true,
            },
        },
    },
    {
        "Bekaboo/dropbar.nvim",
        enabled = false,
        -- requirement nvim version 0.10.0
    },
}
