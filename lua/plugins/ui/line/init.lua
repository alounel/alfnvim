return {
    {
        "akinsho/bufferline.nvim",
        version = "*",
        event = "VeryLazy",
        keys = {
            { "<M-p>", "<cmd>BufferLineCyclePrev<CR>", desc = "Goto Prev Buffer" },
            { "<M-n>", "<cmd>BufferLineCycleNext<CR>", desc = "Goto Next Buffer" },
            { "<leader>bl", "<cmd>BufferLineCloseLeft<CR>", desc = "Close Left Buffer" },
            { "<leader>br", "<cmd>BufferLineCloseRight<CR>", desc = "Close Right Buffer" },
        },
        dependencies = { "nvim-web-devicons" },
        opts = {
            options = {
                numbers = "ordinal",
                diagnostics = "nvim_lsp",
                separator_style = "thin",
                diagnostics_indicator = function(_, _, diag)
                    local diagnostics_icons = {
                        Error = " ",
                        Warn = " ",
                        Hint = " ",
                        Info = " ",
                    }
                    local ret = (diag.error and diagnostics_icons.Error .. diag.error .. " " or "")
                        .. (diag.warning and diagnostics_icons.Warn .. diag.warning or "")
                    return vim.trim(ret)
                end,
                offsets = {
                    {
                        filetype = "neo-tree",
                        text = "Neo-tree",
                        highlight = "Directory",
                        text_align = "left",
                    },
                },
            },
        },
    },
    {
        "romgrk/barbar.nvim",
        enabled = false,
        event = "VeryLazy",
        init = function()
            vim.g.barbar_auto_setup = false
        end,
        keys = {
            { "<M-p>", "<cmd>BufferPrevious<CR>", desc = "Goto Previous Buffer" },
            { "<M-n>", "<cmd>BufferNext<CR>", desc = "Goto Next Buffer" },
            { "<leader>bl", "<cmd>BufferClose<CR>", desc = "Close Buffer" },
            { "<leader>bn", "<cmd>BufferPin<CR>", desc = "Pin Buffer" },
            { "<leader>bt", "<cmd>BufferOrderByBufferNumber<CR>", desc = "Buffer Sort By Number" },
            { "<leader>br", "<cmd>BufferOrderByDirectory<CR>", desc = "Buffer Sort By Directory" },
            { "<leader>be", "<cmd>BufferOrderByLanguage<CR>", desc = "Buffer Sort By Language" },
            { "<leader>bw", "<cmd>BufferOrderByWindowNumber<CR>", desc = "Buffer Sort By Window Number" },
        },
        dependencies = {
            { "nvim-web-devicons" },
        },
        opts = {
            highlight_inactive_file_icons = true,
            highlight_visible = false,
            icons = {
                buffer_index = true,
                diagnostics = {
                    [vim.diagnostic.severity.ERROR] = { enabled = true, icon = " " },
                    [vim.diagnostic.severity.WARN] = { enabled = true, icon = " " },
                    [vim.diagnostic.severity.INFO] = { enabled = true, icon = "" },
                    [vim.diagnostic.severity.HINT] = { enabled = true },
                },
                visible = { modified = { buffer_number = true } },
            },
            insert_at_end = true,
            sidebar_filetypes = {
                aerial = { event = "BufWinLeave", text = "outline" },
            },
        },
    },
    {
        "willothy/nvim-cokeline",
        enabled = false,
        event = "VeryLazy",
        dependencies = {
            { "plenary.nvim" },
            { "nvim-web-devicons" },
        },
        config = function()
            local is_picking_focus = require("cokeline.mappings").is_picking_focus
            local is_picking_close = require("cokeline.mappings").is_picking_close
            local get_hex = require("cokeline.utils").get_hex

            local red = vim.g.terminal_color_1
            local green = vim.g.terminal_color_2
            local yellow = vim.g.terminal_color_3

            require("cokeline").setup({
                default_hl = {
                    fg = function(buffer)
                        return buffer.is_focused and get_hex("Normal", "fg") or get_hex("Comment", "fg")
                    end,
                    bg = get_hex("ColorColumn", "bg"),
                },

                components = {
                    {
                        text = "｜",
                        fg = function(buffer)
                            return buffer.is_modified and yellow or green
                        end,
                    },
                    {
                        text = "  ",
                    },
                    {
                        text = function(buffer)
                            return (is_picking_focus() or is_picking_close()) and buffer.pick_letter .. " "
                                or buffer.devicon.icon
                        end,
                        fg = function(buffer)
                            return (is_picking_focus() and yellow)
                                or (is_picking_close() and red)
                                or buffer.devicon.color
                        end,
                        style = function(_)
                            return (is_picking_focus() or is_picking_close()) and "italic,bold" or nil
                        end,
                    },
                    {
                        text = " ",
                    },
                    {
                        text = function(buffer)
                            return buffer.index .. ": "
                        end,
                    },
                    {
                        text = function(buffer)
                            return buffer.unique_prefix
                        end,
                        fg = get_hex("Comment", "fg"),
                        italic = true,
                    },
                    {
                        text = function(buffer)
                            return buffer.filename .. "  "
                        end,
                        style = function(buffer)
                            return buffer.is_focused and "bold" or nil
                        end,
                    },
                    {
                        text = "",
                        on_click = function(buffer)
                            buffer:delete()
                        end,
                    },
                    {
                        text = "  ",
                    },
                },
                sidebar = {
                    filetype = "neo-tree",
                    components = {
                        {
                            text = "Neo-tree",
                            fg = yellow,
                            bg = get_hex("NvimTreeNormal", "bg"),
                            style = "bold",
                        },
                    },
                },
            })
        end,
    },
    -- statusLine
    {
        "windwp/windline.nvim",
        event = "VeryLazy",
        config = function()
            require("wlsample.evil_line")
        end,
    },
}
