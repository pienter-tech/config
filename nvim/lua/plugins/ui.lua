return {
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        keys = {
            {
                mode = "n",
                "<leader>b",
                desc = "Buffers",
            },
            {
                mode = "n",
                "<leader>bc",
                function()
                    require("snacks").bufdelete()
                end,
                desc = "Close current Buffer",
            },
            {
                mode = "n",
                "<leader>bo",
                function()
                    require("snacks").bufdelete.other()
                end,
                desc = "Close other Buffers",
            },
            {
                "<leader>gg",
                function()
                    require("snacks").lazygit()
                end,
                desc = "Open LazyGit in popup",
                mode = "n",
                silent = true,
            },
            {
                "<leader>gl",
                function()
                    require("snacks").git.blame_line()
                end,
                desc = "Toggle Git Blame popup for this line",
            },
        },
        ---@type snacks.Config
        opts = {
            animate = {},
            bigfile = { enabled = true },
            bugdelete = {},
            dashboard = { enabled = false },
            debug = {},
            dim = { enabled = false },
            explorer = { enabled = false },
            git = {},
            gitbrowse = {},
            image = { enabled = false },
            indent = { enabled = true, animate = { enabled = false } },
            input = { enabled = true },
            layout = { enabled = false },
            lazygit = { enable = true },
            picker = { enabled = true },
            notifier = { enabled = true },
            quickfile = { enabled = true },
            rename = { enabled = false },
            scope = { enabled = true },
            scratch = { enabled = false },
            scroll = { enabled = true },
            statuscolumn = { enabled = true },
            terminal = { enabled = true },
            words = { enabled = true },
        },
    },
    {
        "folke/noice.nvim",
        enabled = true,
        event = "VeryLazy",
        opts = {
            lsp = {
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
                },
            },
            presets = {
                bottom_search = true, -- use a classic bottom cmdline for search
                command_palette = true, -- position the cmdline and popupmenu together
                long_message_to_split = true, -- long messages will be sent to a split
                inc_rename = false, -- enables an input dialog for inc-rename.nvim
                lsp_doc_border = false, -- add a border to hover docs and signature help
            },
        },
        dependencies = {
            "MunifTanjim/nui.nvim",
        },
    },
}
