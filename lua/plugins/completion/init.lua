return {
    -- 片段支持
    {
        "L3MON4D3/luasnip",
        version = "2.*",
        build = "make install_jsregexp",
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
            { "saadparwaiz1/cmp_luasnip", lazy = true },
            { "hrsh7th/cmp-nvim-lsp", lazy = true },
            { "hrsh7th/cmp-buffer", lazy = true },
            { "hrsh7th/cmp-cmdline", lazy = true },
            { "FelipeLema/cmp-async-path", lazy = true },
            { "lukas-reineke/cmp-rg", lazy = true },
            { "f3fora/cmp-spell", lazy = true },
        },
        config = function()
            local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            local defaults = require("cmp.config.default")()
            local luasnip = require("luasnip")
            local cmp = require("cmp")
            vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
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
                    { name = "luasnip" },
                    { name = "nvim_lsp" },
                    { name = "async_path" },
                    {
                        name = "buffer",
                        option = {
                            keyword_pattern = [[\k\+]],
                            get_bufnrs = function()
                                local buf = vim.api.nvim_get_current_buf()
                                local byte_size = vim.api.nvim_buf_get_offset(buf, vim.api.nvim_buf_line_count(buf))
                                if byte_size > 1024 * 1024 * 2 then
                                    return {}
                                end
                                return { buf }
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
                    format = function(entry, vim_item)
                        vim_item.kind =
                            string.format("%s %s", require("core.magic").icons.kinds[vim_item.kind], vim_item.kind)
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
                -- 对补全建议排序
                sorting = defaults.sorting,
                -- 绑定补全相关的按键
                mapping = cmp.mapping.preset.insert({
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4), --Up
                    ["<C-f>"] = cmp.mapping.scroll_docs(4), --Down
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(), --关闭补全
                    ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }), --选择上一个
                    ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }), --选择下一个
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
            cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
    },
}
