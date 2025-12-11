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
                    require("overseer").run_task()
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
                "<leader>or",
                function()
                    local overseer = require("overseer")
                    local tasks = overseer.list_tasks({ recent_first = true })
                    if vim.tbl_isempty(tasks) then
                        vim.notify("No tasks found", vim.log.levels.WARN)
                    else
                        overseer.run_action(tasks[1], "restart")
                    end
                end,
                desc = "Restart last task",
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
