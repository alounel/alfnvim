return {
    -- 在函数、方法、语句等之后显示当前上下文的虚拟文本
    {
        "haringsrob/nvim_context_vt",
        lazy = true,
        ft = { "c", "cpp", "java", "lua", "python", "typescript", "javascript", "typescriptreact", "javascriptreact" },
        opts = {
            prefix = "",
            disable_ft = { "markdown" },
            disable_virtual_lines_ft = { "yaml", "toml" },
        },
        keys = {
            { "<leader>ov", "<cmd>NvimContextVtToggle<CR>", desc = "Toggle Context Virtual Text" },
        },
    },
    -- 将函数头显示在界面前几行
    {
        "nvim-treesitter/nvim-treesitter-context",
        lazy = true,
        event = { "BufReadPost", "BufNewFile" },
        keys = {
            {
                "<leader>oc",
                function()
                    local Util = require("config.util")
                    local tsc = require("treesitter-context")
                    tsc.toggle()
                    if Util.inject.get_upvalue(tsc.toggle, "enabled") then
                        Util.info("Enabled Treesitter Context", { title = "Option" })
                    else
                        Util.warn("Disabled Treesitter Context", { title = "Option" })
                    end
                end,
                desc = "Toggle Treesitter Context",
            },
        },
        config = function()
            require("treesitter-context").setup({
                max_lines = 3,
            })
            vim.keymap.set("n", "[x", function()
                require("treesitter-context").go_to_context()
            end, { silent = true, desc = "Goto Code Context Start" })
        end,
    },
}
