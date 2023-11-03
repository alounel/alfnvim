return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = { ":TSUpdate" },
        lazy = true,
        event = { "BufReadPost", "BufNewFile" },
        cmd = { "TSUpdate", "TSUpdateSync" },
        init = function(plugin)
            require("lazy.core.loader").add_to_rtp(plugin)
            require("nvim-treesitter.query_predicates")
        end,
        dependencies = {
            --语法感知文本对象、选择、移动、交换和查看支持
            {
                "nvim-treesitter/nvim-treesitter-textobjects",
                config = function()
                    local move = require("nvim-treesitter.textobjects.move")
                    local configs = require("nvim-treesitter.configs")
                    for name, fn in pairs(move) do
                        if name:find("goto") == 1 then
                            move[name] = function(q, ...)
                                if vim.wo.diff then
                                    local config = configs.get_module("textobjects.move")[name]
                                    for key, query in pairs(config or {}) do
                                        if q == query and key:find("[%]%[][cC]") then
                                            vim.cmd("normal! " .. key)
                                            return
                                        end
                                    end
                                end
                                return fn(q, ...)
                            end
                        end
                    end
                end,
            },
            -- 为lua,vim,bash,fish文件内部函数添加end
            { "RRethy/nvim-treesitter-endwise" },
        },
        keys = {
            { "<C-space>", desc = "Increment Selection" },
            { "<bs>", mode = "x", desc = "Decrement Selection" },
        },
        opts = {
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
                    init_selection = "<C-space>",
                    node_incremental = "<C-space>",
                    node_decremental = false,
                    scope_incremental = "<BS>",
                },
            },
            indent = { enable = true },
            endwise = { enable = true },
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true,
                    keymaps = {
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                        ["ac"] = "@class.outer",
                        ["ic"] = "@class.inner",
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
                        ["<leader>ap"] = "@parameter.inner",
                    },
                    swap_previous = {
                        ["<leader>aP"] = "@parameter.inner",
                    },
                },
                move = {
                    enable = true,
                    set_jumps = true,
                    goto_next_start = {
                        ["]f"] = "@function.outer",
                        ["]c"] = "@class.outer",
                        ["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
                        ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
                    },
                    goto_next_end = {
                        ["]F"] = "@function.outer",
                        ["]C"] = "@class.outer",
                    },
                    goto_previous_start = {
                        ["[f"] = "@function.outer",
                        ["[c"] = "@class.outer",
                    },
                    goto_previous_end = {
                        ["[F"] = "@function.outer",
                        ["[C"] = "@class.outer",
                    },
                    goto_next = {
                        ["]d"] = "@conditional.outer",
                    },
                    goto_previous = {
                        ["[d"] = "@conditional.outer",
                    },
                },
            },
        },
        config = function(_, opts)
            if type(opts.ensure_installed) == "table" then
                local added = {}
                opts.ensure_installed = vim.tbl_filter(function(lang)
                    if added[lang] then
                        return false
                    end
                    added[lang] = true
                    return true
                end, opts.ensure_installed)
            end
            require("nvim-treesitter.configs").setup(opts)
        end,
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
    -- 根据光标在文件中的位置设置注释字符串
    {
        import = "plugins.extras.treesitter.commentstring",
    },
}
