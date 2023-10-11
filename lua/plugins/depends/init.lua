-- 此文件作为其它插件公共依赖调用
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
    -- 提供对sqlite的操作，用户保存会话，输入历史
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
            { "<leader>ms", "<cmd>Mason<CR>", desc = "Manager Mason Install Server" },
            { "<leader>ml", "<cmd>MasonLog<CR>", desc = "Open Mason Log" },
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
