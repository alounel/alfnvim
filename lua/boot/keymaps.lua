-- Lazy管理界面
vim.keymap.set({ "n", "v" }, "<leader>ml", "<cmd>Lazy<CR>", { desc = "Open Lazy Manager Interface" })

-- Lazy浮动终端
local Util = require("config.util")
local map = Util.safe_keymap_set

local lazyterm = function()
    Util.terminal(nil, { cwd = Util.root() })
end

map("n", "<leader>tl", lazyterm, { desc = "Lazy Terminal (root dir)" })
map("n", "<leader>tL", function()
    Util.terminal()
end, { desc = "Lazy Terminal (cwd)" })

-- 插件加载完成后执行
require("config.confinit").setup()
