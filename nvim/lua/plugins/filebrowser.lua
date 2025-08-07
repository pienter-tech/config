return {
    {
        "mikavilpas/yazi.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        event = "VeryLazy",
        enabled = false,
        keys = {
            {
                "<leader>fv",
                function()
                    require("yazi").yazi()
                end,
                desc = "Open the file manager",
            },
            {
                "<leader>fw",
                function()
                    require("yazi").yazi(nil, vim.fn.getcwd())
                end,
                desc = "Open the file manager in the project root directory",
            },
        },
        opts = {
            open_for_directories = false,
        },
    },
    {
        "stevearc/oil.nvim",
        ---@module 'oil'
        ---@type oil.SetupOpts
        keys = {
            {
                "<leader>fv",
                function()
                    require("oil").open_float(nil, { preview = {} })
                end,
                desc = "Open the file manager",
            },
            {
                "<leader>fw",
                function()
                    require("oil").open_float(vim.fn.getcwd(), { preview = {} })
                end,
                desc = "Open the file manager in the project root directory",
            },
        },
        opts = {
            float = {
                padding = 4,
                preview_split = "right",
            },
            keymaps = {
                ["g?"] = { "actions.show_help", mode = "n" },
                ["<CR>"] = "actions.select",
                ["<C-s>"] = false,
                ["<C-t>"] = false,
                ["<C-f>"] = "actions.preview",
                ["<C-c>"] = { "actions.close", mode = "n" },
                ["q"] = { "actions.close", mode = "n" },
                ["<C-l>"] = "actions.refresh",
                ["-"] = { "actions.parent", mode = "n" },
                ["<C-h>"] = { "actions.parent", mode = "n" },
                ["_"] = { "actions.open_cwd", mode = "n" },
                ["`"] = { "actions.cd", mode = "n" },
                ["~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
                ["gs"] = { "actions.change_sort", mode = "n" },
                ["gx"] = "actions.open_external",
                ["g."] = { "actions.toggle_hidden", mode = "n" },
                ["g\\"] = { "actions.toggle_trash", mode = "n" },
                ["<C-n>"] = { "actions.preview_scroll_down", mode = "n" },
                ["<C-p>"] = { "actions.preview_scroll_up", mode = "n" },
            },
            view_options = {
                show_hidden = true,
            },
        },
        dependencies = { { "echasnovski/mini.icons", opts = {} } },
        lazy = false,
    },
}
