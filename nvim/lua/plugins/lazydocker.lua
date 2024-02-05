return {
    {
        "crnvl96/lazydocker.nvim",
        event = "VeryLazy",
        keys = { { "<leader>kk", ":LazyDocker<CR>", desc = "Toggle LazyDocker", mode = "n", silent = true } },
        opts = {}, -- automatically calls `require("lazydocker").setup()`
        dependencies = {
            "MunifTanjim/nui.nvim",
        },
    },
}
