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
                        automatic_installation = false,
                    })
                end,
            },
        },
        config = function()
            local none_ls = require("null-ls")
            local diagnostics = none_ls.builtins.diagnostics
            local code_actions = none_ls.builtins.code_actions
            local hovers = none_ls.builtins.hover

            local default_sources = {}

            local code_actions_servers = { "eslint_d", "proselint", "shellcheck" }
            for _, action in ipairs(code_actions_servers) do
                table.insert(default_sources, code_actions[action])
            end

            local diagnostics_servers = {
                "clang_check", -- c/cpp
                "cmake_lint", -- cmake
                "eslint", -- ts,js,tsx,jsx
                "luacheck", -- lua
                "selene", -- lua,luau
                "markdownlint", -- markdown
                "ltrs", -- markdown,text
                "jsonlint", -- json
                "ruff", -- python
                "shellcheck", -- sh
                "vint", -- vim
                "yamllint", -- yaml
                "zsh", -- zsh
            }
            for _, diag in ipairs(diagnostics_servers) do
                table.insert(default_sources, diagnostics[diag])
            end

            local hover_servers = { "dictionary" }
            for _, hover in ipairs(hover_servers) do
                table.insert(default_sources, hovers[hover])
            end

            local conf_sources = {
                diagnostics.tidy.with({
                    disabled_filetypes = { "html" },
                }),
                diagnostics.typos.with({
                    disabled_filetypes = { "help", "markdown", "norg", "tex", "text", "vimdoc" },
                }),
                diagnostics.editorconfig_checker.with({
                    disabled_filetypes = { "help", "log", "norg", "tex", "text", "vimdoc" },
                }),
            }

            local sources = {}
            for _, source in ipairs(default_sources) do
                table.insert(sources, source)
            end
            for _, source in ipairs(conf_sources) do
                table.insert(sources, source)
            end
            -- local sources = {
            --     -- diagnostics.markuplint, --html
            --     -- diagnostics.stylelint, -- css
            --     }
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
                log_level = "error",
            })
        end,
    },
    -- 对某些文件不使用类似代码注入方式诊断的代码诊断
    {
        "mfussenegger/nvim-lint",
        lazy = true,
        opts = {
            linters_by_ft = {},
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
            vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "BufNewFile", "InsertEnter" }, {
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
