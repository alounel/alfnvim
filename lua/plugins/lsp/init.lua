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
            local lspconfig = require("lspconfig")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            capabilities.textDocument.completion.completionItem.snippetSupport = true --jsonls需要的代码片段支持
            local servers = { "pyright", "vimls", "bashls", "marksman", "lemminx" }

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
                    "--clang-tidy-checks=bugprone-*, cert-*, clang-analyzer-*, concurrency-*, cppcoreguidelines-*, google-*, hicpp-*, misc-*, modernize-*, performance-*, portability-*, readability-*",
                },
                capabilities = capabilities,
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
            lspconfig["jsonls"].setup({
                settings = {
                    json = {
                        schemas = require("schemastore").json.schemas(),
                        validate = { enable = true },
                    },
                },
                capabilities = capabilities,
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
            vim.keymap.set("n", "<leader>lf", vim.diagnostic.open_float, { desc = "Open Float In Vim Diagnostic" })
            vim.keymap.set("n", "<leader>lp", vim.diagnostic.goto_prev, { desc = "Goto Prev In Vim Diagnostic" })
            vim.keymap.set("n", "<leader>ln", vim.diagnostic.goto_next, { desc = "Goto Next In Vim Diagnostic" })
            vim.keymap.set("n", "<leader>lq", vim.diagnostic.setloclist, { desc = "Setloclist In Vim Diagnostic" })
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspConifg", {}),
                callback = function(ev)
                    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
                    vim.keymap.set(
                        "n",
                        "<leader>lce",
                        vim.lsp.buf.declaration,
                        { buffer = ev.buf, desc = "Lsp Declaration" }
                    )
                    vim.keymap.set(
                        "n",
                        "<leader>lcd",
                        vim.lsp.buf.definition,
                        { buffer = ev.buf, desc = "Lsp Show Definition" }
                    )
                    vim.keymap.set("n", "<leader>lch", vim.lsp.buf.hover, { buffer = ev.buf, desc = "Lsp Show Hover" })
                    vim.keymap.set(
                        "n",
                        "<leader>lci",
                        vim.lsp.buf.implementation,
                        { buffer = ev.buf, desc = "Lsp Implementation" }
                    )
                    vim.keymap.set(
                        "n",
                        "<leader>lcs",
                        vim.lsp.buf.signature_help,
                        { buffer = ev.buf, desc = "Lsp Signature Help" }
                    )
                    vim.keymap.set(
                        "n",
                        "<leader>lca",
                        vim.lsp.buf.add_workspace_folder,
                        { buffer = ev.buf, desc = "Lsp Add Workspace Folder" }
                    )
                    vim.keymap.set(
                        "n",
                        "<leader>lcm",
                        vim.lsp.buf.remove_workspace_folder,
                        { buffer = ev.buf, desc = "Lsp Remove Workspace Folder" }
                    )
                    vim.keymap.set("n", "<leader>lcl", function()
                        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                    end, { buffer = ev.buf, desc = "Lsp List Workspace Folder" })
                    vim.keymap.set(
                        "n",
                        "<leader>lct",
                        vim.lsp.buf.type_definition,
                        { buffer = ev.buf, desc = "Lsp Show Type Definition" }
                    )
                    vim.keymap.set("n", "<leader>lcn", vim.lsp.buf.rename, { buffer = ev.buf, desc = "Lsp Rename" })
                    vim.keymap.set(
                        { "n", "v" },
                        "<leader>lcc",
                        vim.lsp.buf.code_action,
                        { buffer = ev.buf, desc = "Lsp Code Action" }
                    )
                    vim.keymap.set(
                        "n",
                        "<leader>lcr",
                        vim.lsp.buf.references,
                        { buffer = ev.buf, desc = "Lsp References" }
                    )
                    vim.keymap.set("n", "<leader>lcf", function()
                        vim.lsp.buf.format({ async = true })
                    end, { buffer = ev.buf, desc = "Lsp Format" })
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
        import = "plugins.extras.lsp.lang",
    },
}
