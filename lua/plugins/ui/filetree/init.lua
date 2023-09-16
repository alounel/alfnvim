return {
    -- 文件目录树
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        lazy = true,
        cmd = "Neotree",
        keys = {
            { "<leader>nt", "<cmd>Neotree<CR>", desc = "Open Neo Tree" },
            { "<leader>nc", "<cmd>Neotree close<CR>", desc = "Close Neo Tree" },
            { "<leader>nf", "<cmd>Neotree float<CR>", desc = "Open Float Tree" },
            { "<leader>ng", "<cmd>Neotree toggle<CR>", desc = "Toggle Tree" },
            { "<leader>nb", "<cmd>Neotree buffers<CR>", desc = "Show Buffers Tree" },
            { "<leader>ns", "<cmd>Neotree filesystem reveal right<CR>", desc = "Select Right Open Tree" },
        },
        dependencies = {
            { "nvim-web-devicons" },
            { "plenary.nvim" },
            { "nui.nvim" },
        },
        init = function()
            if vim.fn.argc() == 1 then
                local stat = vim.loop.fs_stat(vim.fn.argv(0))
                if stat and stat.type == "directory" then
                    require("neo-tree")
                end
            end
        end,
        config = function()
            require("neo-tree").setup({
                open_files_do_not_replace_types = { "terminal", "Trouble", "qf", "Outline", "aerial", "sagaoutline" },
                default_component_configs = {
                    indent = {
                        with_expander = true,
                        expander_collapsed = "",
                        expander_expanded = "",
                        expander_highlight = "NeoTreeExpander",
                    },
                },
                window = {
                    mappings = {
                        ["<space>"] = "none",
                    },
                },
                filesystem = {
                    follow_current_file = {
                        enable = true,
                    },
                    use_libuv_file_watcher = true,
                },
                source_selector = {
                    winbar = true,
                    statusline = true,
                },
            })
        end,
    },
    -- 在悬浮窗中运行ranger
    {
        "kevinhwang91/rnvimr",
        lazy = true,
        keys = {
            { "<leader>nr", "<cmd>RnvimrToggle<CR>", desc = "Toggle Ranger in Float Window" },
            { "<leader>nz", "<cmd>RnvimrResize<CR>", desc = "Resize Ranger in Window" },
        },
    },
}
