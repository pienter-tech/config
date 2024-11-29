local fileGroup = vim.api.nvim_create_augroup("FileTypes", { clear = true })

vim.api.nvim_create_autocmd(
    { "BufNewFile", "BufRead" },
    { pattern = "*.astro", command = "set syntax=astro", group = fileGroup }
)

vim.api.nvim_create_autocmd(
    { "BufNewFile", "BufRead" },
    { pattern = "*.mjml", command = "set syntax=html", group = fileGroup }
)

vim.api.nvim_create_autocmd({ "BufEnter" }, {
    pattern = "*.md",
    callback = function()
        vim.opt_local.spell = true
        vim.opt_local.wrap = true
        vim.opt_local.linebreak = true
        vim.opt_local.breakindent = true
        vim.opt_local.showbreak = "   󰘍  "
        vim.opt_local.wrapmargin = 0
        vim.opt_local.textwidth = 0
    end,
})
