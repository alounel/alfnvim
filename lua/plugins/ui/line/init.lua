return {
    -- bufferLine
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
    -- statusLine
    {
        "windwp/windline.nvim",
        -- enabled = false,
        event = "VeryLazy",
        config = function()
            require("wlsample.evil_line")
        end,
    },
}

