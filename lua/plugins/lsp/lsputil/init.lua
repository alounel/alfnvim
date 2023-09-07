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
            debug = {
                logging = true,
                strict = true,
            },
        },
    },
    -- 基于LSP带有即时视觉反馈的重命名
    {
        "smjonas/inc-rename.nvim",
        lazy = true,
        keys = {
            { "<leader>rn", ":IncRename ", desc = "Inc Rename" },
        },
        config = function()
            require("inc_rename").setup({
                preview_empty_name = true,
            })
        end,
    },
    -- 增强Lspconfig插件的效果
    {
        "nvimdev/lspsaga.nvim",
        lazy = true,
        event = "LspAttach",
        keys = {
            -- 诊断跳转，<c-o>跳回
            { "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", desc = "Diagnotics Jump Prev" },
            { "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", desc = "Diagnotics Jump Next" },
            { "<leader>lga", "<cmd>Lspsaga code_action<CR>", desc = "Lspsaga Show Code Action" },
            { "<leader>lgb", "<cmd>Lspsaga show_buf_diagnostics<CR>", desc = "Show Buffer Diagnotics" },
            { "<leader>lgd", "<cmd>Lspsaga show_cursor_diagnostics<CR>", desc = "Show Cursor Local Diagnotics" },
            { "<leader>lgr", "<cmd>Lspsaga rename<CR>", desc = "Lspsaga Rename" },
            { "<leader>lgp", "<cmd>Lspsaga rename ++project<CR>", desc = "Lspsaga Rename Project" },
            { "<leader>lgf", "<cmd>Lspsaga peek_definition<CR>", desc = "Peek Definition" },
            { "<leader>lgg", "<cmd>Lspsaga goto_definition<CR>", desc = "Goto Definition" },
            { "<leader>lgy", "<cmd>Lspsaga peek_type_definition<CR>", desc = "Peek Type Definition,<C-t> BackWard" },
            { "<leader>lgx", "<cmd>Lspsaga goto_type_definition<CR>", desc = "Goto Type Definition" },
            { "<leader>lgh", "<cmd>Lspsaga hover_doc<CR>", desc = "Show Hover Doc" },
            { "<leader>lgk", "<cmd>Lspsaga hover_doc ++keep<CR>", desc = "Hover In Upper Right Corner" },
            { "<leader>lgl", "<cmd>Lspsaga show_line_diagnostics<CR>", desc = "Show Line Diagnotics" },
            { "<leader>lgo", "<cmd>Lspsaga outline<CR>", desc = "Lspsaga Toggle Outline" },
            { "<Leader>lgi", "<cmd>Lspsaga incoming_calls<CR>", desc = "Call Incoming" },
            { "<Leader>lgt", "<cmd>Lspsaga outgoing_calls<CR>", desc = "Call Outgoing" },
            { "<leader>lgm", "<cmd>Lspsaga term_toggle<CR>", desc = "Lspsaga Float Terminal" },
            { "<leader>lgn", "<cmd>Lspsaga finder<CR>", desc = "Search Finder Definition,<C-t> BackWard" },
        },
        dependencies = {
            { "nvim-web-devicons" },
            { "nvim-treesitter" },
        },
        config = function()
            require("lspsaga").setup({
                code_action = {
                    num_shortcut = true,
                    show_server_name = true,
                    extend_gitsigns = true,
                },
                ui = {
                    border = "rounded",
                },
            })
            -- 带过滤器的诊断跳转，如之跳转到错误处
            vim.keymap.set("n", "[E", function()
                require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
            end, { desc = "Goto Prev Diagnotics Serverity ERROR" })
            vim.keymap.set("n", "]E", function()
                require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
            end, { desc = "Goto Next Diagnotics Serverity ERROR" })
        end,
    },
    -- 显示函数的引用和定义信息
    {
        "VidocqH/lsp-lens.nvim",
        lazy = true,
        event = "LspAttach",
        keys = {
            { "<leader>le", "<cmd>LspLensToggle<CR>", desc = "Toggle Lsp Lens" },
        },
        opts = {
            include_declaration = true,
            sections = {
                definition = true,
            },
            ignore_filetype = {
                "markdown",
                "yaml",
                "json",
                "xml",
                "vim",
            },
        },
    },
    -- 调暗未使用的函数、变量、参数
    {
        -- depend = 0.10.0
        "zbirenbaum/neodim",
        enabled = false,
        lazy = true,
        event = "LspAttach",
        opts = {},
    },
    -- 代码大纲
    {
        "stevearc/aerial.nvim",
        lazy = true,
        cmd = "AerialToggle",
        keys = {
            { "<leader>ag", "<cmd>AerialToggle<CR>", desc = "Toggle Aerial" },
            { "<leader>ao", "<cmd>AerialOpenAll<CR>", desc = "Open All Aerial" },
            { "<leader>ac", "<cmd>AerialCloseAll<CR>", desc = "Close All Aerial" },
            { "<leader>ai", "<cmd>AerialInfo<CR>", desc = "Show Aerial Info" },
        },
        config = function()
            require("aerial").setup({
                layout = {
                    min_width = 20,
                    default_direction = "prefer_left",
                },
                show_guides = true,
                highlight_on_hover = true,
                autojump = true,
                on_attach = function(bufnr)
                    vim.keymap.set("n", "[l", "<cmd>AeriaPrev<CR>", { buffer = bufnr })
                    vim.keymap.set("n", "]l", "<cmd>AeriaNext<CR>", { buffer = bufnr })
                end,
            })
        end,
    },
    -- sensebar
    {
        "SmiteshP/nvim-navbuddy",
        lazy = true,
        keys = {
            { "<leader>ny", "<cmd>Navbuddy<CR>", desc = "Show Navbuddy Interface" },
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
            { "nui.nvim" },
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
