return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.3",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-fzf-native.nvim",
            "olimorris/persisted.nvim",
        },
        config = function()
            require("telescope").setup({})
            require("telescope").load_extension("fzf")
            require("telescope").load_extension("persisted")
        end,
        keys = {
            { "<leader>fv", vim.cmd.Ex, desc = "Open netrw", mode = "n" },
            { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Telescope find files", mode = "n" },
            { "<leader>fg", "<cmd>Telescope git_files<CR>", desc = "Telescope find files in git", mode = "n" },
            { "<leader>fd", "<cmd>Telescope live_grep<CR>", desc = "Telescope search files with grep", mode = "n" },
            { "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Telescope find files in buffers", mode = "n" },
            { "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "Telescope find help tags", mode = "n" },
            { "<leader>fs", "<cmd>Telescope persisted<CR>", desc = "Telescsope find sessions", mode = "n" },
        },
    },
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "gmake",
    },
}
