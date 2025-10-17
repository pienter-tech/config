local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Add project-specific snippet directories
local function add_project_snippets()
    local cwd = vim.fn.getcwd()
    local snippet_path = cwd .. "/.nvim/snippets"

    -- Check if project has .nvim/snippets directory
    if vim.loop.fs_stat(snippet_path) then
        -- Store the project snippet path globally so plugins can access it
        vim.g.project_snippet_path = snippet_path
    else
        vim.g.project_snippet_path = nil
    end
end

add_project_snippets()

require("pienter")
require("lazy").setup({
    spec = {
        { import = "plugins" },
    },
})
