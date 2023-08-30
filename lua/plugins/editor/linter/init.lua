return {
    -- 使用lua注入诊断、格式化、补全服务
    {
        "jose-elias-alvarez/null-ls.nvim",
        lazy = true,
        event = { "BufReadPost", "BufNewFile" },
        keys = {
            { "<leader>nui", "<cmd>NullLsInfo<CR>", desc = "Show Null-ls Info" },
            { "<leader>nul", "<cmd>NullLsLog<CR>", desc = "Show Null-ls Log" },
        },
        dependencies = {
            {
                "jay-babu/mason-null-ls.nvim",
                lazy = true,
                cmd = { "NullLsInstall", "NullLsUninstall" },
                dependencies = { "mason.nvim" },
                config = function()
                    require("mason-null-ls").setup({
                        ensure_installed = {
                            "cmake_format",
                            "luacheck",
                            "markdownlint",
                            "ruff",
                            "shellcheck",
                            "jsonlint",
                            "yamllint",
                            "vint",
                            "cspell",
                            "editorconfig_checker",
                        },
                    })
                end,
            },
        },
        config = function()
            local null_ls = require("null-ls")
            local diagnostics = null_ls.builtins.diagnostics

            local sources = {
                -- Diagnostics
                diagnostics.cmake_lint, --cmake
                diagnostics.eslint, --javascript,javascriptact,typescript,typescriptact,vue
                diagnostics.luacheck, --lua
                diagnostics.markdownlint, --markdown
                diagnostics.ruff, --python
                diagnostics.shellcheck, --sh
                diagnostics.zsh, --zsh
                diagnostics.fish, --fish
                -- diagnostics.markuplint, --html
                diagnostics.tidy.with({
                    disabled_filetypes = { "html" },
                }), --xml
                -- diagnostics.stylelint, -- css
                diagnostics.jsonlint, --json
                diagnostics.yamllint, --yaml
                diagnostics.vint, --vim
                diagnostics.cspell.with({
                    disabled_filetypes = {
                        "c",
                        "cpp",
                        "cmake",
                        "javascript",
                        "typescript",
                        "vue",
                        "lua",
                        "markdown",
                        "python",
                        "go",
                        "toml",
                        "bash",
                        "sh",
                        "zsh",
                        "fish",
                        "html",
                        "xml",
                        "css",
                        "json",
                        "yaml",
                        "yml",
                        "vim",
                        "java",
                        "rust",
                    },
                }),
                diagnostics.editorconfig_checker.with({ -- 检测编辑文件
                    disabled_filetypes = { "c", "cpp", "txt", "help", "log" },
                }),
            }
            null_ls.setup({
                sources = sources,
                border = "rounded",
                debug = true,
                diagnostics_config = {
                    underline = true,
                    virtual_text = true,
                    signs = true,
                    update_in_insert = true,
                    severity_sort = true,
                },
                diagnostics_format = "[#{c}] #{m} (#{s})",
            })
        end,
    },
    --显示代码诊断, 参考, telescope结果, quickfix和位置列表
    {
        "folke/trouble.nvim",
        lazy = true,
        cmd = { "TroubleToggle", "Trouble", "TroubleRefresh", "TroubleClose" },
        keys = {
            { "<leader>xt", "<cmd>TroubleToggle<CR>", desc = "Toggle Diagnostics List" },
            { "<leader>xr", "<cmd>TroubleRefresh<CR>", desc = "Refresh Action List" },
            { "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<CR>", desc = "Lsp Workspace Diagnostics" },
            { "<leader>xd", "<cmd>TroubleToggle document_diagnostics<CR>", desc = "Lsp Document Diagnostics" },
            { "<leader>xn", "<cmd>TroubleToggle lsp_definitions<CR>", desc = "Lsp Cursor Word Definition" },
            { "<leader>xf", "<cmd>TroubleToggle lsp_references<CR>", desc = "Lsp Cursor Word References" },
            { "<leader>xq", "<cmd>TroubleToggle quickfix<CR>", desc = "Window Quickfix Project" },
            { "<leader>xl", "<cmd>TroubleToggle loclist<CR>", desc = "Window Local List Project" },
        },
        opts = {
            action_keys = {
                open_split = { "<C-X>" },
                open_vsplit = { "<C-L>" },
                open_tab = { "<C-T>" },
            },
            use_diagnostic_signs = true,
        },
    },
}