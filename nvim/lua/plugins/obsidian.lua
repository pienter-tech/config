return {
    {
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
            latex = { enabled = false },
            heading = {
                enabled = true,
                sign = true,
                position = "overlay",
                icons = {
                    "◈ ",
                    "◇◇ ",
                    "◆◆◆ ",
                    "⋄⋄⋄⋄ ",
                    "❖❖❖❖❖ ",
                    "⟡⟡⟡⟡⟡⟡⟡  ",
                },
                signs = { "󰫎 " },
                width = "full",
                left_pad = 0,
                right_pad = 0,
                min_width = 0,
                border = true,
                border_prefix = false,
                above = " ",
                below = " ",
                backgrounds = {
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                },
                foregrounds = {
                    "RenderMarkdownH1",
                    "RenderMarkdownH2",
                    "RenderMarkdownH3",
                    "RenderMarkdownH4",
                    "RenderMarkdownH5",
                    "RenderMarkdownH6",
                },
            },
            indent = {
                enabled = true,
                per_level = 2,
            },
            bullet = {
                enabled = true,
                icons = { "○", "●", "◆", "◇" },
                left_pad = 0,
                right_pad = 0,
                highlight = "RenderMarkdownBullet",
            },
            checkbox = {
                enabled = true,
                position = "inline",
                unchecked = {
                    icon = "󰄱 ",
                    highlight = "RenderMarkdownUnchecked",
                },
                checked = {
                    icon = "󰱒 ",
                    highlight = "RenderMarkdownChecked",
                },
                custom = {
                    todo = { raw = "[>]", rendered = "󰥔 ", highlight = "RenderMarkdownTodo" },
                },
            },
        },
        dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" },
    },
    {
        "epwalsh/obsidian.nvim",
        version = "*",
        lazy = true,
        event = {
            "BufReadPre /Users/korneel/Library/Mobile Documents/iCloud~md~obsidian/Documents/two/**/**.md",
            "BufNewFile /Users/korneel/Library/Mobile Documents/iCloud~md~obsidian/Documents/two/**/**.md",
        },
        keys = {
            { mode = "n", "<localleader>nn", ":ObsidianNew<CR>", desc = "Create a new note." },
            { mode = "n", "<localleader>ff", ":ObsidianQuickSwitch<CR>", desc = "Find and open note" },
            { mode = "n", "<localleader>gf", ":ObsidianFollowLink<CR>", desc = "Open link" },
            { mode = "n", "<localleader>gi", ":ObsidianQuickSwitch root<CR>", desc = "Go to root index" },
            { mode = "n", "<localleader>gt", ":ObsidianQuickSwitch todo-root<CR>", desc = "Go to todo index" },
            { mode = "n", "<localleader>gf", ":ObsidianQuickSwitch future<CR>", desc = "Go to future" },
            { mode = "n", "<localleader>gh", ":ObsidianFollowLink hsplit<CR>", desc = "Open link in horizontal split" },
            { mode = "n", "<localleader>gc", ":ObsidianFollowLink csplit<CR>", desc = "Open link in vertical split" },
            { mode = "n", "<localleader>jj", ":ObsidianToday<CR>", desc = "Open todays note" },
            { mode = "n", "<localleader>jn", ":ObsidianToday +1<CR>", desc = "Open tomorrow note" },
            { mode = "n", "<localleader>jp", ":ObsidianToday -1<CR>", desc = "Open yesterday note" },
            {
                mode = "n",
                "<localleader>fj",
                ":ObsidianDailies -50 2<CR>",
                desc = "Search for journal notes in the past 50 days",
            },
            {
                mode = "n",
                "<localleader>fl",
                ":ObsidianLinks<CR>",
                desc = "Collect all links within the current buffer into a picker window",
            },
            { mode = "n", "<localleader>tt", ":ObsidianToggleCheckbox<CR>", desc = "Cycle through checkbox options" },
            {
                mode = "n",
                "<localleader>fc",
                ":ObsidianTOC<CR>",
                desc = "Load the table of contents of the current note into a picker list",
            },
            {
                mode = "n",
                "<localleader>fb",
                ":ObsidianBacklinks<CR>",
                desc = "Get a picker list of reference to the current buffer",
            },
            {
                mode = "n",
                "<localleader>ft",
                ":ObsidianTags<CR>",
                desc = "Get a picker list of all occurrences of the selected tags",
            },
            {
                mode = "n",
                "<localleader>np",
                ':!cd "/Users/korneel/Library/Mobile Documents/iCloud~md~obsidian/Documents/two/projects/tnt" && git pull<CR>',
                desc = "Pull TNT notes"
            },
            {
                mode = "n",
                "<localleader>nP",
                ':!cd "/Users/korneel/Library/Mobile Documents/iCloud~md~obsidian/Documents/two/projects/tnt" && git pull && git add . && git commit -m "Update" && git push<CR>',
                desc = "Commit and Push TNT notes"
            }
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "hrsh7th/nvim-cmp",
            "nvim-telescope/telescope.nvim",
            "nvim-treesitter",
        },
        opts = {
            workspaces = {
                {
                    name = "personal",
                    path = "/Users/korneel/Library/Mobile Documents/iCloud~md~obsidian/Documents/two",
                },
            },
            notes_subdir = "notes",
            daily_notes = {
                folder = "journal/daily",
                default_tags = { "journal" },
                template = "journal",
            },
            completion = {
                nvim_cmp = true,
                min_chars = 2,
            },
            templates = {
                folder = "templates",
                date_format = "%Y-%m-%d",
                time_format = "%H:%M",
                -- A map for custom variables, the key should be the variable and the value a function
                substitutions = {},
            },
            ui = {
                enable = false,
            },
            follow_url_func = function(url)
                vim.fn.jobstart({ "open", url })
            end,
        },
    },
}