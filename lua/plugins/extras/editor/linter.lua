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

            local default_sources = {}

            local code_actions_servers = { "eslint_d", "shellcheck" }
            for _, action in ipairs(code_actions_servers) do
                table.insert(default_sources, code_actions[action])
            end

            local diagnostics_servers = {
                "clang_check", -- c/cpp
                "cmake_lint", -- cmake
                "eslint", -- ts,js,tsx,jsx
                "selene", -- lua,luau
                "ltrs", -- markdown,text
                "vint", -- vim
                "yamllint", -- yaml
                "zsh", -- zsh
            }
            for _, diag in ipairs(diagnostics_servers) do
                table.insert(default_sources, diagnostics[diag])
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
        ft = {
            "json",
            "markdown",
            "python",
            "sh",
        },
        opts = {
            events = { "BufWritePost", "BufReadPost", "InsertLeave" },
            linters_by_ft = {
                json = { "jsonlint" },
                markdown = { "markdownlint" },
                python = { "ruff" },
                sh = { "shellcheck" },
            },
            linters = {},
        },
        config = function(_, opts)
            local M = {}

            local lint = require("lint")
            for name, linter in pairs(opts.linters) do
                if type(linter) == "table" and type(lint.linters) == "table" then
                    lint.linters[name] = vim.tbl_deep_extend("force", lint.linters[name], linter)
                end
            end
            lint.linters_by_ft = opts.linters_by_ft

            function M.debounce(ms, fn)
                local timer = vim.loop.new_timer()
                return function(...)
                    local argv = { ... }
                    timer:start(ms, 0, function()
                        timer:stop()
                        vim.schedule_wrap(fn)(unpack(argv))
                    end)
                end
            end

            function M.lint()
                local names = lint.linters_by_ft[vim.bo.filetype] or {}
                local ctx = { filename = vim.api.nvim_buf_get_name(0) }
                ctx.dirname = vim.fn.fnamemodify(ctx.filename, ":h")
                names = vim.tbl_filter(function(name)
                    local linter = lint.linters[name]
                    return linter and not (type(linter) == "table" and linter.condition and not linter.condition(ctx))
                end, names)

                if #names > 0 then
                    lint.try_lint(names)
                end
            end

            vim.api.nvim_create_autocmd(opts.events, {
                group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
                callback = M.debounce(100, M.lint),
            })
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
