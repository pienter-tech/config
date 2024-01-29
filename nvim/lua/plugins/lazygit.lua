return {
    {
        "kdheepak/lazygit.nvim",
        dependencies =  {
            "nvim-lua/plenary.nvim"
        },
        keys = {
            {"<leader>gg", ":LazyGit<CR>", desc = "Open LazyGit in popup", mode = "n", silent = true},
        }
    }
}
