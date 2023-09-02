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
    -- 函数重构
    -- dependencies neovim nighty
    {
        "ThePrimeagen/refactoring.nvim",
        lazy = true,
        enabled = false,
        cmd = "Refactor",
        keys = {
            { "<leader>rfe", mode = "x" },
            { "<leader>rft", mode = "x" },
            { "<leader>rfv", mode = "x" },
            { "<leader>rfi", mode = { "n", "x" } },
            { "<leader>rfb", mode = "n" },
            { "<leader>rfk", mode = "n" },
        },
        dependencies = {
            { "plenary.nvim" },
            { "nvim-treesitter" },
        },
        config = function()
            require("refactoring").setup({})
            vim.keymap.set("x", "<leader>rfe", function()
                require("refactoring").refactor("Extract Function")
            end)
            vim.keymap.set("x", "<leader>rft", function()
                require("refactoring").refactor("Extract Function To File")
            end)
            vim.keymap.set("x", "<leader>rfv", function()
                require("refactoring").refactor("Extract Variable")
            end)
            vim.keymap.set({ "n", "x" }, "<leader>rfi", function()
                require("refactoring").refactor("Inline Variable")
            end)
            vim.keymap.set("n", "<leader>rfb", function()
                require("refactoring").refactor("Extract Block")
            end)
            vim.keymap.set("n", "<leader>rfk", function()
                require("refactoring").refactor("Extract Block To File")
            end)
        end,
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
}
