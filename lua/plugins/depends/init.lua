return {
    -- 减少lua函数的编写
    {
        "nvim-lua/plenary.nvim",
        lazy = true,
    },
    -- neovim的UI组件库
    {
        "MunifTanjim/nui.nvim",
        lazy = true,
    },
    -- 图标支持插件
    {
        "nvim-tree/nvim-web-devicons",
        lazy = true,
        opts = {},
    },
    -- 提供对sqlite数据库的操作
    {
        "kkharji/sqlite.lua",
        lazy = true,
    },
    -- 管理lsp,dap,diagnostics,formatting服务的安装
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate",
        lazy = true,
        cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonLog", "MasonUpdate" },
        keys = {
            { "<leader>ms", "<cmd>Mason<CR>", desc = "Open Mason Manager Interface" },
        },
        opts = {
            log_level = vim.log.levels.ERROR,
            ui = {
                border = "rounded",
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        },
    },
}
