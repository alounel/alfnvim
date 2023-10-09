return {
    -- bufferline
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
        config = function(_, opts)
            require("bufferline").setup(opts)
            vim.api.nvim_create_autocmd("BufAdd", {
                callback = function()
                    vim.schedule(function()
                        pcall(nvim_bufferline)
                    end)
                end,
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
    -- 状态栏
    {
        import = "plugins.extras.line.statusline",
    },
    -- tabline
    {
        import = "plugins.extras.line.tabline",
    },
    -- 侧边栏
    {
        import = "plugins.extras.line.sideline",
    },
}
