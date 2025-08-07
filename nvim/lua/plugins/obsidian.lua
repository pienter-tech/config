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
                right_pad = 2,
                unchecked = {
                    icon = "󰄱 ",
                    highlight = "RenderMarkdownUnchecked",
                },
                checked = {
                    icon = "󰱒 ",
                    highlight = "RenderMarkdownChecked",
                },
                custom = {
                    rescheduled = { raw = "[>]", rendered = " ", highlight = "RenderMarkdownTodo" },
                    scheduled = { raw = "[<]", rendered = " ", highlight = "RenderMarkdownTodo" },
                    important = { raw = "[!]", rendered = " ", highlight = "RenderMarkdownInfo" },
                    cancelled = { raw = "[-]", rendered = " ", highlight = "RenderMarkdownWarn" },
                },
            },
        },
        dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" },
    },
    {
        "epwalsh/obsidian.nvim",
        enabled = false,
        version = "*",
        lazy = true,
        event = {
            "BufReadPre /Users/korneel/Obsidian/two/**/**.md",
            "BufNewFile /Users/korneel/Obsidian/two/**/**.md",
        },
        keys = {
            { mode = "n", "<localleader>nn", ":ObsidianNew<CR>", desc = "Create a new note." },
            { mode = "n", "<localleader>ff", ":ObsidianQuickSwitch<CR>", desc = "Find and open note" },
            { mode = "n", "<localleader>gf", ":ObsidianFollowLink<CR>", desc = "Open link" },
            { mode = "n", "<localleader>gi", ":ObsidianQuickSwitch root<CR>", desc = "Go to root index" },
            { mode = "n", "<localleader>gt", ":ObsidianQuickSwitch todo-root<CR>", desc = "Go to todo index" },
            { mode = "n", "<localleader>gf", ":ObsidianQuickSwitch future<CR>", desc = "Go to future" },
            { mode = "n", "<localleader>gw", ":ObsidianQuickSwitch house<CR>", desc = "Go to work@home" },
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
                ':!cd "/Users/korneel/Obsidian/two/projects/tnt" && git pull<CR>',
                desc = "Pull TNT notes",
            },
            {
                mode = "n",
                "<localleader>nP",
                ':!cd "/Users/korneel/Obsidian/two/projects/tnt" && git pull && git add . && git commit -m "Update" && git push<CR>',
                desc = "Commit and Push TNT notes",
            },
            {
                mode = "n",
                "<localleader>tf",
                function()
                    require("macroni").run_saved("obs_todo_finish")
                end,
                desc = "Mark to as done and move to bottom of file",
            },
            {
                mode = "n",
                "<localleader>td",
                function()
                    require("macroni").run_saved("obs_todo_done")
                end,
                desc = "Mark to as done",
            },
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
                    path = "/Users/korneel/Obsidian/two",
                },
                {
                    name = "tnt",
                    path = "/Users/korneel/Obsidian/tnt",
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
                substitutions = {
                    test = function ()
                        return note.title
                    end,
                    filename = function()
                        return vim.fn.expand("%:t")
                    end,
                    yesterday = function()
                        return os.date("%Y-%m-%d", os.time() - 86400)
                    end,
                    tomorrow = function()
                        return os.date("%Y-%m-%d", os.time() + 86400)
                    end,
                    today_plus_two = function()
                        return os.date("%Y-%m-%d", os.time() + 86400 * 2)
                    end,
                    today_plus_three = function()
                        return os.date("%Y-%m-%d", os.time() + 86400 * 3)
                    end,
                },
            },
            preferred_link_style = "markdown",
            ui = {
                enable = false,
                checkboxes = {
                    [" "] = { char = "☐", hl_group = "ObsidianTodo" },
                    ["x"] = { char = "✔", hl_group = "ObsidianDone" },
                    [">"] = {},
                    ["<"] = {},
                    ["!"] = {},
                    ["-"] = {},
                },
            },
            follow_url_func = function(url)
                if url:match("^message://") then
                    vim.fn.jobstart({ "open", "-b", "com.apple.mail", url }, { detach = true })
                    return
                end
                if url:match("^https://app%.shortcut%.com/") then
                    -- Adjust the app name if yours is different,
                    -- e.g. "Chrome Apps/Shortcut" or the exact bundle identifier.
                    vim.fn.jobstart({ "open", "-a", "Shortcut", url }, { detach = true })
                    return
                end
                vim.fn.jobstart({ "open", url }, { detach = true })
            end,
        },
    },
}
