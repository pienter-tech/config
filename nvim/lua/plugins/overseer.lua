return {
    {
        "stevearc/overseer.nvim",
        keys = {
            {
                mode = "n",
                "<leader>o",
                desc = "Overseer commands...",
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
                    require("overseer").toggle({ enter = false })
                end,
                desc = "Toggle overseer",
            },
            {
                mode = "n",
                "<leader>oc",
                function()
                    require("overseer").close()
                end,
                desc = "Close overseer",
            },
        },
        opts = {
            task_list = {
                bindings = {
                    ["<C-l>"] = false,
                    ["<C-h>"] = false,
                    ["<C-k>"] = false,
                    ["<C-j>"] = false,
                    ["<C-p>"] = "ScrollOutputUp",
                    ["<C-n>"] = "ScrollOutputDown",
                },
            },
        },
    },
}
