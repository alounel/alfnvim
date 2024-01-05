return {
    {
        "chrisgrieser/nvim-chainsaw",
        lazy = true,
        keys = {
            {
                "<leader>esm",
                function()
                    require("chainsaw").messageLog()
                end,
                desc = "Create Log For Cursor Enter",
            },
            {
                "<leader>esv",
                function()
                    require("chainsaw").variableLog()
                end,
                desc = "Log The Name And Value Of The A Variable",
            },
            {
                "<leader>eso",
                function()
                    require("chainsaw").objectLog()
                end,
                desc = "Syntax Specific To Inspect An Object",
            },
            {
                "<leader>esa",
                function()
                    require("chainsaw").assertLog()
                end,
                desc = "Assertion Statement",
            },
            {
                "<leader>esb",
                function()
                    require("chainsaw").beepLog()
                end,
                desc = "Minimal Log Statement",
            },
            {
                "<leader>est",
                function()
                    require("chainsaw").timeLog()
                end,
                desc = "Measures The Time",
            },
            {
                "<leader>esd",
                function()
                    require("chainsaw").debugLog()
                end,
                desc = "Debug Statement",
            },
            {
                "<leader>esr",
                function()
                    require("chainsaw").removeLogs()
                end,
                desc = "Remove All Log",
            },
        },
        opts = {},
    },
}
