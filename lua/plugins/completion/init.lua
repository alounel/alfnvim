-- nvim-cmp的补全及其代码片段插件
return {
    -- 代码片段支持
    {
        "L3MON4D3/luasnip",
        version = "2.*",
        build = "make install_jsregexp",
        event = "InsertEnter",
        dependencies = { "rafamadriz/friendly-snippets" },
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
            require("luasnip.loaders.from_lua").lazy_load()
            require("luasnip.loaders.from_snipmate").lazy_load()
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
            { "saadparwaiz1/cmp_luasnip", lazy = true },
            { "hrsh7th/cmp-nvim-lsp", lazy = true },
            { "hrsh7th/cmp-buffer", lazy = true },
            { "hrsh7th/cmp-cmdline", lazy = true },
            { "FelipeLema/cmp-async-path", lazy = true },
            { "lukas-reineke/cmp-rg", lazy = true },
            { "f3fora/cmp-spell", lazy = true },
            { "lukas-reineke/cmp-under-comparator" },
        },
        config = function()
            local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            local handlers = require("nvim-autopairs.completion.handlers")
            local luasnip = require("luasnip")
            local cmp = require("cmp")
            cmp.setup({
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
                    {
                        name = "luasnip",
                    },
                    { name = "nvim_lsp" },
                    { name = "async_path" },
                    {
                        name = "buffer",
                        option = {
                            keyword_pattern = [[\k\+]],
                            get_bufnrs = function()
                                local bufs = {}
                                for _, win in ipairs(vim.api.nvim_list_wins()) do
                                    bufs[vim.api.nvim_win_get_buf(win)] = true
                                end
                                return vim.tbl_keys(bufs)
                            end,
                        },
                    },
                    {
                        name = "rg",
                        keyword_length = 3,
                    },
                    { name = "spell" },
                }),
                -- 格式化补全菜单
                -- formatting = {
                --     format = require("lspkind").cmp_format({
                --         mode = "symbol_text",
                --         with_text = true,
                --         maxwidth = 50,
                --         ellipsis_char = "...",
                --         before = function(entry, vim_item)
                --             vim_item.menu = "[" .. string.upper(entry.source.name) .. "]"
                --             return vim_item
                --         end,
                --     }),
                -- },
                formatting = {
                    format = function(_, item)
                        local icons = require("core.magic").icons.kinds
                        if icons[item.kind] then
                            item.kind = icons[item.kind] .. item.kind
                        end
                        return item
                    end,
                },
                experimental = {
                    ghost_text = {
                        hl_group = "CmpGhostText",
                    },
                },
                -- 对补全建议排序
                sorting = {
                    comparators = {
                        cmp.config.compare.offset,
                        cmp.config.compare.exact,
                        cmp.config.compare.score,
                        cmp.config.compare.recently_used,
                        require("cmp-under-comparator").under,
                        cmp.config.compare.kind,
                        cmp.config.compare.sort_text,
                        cmp.config.compare.length,
                        cmp.config.compare.order,
                    },
                },
                -- 绑定补全相关的按键
                mapping = cmp.mapping.preset.insert({
                    ["<C-u>"] = cmp.mapping.scroll_docs(-4), --Up
                    ["<C-d>"] = cmp.mapping.scroll_docs(4), --Down
                    -- C-b (back) C-f (forward) for snippet placeholder navigation.
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(), --关闭补全
                    ["<C-p>"] = cmp.mapping.select_prev_item(), --选择上一个
                    ["<C-n>"] = cmp.mapping.select_next_item(), --选择下一个
                    ["<CR>"] = cmp.mapping.confirm({ --确认选择
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = true,
                    }),
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                }),
            })
            -- 命令行 / ? 模式提示
            cmp.setup.cmdline({ "/", "?" }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = "buffer" },
                }),
            })
            -- 命令行 : 模式提示
            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = "async_path" },
                }, {
                    { name = "cmdline" },
                }),
            })
            cmp.event:on(
                "confirm_done",
                cmp_autopairs.on_confirm_done({
                    filetypes = {
                        ["*"] = {
                            ["("] = {
                                kind = {
                                    cmp.lsp.CompletionItemKind.Function,
                                    cmp.lsp.CompletionItemKind.Method,
                                },
                                handler = handlers["*"],
                            },
                        },
                        lua = {
                            ["("] = {
                                kind = {
                                    cmp.lsp.CompletionItemKind.Function,
                                    cmp.lsp.CompletionItemKind.Method,
                                },
                                handler = function(char, item, bufnr, rules, commit_character) end,
                            },
                        },
                        tex = false,
                    },
                })
            )
        end,
    },
}
