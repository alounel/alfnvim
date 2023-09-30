local uv = vim.uv or vim.loop
return {
    -- 使用lua注入诊断、格式化、补全服务
    {
        "nvimtools/none-ls.nvim",
        lazy = true,
        event = { "BufReadPre", "BufNewFile" },
        keys = {
            { "<leader>un", "<cmd>NullLsInfo<CR>", desc = "Show Null-ls Info" },
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
                            "markdownlint",
                            "shellcheck",
                            "jsonlint",
                            "proselint",
                            "editorconfig_checker",
                        },
                    })
                end,
            },
        },
        config = function()
            local none_ls = require("null-ls")
            local diagnostics = none_ls.builtins.diagnostics
            local code_actions = none_ls.builtins.code_actions

            local sources = {
                -- Code_actions
                code_actions.eslint_d, -- javascript,javascriptact,typescript,typescriptact,vue
                code_actions.proselint, -- markdown,tex
                code_actions.shellcheck, -- sh
                -- Diagnostics
                diagnostics.cmake_lint, --cmake
                diagnostics.eslint, --javascript,javascriptact,typescript,typescriptact,vue
                diagnostics.luacheck, --lua
                diagnostics.markdownlint, --markdown
                diagnostics.ruff, --python
                diagnostics.shellcheck, --sh
                diagnostics.zsh, --zsh
                -- diagnostics.markuplint, --html
                diagnostics.tidy.with({
                    disabled_filetypes = { "html" },
                }), --xml
                -- diagnostics.stylelint, -- css
                diagnostics.jsonlint, --json
                diagnostics.yamllint, --yaml
                diagnostics.vint, --vim
                diagnostics.codespell.with({
                    disabled_filetypes = {
                        "c",
                        "cpp",
                        "norg",
                        "text",
                        "toml",
                        "vim",
                        "yaml",
                    },
                }),
                diagnostics.editorconfig_checker.with({
                    disabled_filetypes = { "c", "cpp", "txt", "help", "log", "norg" },
                }),
            }
            none_ls.setup({
                sources = sources,
                border = "rounded",
                debug = false,
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
    -- 补充c,cpp的代码诊断
    {
        "mfussenegger/nvim-lint",
        lazy = true,
        ft = { "c", "cpp" },
        opts = {
            linters_by_ft = {
                c = { "cppcheck" },
                cpp = { "cppcheck" },
            },
            linters = {},
        },
        config = function(_, opts)
            local lint = require("lint")
            lint.linters_by_ft = opts.linters_by_ft
            for k, v in pairs(opts.linters) do
                lint.linters[k] = v
            end
            local timer = assert(uv.new_timer())
            local DEBOUNCE_MS = 500
            local aug = vim.api.nvim_create_augroup("lint", { clear = true })
            vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertEnter" }, {
                group = aug,
                callback = function()
                    local bufnr = vim.api.nvim_get_current_buf()
                    timer:stop()
                    timer:start(
                        DEBOUNCE_MS,
                        0,
                        vim.schedule_wrap(function()
                            if vim.api.nvim_buf_is_valid(bufnr) then
                                vim.api.nvim_buf_call(bufnr, function()
                                    lint.try_lint(nil, { ignore_errors = true })
                                end)
                            end
                        end)
                    )
                end,
            })
            lint.try_lint(nil, { ignore_errors = true })
        end,
    },
    --显示代码诊断, 参考, telescope结果, quickfix和位置列表
    {
        "folke/trouble.nvim",
        lazy = true,
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
