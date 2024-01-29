local opt = vim.opt

opt.autowriteall = true --autosave on change focus
opt.confirm = true --confirm to save changes before exiting buffer
opt.completeopt = "menu,menuone,noselect"
opt.cursorline = true
opt.nu = true
opt.relativenumber = true
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.formatoptions = "jcroqlnt"
opt.shiftround = true
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.smartindent = true
opt.wrap = false
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true
opt.termguicolors = true
opt.scrolloff = 15
opt.sidescrolloff = 10
opt.timeout = true
opt.timeoutlen = 300
opt.colorcolumn = "80"
opt.clipboard = "unnamedplus"
opt.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200
opt.virtualedit = "block"

vim.filetype.add({
    extension = {
        astro = "astro"
    }
})

