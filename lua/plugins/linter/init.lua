local uv = vim.loop or vim.uv

return {
    -- 使用lua注入诊断
    {
        "nvimtools/none-ls.nvim",
        lazy = true,
        event = { "BufReadPost", "BufNewFile" },
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
                        ensure_installed = { "cmake_format", "markdownlint", "shellcheck", "jsonlint" },
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

            local code_actions_servers = { "eslint", "ltrs" }
            for _, action in ipairs(code_actions_servers) do
                table.insert(default_sources, code_actions[action])
            end

            local diagnostics_servers = { "cmake_lint", "ltrs", "selene", "zsh" }
            for _, diag in ipairs(diagnostics_servers) do
                table.insert(default_sources, diagnostics[diag])
            end

            local conf_sources = {
                diagnostics.typos.with({
                    disabled_filetypes = { "help", "log", "markdown", "norg", "tex", "text" },
                }),
                diagnostics.editorconfig_checker.with({
                    disabled_filetypes = { "help", "log", "markdown", "norg", "tex", "text" },
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
    -- 不使用类似代码注入方式诊断的代码诊断
    {
        "mfussenegger/nvim-lint",
        lazy = true,
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            events = { "BufWritePost", "BufReadPost", "InsertLeave" },
            linters_by_ft = {
                env = { "dotenv_linter" },
                javascript = { "eslint", "biomejs" },
                javascriptreact = { "eslint", "biomejs" },
                typescript = { "eslint", "biomejs" },
                typescriptreact = { "eslint", "biomejs" },
                json = { "jsonlint", "biomejs" },
                jsonc = { "biomejs" },
                lua = { "luacheck" },
                markdown = { "markdownlint" },
                python = { "ruff" },
                sh = { "shellcheck" },
                vim = { "vint" },
                yaml = { "yamllint" },
            },
            linters = {},
        },
        config = function(_, opts)
            local Util = require("config.util")

            local M = {}

            local lint = require("lint")
            for name, linter in pairs(opts.linters) do
                if type(linter) == "table" and type(lint.linters[name]) == "table" then
                    lint.linters[name] = vim.tbl_deep_extend("force", lint.linters[name], linter)
                else
                    lint.linters[name] = linter
                end
            end
            lint.linters_by_ft = opts.linters_by_ft

            function M.debounce(ms, fn)
                local timer = uv.new_timer()
                return function(...)
                    local argv = { ... }
                    timer:start(ms, 0, function()
                        timer:stop()
                        vim.schedule_wrap(fn)(unpack(argv))
                    end)
                end
            end

            function M.lint()
                local names = lint._resolve_linter_by_ft(vim.bo.filetype)
                if #names == 0 then
                    vim.list_extend(names, lint.linters_by_ft["_"] or {})
                end
                vim.list_extend(names, lint.linters_by_ft["*"] or {})

                local ctx = { filename = vim.api.nvim_buf_get_name(0) }
                ctx.dirname = vim.fn.fnamemodify(ctx.filename, ":h")
                names = vim.tbl_filter(function(name)
                    local linter = lint.linters[name]
                    if not linter then
                        Util.warn("Linter not found: " .. name, { title = "nvim-lint" })
                    end
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
        cmd = "TroubleToggle",
        keys = {
            { "<leader>xr", "<cmd>TroubleRefresh<CR>", desc = "Refresh Action List" },
            {
                "<leader>xg",
                function()
                    require("trouble").toggle()
                end,
                desc = "Toggle Diagnostics List",
            },
            {
                "<leader>xw",
                function()
                    require("trouble").toggle("workspace_diagnostics")
                end,
                desc = "Lsp Workspace Diagnostics",
            },
            {
                "<leader>xd",
                function()
                    require("trouble").toggle("document_diagnostics")
                end,
                desc = "Lsp Document Diagnostics",
            },
            {
                "<leader>xn",
                function()
                    require("trouble").toggle("lsp_definitions")
                end,
                desc = "Lsp Word Definition",
            },
            {
                "<leader>xt",
                function()
                    require("trouble").toggle("lsp_type_definitions")
                end,
                desc = "Lsp Word Type Definition",
            },
            {
                "<leader>xq",
                function()
                    require("trouble").toggle("quickfix")
                end,
                desc = "Quickfix list For Trouble",
            },
            {
                "<leader>xl",
                function()
                    require("trouble").toggle("loclist")
                end,
                desc = "Local List For Trouble",
            },
            {
                "gR",
                function()
                    require("trouble").toggle("lsp_references")
                end,
                desc = "Goto References For Trouble",
            },
            {
                "[Q",
                function()
                    if require("trouble").is_open() then
                        require("trouble").previous({ skip_groups = true, jump = true })
                    else
                        local ok, err = pcall(vim.cmd.cprev)
                        if not ok then
                            vim.notify(err, vim.log.levels.ERROR)
                        end
                    end
                end,
                desc = "Previous Trouble/Quickfix Item",
            },
            {
                "[Q",
                function()
                    if require("trouble").is_open() then
                        require("trouble").next({ skip_groups = true, jump = true })
                    else
                        local ok, err = pcall(vim.cmd.cprev)
                        if not ok then
                            vim.notify(err, vim.log.levels.ERROR)
                        end
                    end
                end,
                desc = "Next Trouble/Quickfix Item",
            },
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
