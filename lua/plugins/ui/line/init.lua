return {
    {
        "akinsho/bufferline.nvim",
        enabled = false,
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
                diagnostics_indicator = function(count, level, diagnostics_dict, context)
                    local s = " "
                    for e, n in ipairs(diagnostics_dict) do
                        local sym = e == "error" and " " or (e == "warning" and " " or "")
                        s = s .. n .. sym
                    end
                    return s
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
    -- statusLine
    {
        "windwp/windline.nvim",
        event = "VeryLazy",
        config = function()
            require("wlsample.evil_line")
        end,
    },
}
