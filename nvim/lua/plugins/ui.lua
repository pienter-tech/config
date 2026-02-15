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
                mode = "n",
                "<leader>bO",
                function()
                    require("snacks").bufdelete.other()
                    vim.cmd("only")
                end,
                desc = "Close other Buffers and Windows",
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
            {
                "<leader>n",
                function()
                    require("snacks").notifier.show_history()
                end,
                desc = "Notification History",
            },
            {
                "<leader>fn",
                function()
                    if vim.api.nvim_buf_get_option(0, "filetype") == "netrw" and vim.fn.exists(":Rexplore") then
                        vim.cmd("Rexplore")
                    else
                        vim.cmd("Explore")
                    end
                end,
                desc = "Open netrw",
                mode = "n",
            },
            {
                "<leader>ff",
                function()
                    require("snacks").picker.files({ hidden = true })
                end,
                desc = "Find files",
                mode = "n",
            },
            {
                "<leader>fg",
                function()
                    require("snacks").picker.git_log_file()
                end,
                desc = "Current buffer git history",
                mode = "n",
            },
            {
                "<leader>fd",
                function()
                    require("snacks").picker.grep()
                end,
                desc = "Search files with grep",
                mode = "n",
            },
            {
                "<leader>fd",
                function()
                    require("snacks").picker.grep_word()
                end,
                desc = "Search files with grep",
                mode = "x",
            },
            {
                "<leader>fs",
                function()
                    require("snacks").picker.grep_word()
                end,
                desc = "Search for the string under your cursor or selection",
                mode = "n",
            },
            {
                "<leader>fm",
                function()
                    require("snacks").picker.marks()
                end,
                desc = "Find marks",
                mode = "n",
            },
            {
                "<leader>fb",
                function()
                    require("snacks").picker.buffers()
                end,
                desc = "Find files in buffers",
                mode = "n",
            },
            {
                "<leader>fh",
                function()
                    require("snacks").picker.help()
                end,
                desc = "Find help tags",
                mode = "n",
            },
            {
                "<leader>fr",
                function()
                    require("snacks").picker.resume()
                end,
                desc = "Resume previous find",
                mode = "n",
            },
            {
                "<leader>fp",
                function()
                    require("snacks").picker.pickers()
                end,
                desc = "Search pickers",
                mode = "n",
            },
            {
                "<leader>fM",
                function()
                    local telescope = require("telescope")
                    telescope.load_extension("macroni")
                    telescope.extensions.macroni.saved_macros()
                end,
                desc = "Search macros",
                mode = "n",
            },
            {
                "<leader>dm",
                function()
                    require("snacks").image.hover()
                end,
                desc = "Show image/diagram at cursor",
                mode = "n",
            },
            {
                "<leader>z",
                function()
                    require("snacks").zen()
                end,
                desc = "Toggle Zen Mode",
            },
            {
                "<leader>Z",
                function()
                    require("snacks").zen.zoom()
                end,
                desc = "Toggle Zoom",
            },
        },
        ---@type snacks.Config
        opts = {
            animate = {},
            bigfile = { enabled = true },
            bufdelete = {},
            dashboard = { enabled = false },
            debug = {},
            dim = {},
            explorer = { enabled = false },
            git = {},
            gitbrowse = {},
            image = { enabled = true },
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
            scroll = { enabled = false },
            statuscolumn = { enabled = true },
            terminal = { enabled = true },
            words = { enabled = true },
            zen = {
                toggles = { dim = false}
            },
            ---@type table<string, snacks.win.Config>
            styles = {
                zen = {
                    width = 150,
                    backdrop = { transparent = true, blend = 10 },
                    keys = { q = "close" },
                },
            },
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
