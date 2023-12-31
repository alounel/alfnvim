return {
    -- 片段支持
    {
        "L3MON4D3/luasnip",
        build = "make install_jsregexp",
        lazy = true,
        event = "InsertEnter",
        dependencies = { "rafamadriz/friendly-snippets" },
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
            require("luasnip.loaders.from_snipmate").lazy_load({ path = { vim.fn.stdpath("config") .. "snippets" } })
            require("luasnip").setup({
                update_events = { "TextChanged", "TextChangedI" },
                delete_check_events = "TextChanged",
            })
        end,
    },
    {
        "hrsh7th/nvim-cmp",
        event = { "InsertEnter", "CmdlineEnter" },
        dependencies = {
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-cmdline",
            "FelipeLema/cmp-async-path",
            "lukas-reineke/cmp-rg",
            "f3fora/cmp-spell",
        },
        opts = function()
            local defaults = require("cmp.config.default")()
            local luasnip = require("luasnip")
            local cmp = require("cmp")
            vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })

            return {
                completion = {
                    completeopt = "menu,menuone,noinsert",
                },
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "async_path" },
                    { name = "buffer" },
                    {
                        name = "rg",
                        keyword_length = 3,
                    },
                    { name = "spell" },
                }),
                formatting = {
                    format = function(entry, vim_item)
                        vim_item.kind =
                            string.format("%s %s", require("core.icons").icons.kinds[vim_item.kind], vim_item.kind)
                        vim_item.menu = ({
                            buffer = "[Buffer]",
                            nvim_lsp = "[LSP]",
                            luasnip = "[LuaSnip]",
                            spell = "[Spell]",
                            rg = "[Rg]",
                            async_path = "[Path]",
                            cmdline = "[Cmdline]",
                        })[entry.source.name]
                        return vim_item
                    end,
                },
                experimental = {
                    ghost_text = {
                        hl_group = "CmpGhostText",
                    },
                },
                sorting = defaults.sorting,

                mapping = cmp.mapping.preset.insert({
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping.confirm({
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = true,
                    }),
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                }),
            }
        end,
        config = function(_, opts)
            local cmp = require("cmp")
            for _, source in ipairs(opts.sources) do
                source.group_index = source.group_index or 1
            end
            cmp.setup(opts)

            cmp.setup.cmdline({ "/", "?" }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = "buffer" },
                }),
            })
            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = "async_path" },
                }, {
                    { name = "cmdline" },
                }),
            })

            cmp.event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())
        end,
    },
}
