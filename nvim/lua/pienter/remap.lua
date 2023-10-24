vim.g.mapleader = " "
-- Windows
vim.keymap.set("n", "<leader>wo", "<C-w>o")
vim.keymap.set("n", "<leader>ws", "<C-w>v")
vim.keymap.set("n", "<leader>wc", "<C-w>c")
vim.keymap.set("n", "<leader>wt", ":rightbelow :vs <bar> term<CR>")
vim.keymap.set("n", "<leader>ww", "<C-w>w")
vim.keymap.set("n", "<leader>w-", "<C-w>< <C-w>< <C-w>< <C-w>< <C-w>< <C-w>< <C-w>< <C-w><")
vim.keymap.set("n", "<leader>w+", "<C-w>> <C-w>> <C-w>> <C-w>> <C-w>> <C-w>> <C-w>> <C-w>>")
-- Terminal
vim.keymap.set("t", "<C-Space>", "<C-\\><C-n>")
-- Autosave
vim.keymap.set("n", "<leader>n", ":ASToggle<CR>")
-- Clear search highlights
vim.keymap.set("n", "<leader>/", ":nohlsearch<CR>")
-- Run macro q
vim.keymap.set("n", "<leader>q", "@q")
-- Save
vim.keymap.set("n", "<C-s>", ":w<CR>", { desc = "Save on CMD-s" })
vim.keymap.set("n", "<leader>fs", ":w<CR>", { desc = "Save on CMD-s" })
vim.keymap.set("i", "<C-s>", "<ESC> :w<CR>", { desc = "Save on CMD-s" })
