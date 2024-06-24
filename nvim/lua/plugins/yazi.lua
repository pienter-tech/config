return {
    "mikavilpas/yazi.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    event = "VeryLazy",
    keys = {
        {
            "<leader>fv",
            function()
                require("yazi").yazi()
            end,
            desc = "Open the file manager"
        },
        {
            "<leader>fw",
            function()
                require("yazi").yazi(nil, vim.fn.getcwd())
            end,
            desc = "Open the file manager in the project root directory"
        }
    },
    opts = {
        open_for_directories = false,
    }
}
