return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = { ":TSUpdate" },
        lazy = true,
        event = { "BufReadPost", "BufNewFile" },
        cmd = { "TSUpdate", "TSUpdateSync" },
        dependencies = {
            --语法感知文本对象、选择、移动、交换和查看支持
            { "nvim-treesitter/nvim-treesitter-textobjects", lazy = true },
            -- 根据光标在文件中的位置设置注释字符串
            { "JoosepAlviste/nvim-ts-context-commentstring", lazy = true },
            -- 重构模块
            { "nvim-treesitter/nvim-treesitter-refactor", lazy = true },
            -- 自动添加end
            { "RRethy/nvim-treesitter-endwise", lazy = true },
        },
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "c",
                    "cpp",
                    "python",
                    "java",
                    "cmake",
                    "javascript",
                    "typescript",
                    "bash",
                    "yaml",
                    "vim",
                    "json",
                    "lua",
                    "xml",
                    "vimdoc",
                    "markdown",
                    "markdown_inline",
                    "regex",
                    "query",
                    "norg",
                },
                sync_install = true,
                auto_install = true,
                ignore_install = {},
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
                -- 增量选择
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "gnn",
                        node_incremental = "grn",
                        node_decremental = "grc",
                        scope_incremental = "grm",
                    },
                },
                indent = {
                    enable = true,
                },
                endwise = {
                    enable = true,
                },
                refactor = {
                    highlight_definitions = {
                        enable = true,
                        clear_on_cursor_move = true,
                    },
                    highlight_current_scope = {
                        enable = false,
                    },
                    smart_rename = {
                        enable = true,
                        keymaps = {
                            smart_rename = "grr",
                        },
                    },
                    navigation = {
                        enable = true,
                        keymaps = {
                            goto_definition = "gnd",
                            list_definitions = "gnD",
                            list_definitions_toc = "gnO",
                            goto_next_usage = "<M-*>",
                            goto_previous_usage = "<M-#>",
                        },
                    },
                },
                context_commentstring = {
                    enable = true,
                    enable_autocmd = false,
                },
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true,
                        keymaps = {
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["ac"] = "@class.outer",
                            ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
                            ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
                        },
                        selection_modes = {
                            ["@parameter.outer"] = "v",
                            ["@function.outer"] = "V",
                            ["@class.outer"] = "<M-v>",
                        },
                        include_surrounding_whitespace = true,
                    },
                    swap = {
                        enable = true,
                        swap_next = {
                            ["<leader>aa"] = "@parameter.inner",
                        },
                        swap_previous = {
                            ["<leader>A"] = "@parameter.inner",
                        },
                    },
                    move = {
                        enable = true,
                        set_jumps = true,
                        goto_next_start = {
                            ["]m"] = "@function.outer",
                            ["]]"] = { query = "@class.outer", desc = "Next class start" },
                            ["]o"] = "@loop.*",
                            ["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
                            ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
                        },
                        goto_next_end = {
                            ["]M"] = "@function.outer",
                            ["]["] = "@class.outer",
                        },
                        goto_previous_start = {
                            ["[m"] = "@function.outer",
                            ["[["] = "@class.outer",
                        },
                        goto_previous_end = {
                            ["[M"] = "@function.outer",
                            ["[]"] = "@class.outer",
                        },
                        goto_next = {
                            ["]d"] = "@conditional.outer",
                        },
                        goto_previous = {
                            ["[d"] = "@conditional.outer",
                        },
                    },
                    lsp_interop = {
                        enable = true,
                        border = "rounded",
                        floating_preview_opts = {},
                        peek_definition_code = {
                            ["<leader>df"] = "@function.outer",
                            ["<leader>dF"] = "@class.outer",
                        },
                    },
                },
            })
        end,
    },
    ------ 依赖于treesitter的插件 ------
    -- 突出显示参数的定义和用法
    {
        "m-demare/hlargs.nvim",
        lazy = true,
        ft = { "c", "cpp", "java", "javascript", "lua", "python", "typescript", "vim" },
        dependencies = { "nvim-treesitter" },
        opts = {},
        keys = {
            { "<leader>kr", "<cmd>lua require('hlargs').toggle()<CR>", desc = "Toggle Highlight Args" },
        },
    },
    -- 在函数、方法、语句等之后显示当前上下文的虚拟文本
    {
        "haringsrob/nvim_context_vt",
        lazy = true,
        keys = {
            { "<leader>kv", "<cmd>NvimContextVtToggle<CR>", desc = "Toggle Context Virtual Text" },
            { "<leader>kd", "<cmd>NvimContextVtDebugCR>", desc = "Context Virtual Text Debug" },
        },
        dependencies = { "nvim-treesitter" },
        opts = {
            prefix = "",
            disable_ft = { "markdown" },
            disable_virtual_lines_ft = { "yaml", "toml" },
        },
    },
    -- 将函数头显示在界面前几行
    {
        "nvim-treesitter/nvim-treesitter-context",
        lazy = true,
        event = { "BufReadPost", "BufNewFile" },
        keys = {
            { "<leader>kt", "<cmd>TSContextToggle<CR>", desc = "Toggle Context" },
        },
        dependencies = { "nvim-treesitter" },
        config = function()
            require("treesitter-context").setup()
            vim.keymap.set("n", "[c", function()
                require("treesitter-context").go_to_context()
            end, { desc = "Jump Context" })
        end,
    },
    -- 分割/合并代码块
    {
        "Wansmer/treesj",
        lazy = true,
        keys = {
            { "<leader>jg", "<cmd>TSJToggle<CR>", desc = "Toggle Node" },
        },
        config = function()
            require("treesj").setup({
                use_default_keymaps = false,
            })
        end,
    },
    -- 自动关闭和重命名标签
    {
        "windwp/nvim-ts-autotag",
        lazy = true,
        ft = {
            "xml",
            "html",
            "markdown",
            "javascript",
            "typescript",
            "javascriptreact",
            "typescriptreact",
            "jsx",
            "tsx",
        },
        dependencies = { "nvim-treesitter" },
        opts = {
            filetypes = {
                "xml",
                "html",
                "markdown",
                "javascript",
                "typescript",
                "javascriptreact",
                "typescriptreact",
                "jsx",
                "tsx",
            },
        },
    },
}
