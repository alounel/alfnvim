-- Lazy管理界面
vim.keymap.set({ "n", "v" }, "<leader>ml", "<cmd>Lazy<CR>", { desc = "Open Lazy Manager Interface" })

-- Lazy浮动终端
local Util = require("config.util")
local map = Util.safe_keymap_set

local lazyterm = function()
    Util.terminal(nil, { cwd = Util.root() })
end

map("n", "<leader>tl", lazyterm, { desc = "Lazy Terminal (Root Dir)" })
map("n", "<leader>tL", function()
    Util.terminal()
end, { desc = "Lazy Terminal (CWD)" })

map("n", "<leader>tg", function()
    Util.terminal({ "lazygit" }, { cwd = Util.root(), esc_esc = false, ctrl_hjkl = false })
end, { desc = "Lazygit (Root Dir)" })
map("n", "<leader>tG", function()
    Util.terminal({ "lazygit" }, { esc_esc = false, ctrl_hjkl = false })
end, { desc = "Lazygit (CWD)" })

-- toggle options
map("n", "<leader>os", function()
    Util.toggle("spell")
end, { desc = "Toggle Spelling" })
map("n", "<leader>ow", function()
    Util.toggle("wrap")
end, { desc = "Toggle Word Wrap" })
map("n", "<leader>oN", function()
    Util.toggle("relativenumber")
end, { desc = "Toggle Relative Line Numbers" })
map("n", "<leader>on", function()
    Util.toggle.number()
end, { desc = "Toggle Line Numbers" })
map("n", "<leader>od", function()
    Util.toggle.diagnostics()
end, { desc = "Toggle Diagnostics" })
map("n", "<leader>ot", function()
    if vim.b.ts_highlight then
        vim.treesitter.stop()
    else
        vim.treesitter.start()
    end
end, { desc = "Toggle Treesitter Highlight" })

-- 插件加载完成后执行
require("config.confinit").setup()
require("config.confinit").sign()
