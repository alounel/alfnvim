return {
    -- 文件标记
    {
        "ThePrimeagen/harpoon",
        lazy = true,
        keys = {
            {
                "<leader>mt",
                function()
                    require("harpoon.mark").add_file()
                end,
                desc = "Mark Files",
            },
            {
                "<leader>mu",
                function()
                    require("harpoon.ui").toggle_quick_menu()
                end,
                desc = "Use Popup View Mark Files",
            },
            {
                "<leader>mp",
                function()
                    require("harpoon.ui").nav_prev()
                end,
                desc = "Prev Mark Files",
            },
            {
                "<leader>mn",
                function()
                    require("harpoon.ui").nav_next()
                end,
                desc = "Next Mark Files",
            },
            { "<leader>mf", "<cmd>Telescope harpoon marks<CR>", desc = "Find Harpoon File Marks" },
        },
        opts = {
            save_on_toggle = true,
            excluded_filetypes = { "harpoon", "neo-tree", "qf", "Trouble", "aerial", "alpha", "starter", "dashboard" },
        },
    },
    -- 行标记
    {
        "chentoast/marks.nvim",
        lazy = true,
        keys = {
            { "mx", desc = "Set Mark X" },
            { "m,", desc = "Set the next available alphabetical (lowercase) mark" },
            { "m;", desc = "Toggle the next available mark at the current line" },
            { "dmx", desc = "Delete Mark X" },
            { "dm-", desc = "Delete all marks on the current line" },
            { "dm<space>", desc = "Delete all marks in the current buffer" },
            { "dm=", desc = "Delete the bookmark under the cursor." },
            { "m]", desc = "Move to next mark" },
            { "m[", desc = "Move to Prev mark" },
            {
                "m:",
                desc = "Preview mark. This will prompt you for a specific mark to preview; press <cr> to preview the next mark.",
            },
            {
                "m}",
                desc = "Move to the next bookmark having the same type as the bookmark under the cursor. Works across buffers.",
            },
            {
                "m{",
                desc = "Move to the previous bookmark having the same type as the bookmark under the cursor. Works across buffers.",
            },
        },
        opts = {},
    },
    -- 文本字符标记
    {
        "LeonHeidelbach/trailblazer.nvim",
        enabled = false,
        lazy = true,
        keys = {
            { "<M-N>", desc = "In Cursor/Design Window/Buffer/ Create/Toggle Trail Mark" },
            { "<M-B>", desc = "Goto Back Trail Mark And Delete" },
            { "<M-J>", desc = "Goto Prev Trail Mark To Old Mark" },
            { "<M-K>", desc = "Goto Next Trail Mark To New Mark" },
            { "<M-n>", desc = "Toggle Design Buffer All Mark List" },
            { "<M-L>", desc = "Delete All Trail Mark" },
            { "<M-p>", desc = "Paste Registers To Last And Delete" },
            { "<M-P>", desc = "Paste Registers To All" },
            { "<M-S>", desc = "Cycle Set Trail Mark Select Mode" },
            { "<M-.>", desc = "Switch Design Trail Mark Stack" },
            { "<M-,>", desc = "Use Design Sort Mode Switch To Trail Mark Stack" },
            { "<M-s>", desc = "Cycle Set Current Trail Mark Sort Mode Stack" },
        },
        opts = {
            mappings = {
                nv = {
                    motions = {
                        new_trail_mark = "<M-N>",
                        track_back = "<M-B>",
                        peek_move_next_down = "<M-J>",
                        peek_move_previous_up = "<M-K>",
                        move_to_nearest = "<M-n>",
                        toggle_trail_mark_list = "<M-m>",
                    },
                    actions = {
                        delete_all_trail_marks = "<M-L>",
                        paste_at_last_trail_mark = "<M-p>",
                        paste_at_all_trail_marks = "<M-P>",
                        set_trail_mark_select_mode = "<M-S>",
                        switch_to_next_trail_mark_stack = "<M-.>",
                        switch_to_previous_trail_mark_stack = "<M-,>",
                        set_trail_mark_stack_sort_mode = "<M-s>",
                    },
                },
            },
        },
    },
}
