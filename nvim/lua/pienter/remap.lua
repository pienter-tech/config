vim.g.mapleader = " "

local key = vim.keymap

-- Windows
key.set("n", "<leader>wo", "<C-w>o", { desc = "Close other windows" })
key.set("n", "<leader>ws", "<C-w>v<C-w>w", { desc = "Split window verticaly" })
key.set("n", "<leader>wc", "<C-w>c", { desc = "Close window (?)" })
key.set("n", "<leader>wt", ":rightbelow :vs <bar> term<CR>", { desc = "Open terminal to right" })
key.set("n", "<leader>ww", "<C-w>w", { desc = "Go to previous window" })
key.set("n", "<leader>wh", "<C-w>h", { desc = "Go to window on left" })
key.set("n", "<leader>wl", "<C-w>l", { desc = "Go to window on right" })
key.set("n", "<leader>wj", "<C-w>j", { desc = "Go to window on bottom" })
key.set("n", "<leader>wk", "<C-w>k", { desc = "Go to window on top" })
key.set("n", "<leader>w=", "<C-w>=", { desc = "Make windows equaly high en wide" })
key.set("n", "<leader>w-", "<C-w>< <C-w>< <C-w>< <C-w>< <C-w>< <C-w>< <C-w>< <C-w><", { desc = "Make window smaller" })
key.set("n", "<leader>w+", "<C-w>> <C-w>> <C-w>> <C-w>> <C-w>> <C-w>> <C-w>> <C-w>>", { desc = "Make window bigger" })
-- Terminal
key.set("t", "<esc><esc>", "<C-\\><C-n>", { desc = "Esc in terminal" })
-- Clear search highlights
key.set("n", "<leader>/", ":nohlsearch<CR>", { desc = "Stop highlighting for the search" })
-- Run macro q
key.set("n", "<leader>q", "@q", { desc = "@q (start/stop/run macro q)" })
-- Save
key.set("n", "<C-s>", ":w<CR>", { desc = "Save on CMD-s" })
key.set("i", "<C-s>", "<ESC> :w<CR>", { desc = "Save on CM-s" })

key.set("i", "<C-l>", "<ESC>la", { desc = "Move cursor to right in insert mode" })
key.set("i", "<C-h>", "<ESC>ha", { desc = "Move cursor to left in insert mode" })
key.set("i", "<C-j>", "<ESC>ja", { desc = "Move cursor down in insert mode" })
key.set("i", "<C-k>", "<ESC>ka", { desc = "Move cursor up in insert mode" })
key.set("i", "<C-a>", "<ESC><S-a>", { desc = "Move cursor to end of line in insert mode" })
key.set("i", "<C-i>", "<ESC><S-i>", { desc = "Move cursor to start of line in insert mode" })

key.set("v", "p", '"_dP', { desc = "Replace currently selected text without yanking" })

key.set("n", "<leader>bo", ':%bdelete|edit #|normal `"<CR>', { desc = "Close all buffers except current" })
