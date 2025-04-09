return {
    {
        "nvim-telescope/telescope.nvim",
        lazy = false,
        tag = "0.1.6",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-fzf-native.nvim",
            "olimorris/persisted.nvim",
            "nvim-telescope/telescope-live-grep-args.nvim",
        },
        config = function()
            local telescope = require("telescope")
            local lga_actions = require("telescope-live-grep-args.actions")
            telescope.setup({
                defaults = {
                    cache_picker = {
                        num_pickers = 5,
                    },
                    file_ignore_patterns = { ".git/" },
                },
                pickers = {
                    find_files = {
                        hidden = true,
                    },
                },
                extensions = {
                    live_grep_args = {
                        auto_quoting = true, -- enable/disable auto-quoting
                        mappings = { -- extend mappings
                            i = {
                                ["<C-k>"] = lga_actions.quote_prompt(),
                                ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
                                -- freeze the current list and start a fuzzy search in the frozen list
                                ["<C-space>"] = lga_actions.to_fuzzy_refine,
                            },
                        },
                    },
                },
            })
            telescope.load_extension("fzf")
            telescope.load_extension("persisted")
        end,
        keys = {
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
            { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Telescope find files", mode = "n" },
            { "<leader>fg", "<cmd>Telescope git_files<CR>", desc = "Telescope find files in git", mode = "n" },
            {
                "<leader>fd",
                function()
                    require("telescope").extensions.live_grep_args.live_grep_args()
                end,
                desc = "Telescope search files with grep",
                mode = "n",
            },
            {
                "<leader>fd",
                function()
                    require("telescope-live-grep-args.shortcuts").grep_visual_selection()
                end,
                desc = "Telescope search files with grep",
                mode = "v",
            },
            {
                "<leader>fs",
                function()
                    require("telescope-live-grep-args.shortcuts").grep_word_under_cursor()
                end,
                desc = "Telescope search for the string under your cursor or selection",
                mode = "n",
            },
            { "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Telescope find files in buffers", mode = "n" },
            { "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "Telescope find help tags", mode = "n" },
            { "<leader>fr", "<cmd>Telescope resume<CR>", desc = "Telescope resume previous find", mode = "n" },
            { "<leader>fp", "<cmd>Telescope pickers<CR>", desc = "Telescope search pickers", mode = "n" },
            {
                "<leader>fm",
                function()
                    require("telescope").extensions.macroni.saved_macros()
                end,
                desc = "Telescope search pickers",
                mode = "n",
            },
        },
    },
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "gmake",
    },
}
