vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 15

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

vim.filetype.add({
    extension = {
        astro = "astro"
    }
})

vim.opt.clipboard = "unnamedplus"
