local settings = {
    -- dev = {
    --     path = vim.fn.stdpath("data") .. "/local-plugin",
    -- },
    install = {
        missing = true,
        colorscheme = { "nightfox" },
    },
    ui = {
        border = "rounded",
        icons = {
            ft = "",
            loaded = "",
            not_loaded = "",
        },
    },
    -- checker = {
    --     enabled = true,
    --     concurrency = 10,
    --     notify = true,
    --     frequency = 7200,
    -- },
    performance = {
        rtp = {
            disabled_plugins = {
                "2html_plugin",
                "bugreport",
                "compiler",
                "editorconfig",
                "ftplugin",
                "getscript",
                "getscriptPlugin",
                "gzip",
                "logiPat",
                "matchit",
                "matchparen",
                "netrw",
                "netrwFileHandlers",
                "netrwPlugin",
                "netrwSettings",
                "optwin",
                "remote_plugins",
                "rplugin",
                "rrhelper",
                "shada",
                "shada_plugin",
                "spellfile",
                "spellfile_plugin",
                "syntax",
                "tar",
                "tarPlugin",
                "tohtml",
                "tutor",
                "tutor_mode_plugin",
                "vimball",
                "vimballPlugin",
                "zip",
                "zipPlugin",
            },
        },
    },
}
require("lazy").setup("plugins", settings)

-- 打开lazy界面
vim.keymap.set({ "n", "v" }, "<leader>ma", "<cmd>Lazy<CR>", { desc = "Open Lazy Menu" })
-- 查看lazygit日志
vim.keymap.set("n", "<leader>ll", function()
    require("lazy.util").float_term({ "lazygit", "log" })
end, { desc = "Show Lazygit Log" })
