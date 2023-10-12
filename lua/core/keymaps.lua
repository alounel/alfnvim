------ quick commands ------
vim.keymap.set("n", "<leader>ce", "<cmd>enew<CR>", { desc = "New File" })
vim.keymap.set("n", "<leader>cw", "<cmd>w<CR>", { desc = "Buffer Write File" })
vim.keymap.set("n", "<leader>cW", "<cmd>wa<CR>", { desc = "Write All File" })
vim.keymap.set("n", "<leader>cE", "<cmd>e!<CR>", { desc = "Revoke all file changes" })
vim.keymap.set("n", "<leader>cq", "<cmd>q<CR>", { desc = "Quit" })
vim.keymap.set("n", "<leader>cQ", "<cmd>q!<CR>", { desc = "Force Quit" })
vim.keymap.set("n", "<leader>cx", "<cmd>x<CR>", { desc = "Save And Quit" })
vim.keymap.set("n", "<leader>cc", "<cmd>copen<CR>", { desc = "Open Quickfix" })
vim.keymap.set("n", "<leader>cl", "<cmd>lopen<CR>", { desc = "Open Locationlist" })
vim.keymap.set("n", "<leader>ch", "<cmd>checkhealth<CR>", { desc = "Neovim Health Check" })

------ keybinds ------
-- window
vim.keymap.set("n", "<leader>wh", "<c-w>h", { desc = "Goto left window" })
vim.keymap.set("n", "<leader>wj", "<c-w>j", { desc = "Goto lower window" })
vim.keymap.set("n", "<leader>wk", "<c-w>k", { desc = "Goto upper window" })
vim.keymap.set("n", "<leader>wl", "<c-w>l", { desc = "Goto right window" })
vim.keymap.set("n", "<leader>wv", "<c-w>v", { desc = "Horizontal addition window" })
vim.keymap.set("n", "<leader>ws", "<c-w>s", { desc = "Vertical addition window" })
vim.keymap.set("n", "<M-9>", "<c-w><", { desc = "Reduce window width" })
vim.keymap.set("n", "<M-0>", "<c-w>>", { desc = "Increase window width" })
vim.keymap.set("n", "<M-->", "<c-w>-", { desc = "Reduce window height" })
vim.keymap.set("n", "<M-=>", "<c-w>+", { desc = "Increase window height" })
vim.keymap.set("n", "<leader><tab>l", "<cmd>tablast<CR>", { desc = "Last Tab" })
vim.keymap.set("n", "<leader><tab>f", "<cmd>tabfirst<CR>", { desc = "First Tab" })
vim.keymap.set("n", "<leader><tab><tab>", "<cmd>tabnew<CR>", { desc = "New Tab" })
vim.keymap.set("n", "<leader><tab>]", "<cmd>tabnext<CR>", { desc = "Next Tab" })
vim.keymap.set("n", "<leader><tab>[", "<cmd>tabprevious<CR>", { desc = "Previous Tab" })
vim.keymap.set("n", "<leader><tab>d", "<cmd>tabclose<CR>", { desc = "Close Tab" })
-- line move
vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
-- indent
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")
-- search
vim.keymap.set("n", "<leader>se", "/\\<lt>\\><left><left>")
vim.keymap.set("n", "<leader>ss", vim.show_pos, { desc = "Inspect Pos" })
vim.keymap.set(
    "n",
    "<leader>hn",
    "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
    { desc = "Redraw / clear hlsearch / diff update" }
)
