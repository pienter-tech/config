return {
    {
        "stevearc/overseer.nvim",
        keys = {
            {
                mode = "n",
                "<leader>o",
                desc = "Overseer commands..."
            },
            {
                mode = "n",
                "<leader>of",
                function()
                    require("overseer").run_template()
                end,
                desc = "Search tasks",
            },
            {
                mode = "n",
                "<leader>ot",
                function()
                    require("overseer").toggle()
                end,
                desc = "Toggle overseer",
            },
        },
        opts = {},
    },
}
