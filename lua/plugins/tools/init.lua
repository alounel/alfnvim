return {
    -- 右侧小地图
    {
        "gorbit99/codewindow.nvim",
        lazy = true,
        keys = {
            {
                "<leader>sm",
                function()
                    require("codewindow").toggle_minimap()
                end,
                desc = "Toggle Minimap",
            },
            {
                "<leader>sf",
                function()
                    require("codewindow").toggle_focus()
                end,
                desc = "Focus Minimap",
            },
        },
        config = function()
            require("codewindow").setup({
                exclude_filetypes = { "help", "vimcdoc", "log", "txt" },
                window_border = "rounded",
            })
        end,
    },
    -- 从终端缓冲区打开文件
    {
        "willothy/flatten.nvim",
        lazy = true,
        event = "VeryLazy",
        opts = {},
    },
    --侧边栏
    {
        "sidebar-nvim/sidebar.nvim",
        enabled = false,
        lazy = true,
        cmd = "SidebarNvimToggle",
        keys = {
            { "<leader>sbt", "<cmd>SidebarNvimToggle<CR>", desc = "Toggle SideBar" },
            { "<leader>sbu", "<cmd>SidebarNvimUpdate<CR>", desc = "Update SideBar" },
            { "<leader>sbf", "<cmd>SidebarNvimFocus<CR>", desc = "Focus Sidebar" },
            { "<leader>sbr", ":SidebarNvimResize ", desc = "Resize Sidebar" },
        },
        opts = {},
    },
    -- 屏保
    {
        "folke/drop.nvim",
        enabled = false,
        event = "VimEnter",
        config = function()
            math.randomseed(os.time())
            local themes = ({ "stars", "snow", "xmas", "leaves" })[math.random(1, 4)]
            require("drop").setup({
                theme = themes,
            })
        end,
    },
    {
        "folke/edgy.nvim",
        enabled = false,
        -- requirement nvim version 0.10.0
        event = "VeryLazy",
        keys = {
            {
                "<leader>ue",
                function()
                    require("edgy").select()
                end,
                desc = "Edgy Select Window",
            },
        },
        opts = {},
    },
}
