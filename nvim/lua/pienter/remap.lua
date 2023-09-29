vim.g.mapleader = " "
-- File browser
vim.keymap.set("n", "<leader>fv", vim.cmd.Ex)
vim.keymap.set("n", "<leader>ff", ":Telescope find_files<CR>")
vim.keymap.set("n", "<leader>fg", ":Telescope git_files<CR>")
vim.keymap.set("n", "<leader>fd", ":Telescope live_grep<CR>")
vim.keymap.set("n", "<leader>fb", ":Telescope buffers<CR>")
vim.keymap.set("n", "<leader>fh", ":Telescope help_tags<CR>")
-- Windows
vim.keymap.set("n", "<leader>ws", "<C-w>v")
vim.keymap.set("n", "<leader>wc", "<C-w>c")
vim.keymap.set("n", "<leader>wt", ":rightbelow :vs <bar> term<CR>")
-- Terminal
vim.keymap.set("t", "<C-Space>", "<C-\\><C-n>")
-- Autosave
vim.keymap.set("n", "<leader>n", ":ASToggle<CR>")
