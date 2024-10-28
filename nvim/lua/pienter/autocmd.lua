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

vim.api.nvim_create_autocmd("VimEnter", {
    nested = true,
    callback = function()
        if vim.g.started_with_stdin then
            return
        end

        local forceload = false
        if vim.fn.argc() == 0 then
            forceload = true
        elseif vim.fn.argc() == 1 then
            local dir = vim.fn.expand(vim.fn.argv(0))
            if dir == "." then
                dir = vim.fn.getcwd()
            end

            if vim.fn.isdirectory(dir) ~= 0 then
                forceload = true
            end
        end

        require("persisted").autoload({ force = forceload })
    end,
})

