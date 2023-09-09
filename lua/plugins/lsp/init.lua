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
            -- 连接mason.nvim和lspconfig的桥梁
            {
                "williamboman/mason-lspconfig.nvim",
                lazy = true,
                cmd = { "LspInstall", "LspUninstall" },
                dependencies = { "mason.nvim" },
                -- 不使用mason安装的：tsserver,clangd,neocmake
                -- 缘由：
                -- tsserver:无法使用tsc,所以使用包管理器安装
                -- clangd:存在clang-tools-extra包，直接安装比较好
                -- neocmake:未安装cargo
                opts = {
                    ensure_installed = {
                        "jdtls",
                        "lua_ls",
                        "jsonls",
                        "yamlls",
                        "pyright",
                        "vimls",
                        "bashls",
                        "marksman",
                        "lemminx",
                    },
                    automatic_installation = false,
                },
            },
        },
        config = function()
            local lspconfig = require("lspconfig")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            capabilities.textDocument.completion.completionItem.snippetSupport = true --jsonls需要的代码片段支持
            local servers = { "pyright", "neocmake", "vimls", "bashls", "marksman", "lemminx" }

            lspconfig["lua_ls"].setup({
                on_init = function(client)
                    local path = client.workspace_folders[1].name
                    if not vim.uv.fs_stat(path .. "/.luarc.json") and not vim.uv.fs_stat(path .. "/.luarc.jsonc") then
                        client.config.settings = vim.tbl_deep_extend("force", client.config.settings, {
                            lua = {
                                diagnostics = {
                                    globals = { "vim" },
                                },
                                completion = {
                                    callSnippet = "Replace",
                                },
                                workspace = {
                                    checkThirdParrty = false,
                                    library = { vim.env.VIMRUNTIME },
                                },
                            },
                        })
                        client.notify("workspace/didChangeConfiguration", {
                            settings = client.config.settings,
                        })
                    end
                    return true
                end,
                capabilities = capabilities,
            })
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
                    "--clang-tidy-checks=performance-*, bugprone-*, misc-*, google-*, modernize-*, readability-*, portability-*,cppcoreguidelines-*",
                },
            })
            lspconfig["jsonls"].setup({
                settings = {
                    json = {
                        schemas = require("schemastore").json.schemas(),
                        vaildate = { enable = true },
                    },
                },
                capabilities = capabilities,
            })
            lspconfig["yamlls"].setup({
                settings = {
                    yaml = {
                        schemaStore = {
                            enable = false,
                            url = "",
                        },
                        schemas = require("schemastore").yaml.schemas(),
                    },
                },
                capabilities = capabilities,
            })
            for _, lsp in ipairs(servers) do
                lspconfig[lsp].setup({
                    capabilities = capabilities,
                })
            end
            vim.keymap.set("n", "<leader>lf", vim.diagnostic.open_float, { desc = "Open Float In Vim Diagnostic" })
            vim.keymap.set("n", "<leader>lp", vim.diagnostic.goto_prev, { desc = "Goto Prev In Vim Diagnostic" })
            vim.keymap.set("n", "<leader>ln", vim.diagnostic.goto_next, { desc = "Goto Next In Vim Diagnostic" })
            vim.keymap.set("n", "<leader>lq", vim.diagnostic.setloclist, { desc = "Setloclist In Vim Diagnostic" })
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspConifg", {}),
                callback = function(ev)
                    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
                    local bufopts = { buffer = ev.buf }
                    vim.keymap.set("n", "<leader>lce", vim.lsp.buf.declaration, bufopts)
                    vim.keymap.set("n", "<leader>lcd", vim.lsp.buf.definition, bufopts)
                    vim.keymap.set("n", "<leader>lch", vim.lsp.buf.hover, bufopts)
                    vim.keymap.set("n", "<leader>lci", vim.lsp.buf.implementation, bufopts)
                    vim.keymap.set("n", "<leader>lcs", vim.lsp.buf.signature_help, bufopts)
                    vim.keymap.set("n", "<leader>lca", vim.lsp.buf.add_workspace_folder, bufopts)
                    vim.keymap.set("n", "<leader>lcm", vim.lsp.buf.remove_workspace_folder, bufopts)
                    vim.keymap.set("n", "<leader>lcl", function()
                        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                    end, bufopts)
                    vim.keymap.set("n", "<leader>lct", vim.lsp.buf.type_definition, bufopts)
                    vim.keymap.set("n", "<leader>lcn", vim.lsp.buf.rename, bufopts)
                    vim.keymap.set("n", "<leader>lcc", vim.lsp.buf.code_action, bufopts)
                    vim.keymap.set("n", "<leader>lcr", vim.lsp.buf.references, bufopts)
                    vim.keymap.set("n", "<leader>lcf", function()
                        vim.lsp.buf.format({ async = true })
                    end, bufopts)
                end,
            })
        end,
    },
    -- lsp增强插件
    {
        import = "plugins.lsp.lsputil",
    },
    {
        import = "plugins.lsp.langutil",
    },
}
