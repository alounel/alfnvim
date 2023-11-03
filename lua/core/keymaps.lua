-- file operate
vim.keymap.set("n", "<leader>ce", "<cmd>enew<CR>", { desc = "New File" })
vim.keymap.set("n", "<leader>cw", "<cmd>w<CR>", { desc = "Buffer Write File" })
vim.keymap.set("n", "<leader>cW", "<cmd>wa<CR>", { desc = "Write All File" })
vim.keymap.set("n", "<leader>cE", "<cmd>e!<CR>", { desc = "Revoke all file changes" })
vim.keymap.set("n", "<leader>cq", "<cmd>q<CR>", { desc = "Quit" })
vim.keymap.set("n", "<leader>cQ", "<cmd>q!<CR>", { desc = "Force Quit" })
vim.keymap.set("n", "<leader>cx", "<cmd>x<CR>", { desc = "Save And Quit" })

-- quickfix/locallist
vim.keymap.set("n", "<leader>cc", "<cmd>copen<CR>", { desc = "Open Quickfix" })
vim.keymap.set("n", "<leader>cl", "<cmd>lopen<CR>", { desc = "Open Locationlist" })
vim.keymap.set("n", "[q", vim.cmd.cprev, { desc = "Previous quickfix" })
vim.keymap.set("n", "]q", vim.cmd.cnext, { desc = "Next quickfix" })

-- checkhealth
vim.keymap.set("n", "<leader>ch", "<cmd>checkhealth<CR>", { desc = "Neovim Health Check" })

-- buffers
vim.keymap.set("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
vim.keymap.set("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
vim.keymap.set("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
vim.keymap.set("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })

-- window
vim.keymap.set("n", "gh", "<c-w>h", { desc = "Goto left window" })
vim.keymap.set("n", "gj", "<c-w>j", { desc = "Goto lower window" })
vim.keymap.set("n", "gk", "<c-w>k", { desc = "Goto upper window" })
vim.keymap.set("n", "gl", "<c-w>l", { desc = "Goto right window" })
vim.keymap.set("n", "<leader>wv", "<C-W>v", { desc = "Horizontal addition window", remap = true })
vim.keymap.set("n", "<leader>ws", "<C-W>s", { desc = "Vertical addition window", remap = true })
vim.keymap.set("n", "<leader>ww", "<C-W>p", { desc = "Other window", remap = true })
vim.keymap.set("n", "<leader>wd", "<C-W>c", { desc = "Delete window", remap = true })
vim.keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
vim.keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- tabs
vim.keymap.set("n", "<leader><tab>l", "<cmd>tablast<CR>", { desc = "Last Tab" })
vim.keymap.set("n", "<leader><tab>f", "<cmd>tabfirst<CR>", { desc = "First Tab" })
vim.keymap.set("n", "<leader><tab><tab>", "<cmd>tabnew<CR>", { desc = "New Tab" })
vim.keymap.set("n", "<leader><tab>]", "<cmd>tabnext<CR>", { desc = "Next Tab" })
vim.keymap.set("n", "<leader><tab>[", "<cmd>tabprevious<CR>", { desc = "Previous Tab" })
vim.keymap.set("n", "<leader><tab>d", "<cmd>tabclose<CR>", { desc = "Close Tab" })

-- move
vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- indent
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Add undo break-points
vim.keymap.set("i", ",", ",<C-g>u")
vim.keymap.set("i", ".", ".<C-g>u")
vim.keymap.set("i", ";", ";<C-g>u")

-- keywordprg
vim.keymap.set("n", "<leader>K", "<cmd>norm! K<CR>", { desc = "Keywordprg" })

-- search/highlight
vim.keymap.set("n", "<leader>se", "/\\<lt>\\><left><left>")
vim.keymap.set("n", "<leader>ss", vim.show_pos, { desc = "Inspect Pos" })
vim.keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<CR><esc>", { desc = "Escape and clear hlsearch" })
vim.keymap.set(
    "n",
    "<leader>hn",
    "<cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
    { silent = true, noremap = true, desc = "Redraw / clear hlsearch / diff update" }
)

-- terminal
vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })
vim.keymap.set("t", "gh", "<cmd>wincmd h<cr>", { desc = "Go to left window" })
vim.keymap.set("t", "gj", "<cmd>wincmd j<cr>", { desc = "Go to lower window" })
vim.keymap.set("t", "gk", "<cmd>wincmd k<cr>", { desc = "Go to upper window" })
vim.keymap.set("t", "gl", "<cmd>wincmd l<cr>", { desc = "Go to right window" })
vim.keymap.set("t", "<C-/>", "<cmd>close<cr>", { desc = "Hide Terminal" })
vim.keymap.set("t", "<c-_>", "<cmd>close<cr>", { desc = "which_key_ignore" })
