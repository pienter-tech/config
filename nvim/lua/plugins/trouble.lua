return {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
    keys = {
        { "<leader>cx", "<cmd>lua require('trouble').toggle()<cr>", desc = "Toggle trouble menu", mode = "n" },
        {
            "<leader>cz",
            "<cmd>lua require('trouble').toggle('workspace_diagnostics')<cr>",
            desc = "Toggle workspace trouble menu",
            mode = "n",
        },
    },
}
