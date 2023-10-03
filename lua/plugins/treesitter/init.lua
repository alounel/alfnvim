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
    -- 突出显示某些类型文件参数的定义和用法
    {
        import = "plugins.extras.treesitter.hlargs",
    },
    -- 上下文环境
    {
        import = "plugins.extras.treesitter.context",
    },
    -- 分割/合并代码块
    {
        import = "plugins.extras.treesitter.spj",
    },
    -- 自动关闭和重命名标签
    {
        import = "plugins.extras.treesitter.autotag",
    },
}
