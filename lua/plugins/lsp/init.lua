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
            { "folke/neodev.nvim", opts = {} },
            { "folke/neoconf.nvim", cmd = "Neoconf", config = false, dependencies = { "nvim-lspconfig" } },
            {
                "williamboman/mason-lspconfig.nvim",
                lazy = true,
                cmd = { "LspInstall", "LspUninstall" },
                dependencies = { "mason.nvim" },
                opts = {
                    ensure_installed = { "marksman", "lemminx" },
                    automatic_installation = false,
                },
            },
        },
        opts = {
            diagnostics = {
                signs = true,
                underline = true,
                update_in_insert = false,
                severity_sort = true,
                virtual_text = {
                    spacing = 4,
                    prefix = "●",
                    source = "if_many",
                },
                float = {
                    source = "if_many",
                },
            },
            inlay_hints = {
                enabled = false,
            },
        },
        config = function(_, opts)
            local Util = require("config.util")

            if opts.inlay_hints.enabled then
                Util.lsp.on_attach(function(client, buffer)
                    if client.supports_method("textDocument/inlayHint") then
                        Util.toggle.inlay_hints(buffer, true)
                    end
                end)
            end

            if type(opts.diagnostics.virtual_text) == "table" and opts.diagnostics.virtual_text.prefix == "icons" then
                opts.diagnostics.virtual_text.prefix = vim.fn.has("nvim-0.10.0") == 0 and "●"
                    or function(diagnostic)
                        local icons = require("core.icons").icons.diagnostics
                        for d, icon in pairs(icons) do
                            if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
                                return icon
                            end
                        end
                    end
            end

            vim.diagnostic.config(vim.deepcopy(opts.diagnostics))
            vim.lsp.set_log_level("error")

            if Util.has("neoconf.nvim") then
                local plugin = require("lazy.core.config").spec.plugins["neoconf.nvim"]
                require("neoconf").setup(require("lazy.core.plugin").values(plugin, "opts", false))
            end

            local lspconfig = require("lspconfig")

            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            -- 作为添加项而不是代替项
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
            local neocmake_capabilities = vim.tbl_deep_extend("keep", {}, capabilities, {
                workspace = {
                    didChangeWatchedFiles = {
                        dynamicRegistration = true,
                    },
                },
            })

            local servers = { "vimls", "bashls", "marksman", "lemminx", "lua_ls" }

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
                    scan_cmake_in_package = true,
                },
                capabilities = neocmake_capabilities,
            })

            lspconfig["jsonls"].setup({
                settings = {
                    json = {
                        schemas = require("schemastore").json.schemas(),
                        validate = { enable = true },
                    },
                },
                capabilities = json_capabilities,
            })
            lspconfig["yamlls"].setup({
                settings = {
                    yaml = {
                        schemaStore = {
                            enable = false,
                            url = "",
                        },
                        schemas = require("schemastore").yaml.schemas(),
                        validate = true,
                    },
                },
                capabilities = capabilities,
            })

            lspconfig["pyright"].setup({
                settings = {
                    python = {
                        analysis = {
                            autoSearchPaths = true,
                            diagnosticMode = "workspace",
                            typeCheckingMode = "strict",
                            useLibraryCodeForTypes = true,
                        },
                    },
                },
                capabilities = capabilities,
            })

            for _, lsp in ipairs(servers) do
                lspconfig[lsp].setup({
                    capabilities = capabilities,
                })
            end

            require("plugins.lsp.keymaps")
        end,
    },
}
