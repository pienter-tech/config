local fileGroup = vim.api.nvim_create_augroup("FileTypes", { clear = true })

vim.api.nvim_create_autocmd(
    { "BufNewFile", "BufRead" },
    { pattern = "*.astro", command = "set syntax=astro", group = fileGroup }
)
vim.api.nvim_create_autocmd(
    { "BufNewFile", "BufRead" },
    { pattern = "*.mjml", command = "set syntax=html", group = fileGroup }
)
