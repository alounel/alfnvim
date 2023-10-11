return {
    -- LSP 基础服务
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        keys = {
            { "<leader>ui", "<cmd>LspInfo<CR>", desc = "Show Lspconfig Info" },
            { "<leader>us", "<cmd>LspStart<CR>", desc = "Start LspConfig" },
            { "<leader>ut", "<cmd>LspStop<CR>", desc = "Stop Lspconfig" },
            { "<leader>ur", "<cmd>LspRestart<CR>", desc = "Restart LspConfig" },
        },
        dependencies = {
            {
                "folke/neodev.nvim",
                lazy = true,
                opts = {},
            },
            {
                "folke/neoconf.nvim",
                lazy = true,
                cmd = "Neoconf",
                dependencies = { "nvim-lspconfig" },
                opts = {
                    import = {
                        vscode = false,
                        coc = false,
                    },
                },
            },
            -- 连接mason.nvim和lspconfig的桥梁
            {
                "williamboman/mason-lspconfig.nvim",
                lazy = true,
                cmd = { "LspInstall", "LspUninstall" },
                dependencies = { "mason.nvim" },
                -- 不使用mason安装的：tsserver,clangd,neocmake,pyright,yamlls,jsonls,bashls
                -- 缘由：
                -- tsserver:无法单独使用tsc,所以使用包管理器安装
                -- clangd:存在clang-tools-extra包，直接安装比较好
                -- neocmake:未安装cargo
                -- pyright,yamlls,json-lsp,bashls:mason安装带来不必要的node_modules或site-packages
                opts = {
                    ensure_installed = { "jdtls", "lua_ls", "vimls", "marksman", "lemminx" },
                    automatic_installation = false,
                },
            },
        },
        config = function()
            vim.diagnostic.config({
                virtual_text = {
                    spacing = 4,
                    prefix = "●",
                    source = "if_many",
                },
                float = {
                    source = "if_many",
                },
                signs = true,
                underline = true,
                update_in_insert = false,
                severity_sort = true,
            })
            vim.lsp.set_log_level("error")

            local lspconfig = require("lspconfig")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            local clangd_capabilities = vim.tbl_deep_extend("keep", {}, capabilities, {
                offsetEncoding = { "utf-16" },
            })
            local json_capabilities = vim.tbl_deep_extend("keep", {}, capabilities, {
                textDocument = {
                    completion = {
                        completionItem = {
                            snippetSupport = true,
                        },
                    },
                },
            })
            local servers = { "pyright", "vimls", "bashls", "marksman", "lemminx" }

            lspconfig["clangd"].setup({
                cmd = {
                    "clangd",
                    "--background-index",
                    "--clang-tidy",
                    "--header-insertion=iwyu",
                    "--header-insertion-decorators",
                    "--function-arg-placeholders",
                    "--log=verbose",
                    "--enable-config",
                    "--all-scopes-completion",
                    "--clang-tidy-checks=bugprone-*, cert-*, clang-analyzer-*, concurrency-*, cppcoreguidelines-*, google-*, hicpp-*, misc-*, modernize-*, performance-*, portability-*, readability-*",
                },
                init_options = {
                    usePlaceholders = true,
                    completeUnimported = true,
                    clangdFileStatus = true,
                },
                capabilities = clangd_capabilities,
            })

            lspconfig["neocmake"].setup({
                cmd = { "neocmakelsp", "--stdio" },
                filetypes = { "cmake" },
                root_dir = function(fname)
                    return lspconfig.util.find_git_ancestor(fname)
                end,
                single_file_support = true,
                init_options = {
                    format = {
                        enable = false,
                    },
                },
                capabilities = capabilities,
            })

            lspconfig["lua_ls"].setup({
                settings = {
                    diagnostics = {
                        globals = { "vim" },
                    },
                    completion = {
                        callSnippet = "Both",
                    },
                    workspace = {
                        checkThirdParrty = false,
                    },
                },
                capabilities = capabilities,
            })

            lspconfig["jsonls"].setup({
                settings = {
                    json = {
                        schemas = require("schemastore").json.schemas(),
                        validate = { enable = true },
                    },
                },
                capabilities = json_capabilities,
                on_attach = function(bufnr)
                    vim.api.nvim_create_autocmd("CursorHold", {
                        buffer = bufnr,
                        callback = function()
                            local opts = {
                                focusable = false,
                                close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
                                border = "rounded",
                                source = "always",
                                prefix = " ",
                                scope = "cursor",
                            }
                            vim.diagnostic.open_float(nil, opts)
                        end,
                    })
                end,
            })
            lspconfig["yamlls"].setup({
                settings = {
                    yaml = {
                        schemaStore = {
                            enable = false,
                            url = "https://www.schemastore.org/api/json/catalog.json",
                        },
                        schemas = require("schemastore").yaml.schemas(),
                        validate = true,
                    },
                },
                capabilities = capabilities,
            })

            for _, lsp in ipairs(servers) do
                lspconfig[lsp].setup({
                    capabilities = capabilities,
                })
            end
            vim.keymap.set("n", "<leader>lw", vim.diagnostic.open_float, { desc = "Float Window View Diagnostic" })
            vim.keymap.set("n", "[n", vim.diagnostic.goto_prev, { desc = "Goto Prev Diagnostic Location" })
            vim.keymap.set("n", "]n", vim.diagnostic.goto_next, { desc = "Goto Next Diagnostic Location" })
            vim.keymap.set("n", "<leader>lq", vim.diagnostic.setloclist, { desc = "QuickFix Window View Diagnostic" })
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspConifg", {}),
                callback = function(ev)
                    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
                    vim.keymap.set(
                        { "n", "v" },
                        "<leader>lc",
                        vim.lsp.buf.code_action,
                        { buffer = ev.buf, desc = "Code Action" }
                    )
                    vim.keymap.set(
                        "n",
                        "<leader>le",
                        vim.lsp.buf.declaration,
                        { buffer = ev.buf, desc = "View Declaration" }
                    )
                    vim.keymap.set(
                        "n",
                        "<leader>ld",
                        vim.lsp.buf.definition,
                        { buffer = ev.buf, desc = "Show Definition" }
                    )
                    vim.keymap.set(
                        "n",
                        "<leader>lt",
                        vim.lsp.buf.type_definition,
                        { buffer = ev.buf, desc = "Show Type Definition" }
                    )
                    vim.keymap.set(
                        "n",
                        "<leader>li",
                        vim.lsp.buf.implementation,
                        { buffer = ev.buf, desc = "Implementation" }
                    )
                    vim.keymap.set("n", "<leader>lh", vim.lsp.buf.hover, { buffer = ev.buf, desc = "Show Hover" })
                    vim.keymap.set(
                        "n",
                        "<leader>ls",
                        vim.lsp.buf.signature_help,
                        { buffer = ev.buf, desc = "Signature Help" }
                    )
                    vim.keymap.set(
                        "n",
                        "<leader>la",
                        vim.lsp.buf.add_workspace_folder,
                        { buffer = ev.buf, desc = "Add Workspace Folder" }
                    )
                    vim.keymap.set(
                        "n",
                        "<leader>lm",
                        vim.lsp.buf.remove_workspace_folder,
                        { buffer = ev.buf, desc = "Remove Workspace Folder" }
                    )
                    vim.keymap.set("n", "<leader>ll", function()
                        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                    end, { buffer = ev.buf, desc = "Print Workspace Folder List" })
                    vim.keymap.set("n", "<leader>ln", vim.lsp.buf.rename, { buffer = ev.buf, desc = "Rename" })
                    vim.keymap.set("n", "<leader>lr", vim.lsp.buf.references, { buffer = ev.buf, desc = "References" })
                    vim.keymap.set("n", "<leader>lf", function()
                        vim.lsp.buf.format({ async = true })
                    end, { buffer = ev.buf, desc = "Async Format" })
                end,
            })
        end,
    },
    -- lsp增强插件
    {
        import = "plugins.extras.lsp.strength",
    },
    -- 语言增强插件
    {
        import = "plugins.extras.lsp.extensions",
    },
}
