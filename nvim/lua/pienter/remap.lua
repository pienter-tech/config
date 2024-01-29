vim.g.mapleader = " "

-- Windows
vim.keymap.set("n", "<leader>wo", "<C-w>o", { desc = "Close other windows" })
vim.keymap.set("n", "<leader>ws", "<C-w>v", { desc = "Split window verticaly" })
vim.keymap.set("n", "<leader>wc", "<C-w>c", { desc = "Close window (?)" })
vim.keymap.set("n", "<leader>wt", ":rightbelow :vs <bar> term<CR>", { desc = "Open terminal to right" })
vim.keymap.set("n", "<leader>ww", "<C-w>w", { desc = "Go to previous window" })
vim.keymap.set("n", "<leader>w-", "<C-w>< <C-w>< <C-w>< <C-w>< <C-w>< <C-w>< <C-w>< <C-w><", { desc = "Make window smaller" })
vim.keymap.set("n", "<leader>w+", "<C-w>> <C-w>> <C-w>> <C-w>> <C-w>> <C-w>> <C-w>> <C-w>>", { desc = "Make window bigger" })
-- Terminal
vim.keymap.set("t", "<esc><esc>", "<C-\\><C-n>", { desc = "Esc in terminal"})
-- Clear search highlights
vim.keymap.set("n", "<leader>/", ":nohlsearch<CR>", { desc = "Stop highlighting for the search" })
-- Run macro q
vim.keymap.set("n", "<leader>q", "@q", { desc = "@q (start/stop/run macro q)" })
-- Save
vim.keymap.set("n", "<C-s>", ":w<CR>", { desc = "Save on CMD-s" })
vim.keymap.set("i", "<C-s>", "<ESC> :w<CR>", { desc = "Save on CM-s" })

