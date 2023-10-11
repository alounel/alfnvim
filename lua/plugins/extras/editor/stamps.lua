return {
    -- 文件标记
    {
        "ThePrimeagen/harpoon",
        lazy = true,
        keys = {
            { "<leader>mha", "<cmd>lua require('harpoon.mark').add_file()<CR>", desc = "Mark Files" },
            { "<leader>mhq", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>", desc = "View All File Mark" },
            { "<leader>mhp", "<cmd>lua require('harpoon.ui').nav_prev()<CR>", desc = "Prev Mark Files" },
            { "<leader>mhn", "<cmd>lua require('harpoon.ui').nav_next()<CR>", desc = "Next Mark Files" },
            { "<leader>mht", "<cmd>lua require('harpoon.term').gotoTerminal(1)<CR>", desc = "Navigate to 1 Terminal" },
        },
        opts = {
            save_on_toggle = true,
            tabline = false,
        },
    },
    -- 标记重要文件
    {
        "cbochs/grapple.nvim",
        lazy = true,
        keys = {
            { "<leader>mgt", "<cmd>GrappleTag<CR>", desc = "Grapple Tag" },
            { "<leader>mgs", "<cmd>GrappleTags<CR>", desc = "Grapple Tags" },
            { "<leader>mgc", "<cmd>GrappleCycle<CR>", desc = "Grapple Cycle" },
            { "<leader>mgp", "<cmd>GrapplePopup<CR>", desc = "Grapple Popup" },
            { "<leader>mgr", "<cmd>GrappleReset<CR>", desc = "Grapple Reset" },
            { "<leader>mgu", "<cmd>GrappleUntag<CR>", desc = "Un Grapple Tag" },
            { "<leader>mgs", "<cmd>GrappleSelect<CR>", desc = "Grapple Select" },
            { "<leader>mgg", "<cmd>GrappleToggle<CR>", desc = "Toggle Grapple" },
        },
        dependencies = { "plenary.nvim" },
        opts = {
            log_level = "error",
        },
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
