return {
    {
        "zbirenbaum/copilot.lua",
        event = "VeryLazy",
        cmd = "Copilot",
        build = ":Copilot auth",
        keys = {
            -- add keymap
            {
                "<C-c>",
                function()
                    require("copilot.suggestion").accept()
                end,
                desc = "Accept copilot suggestion",
                mode = "i",
            },
            {
                "M-[",
                function ()
                    require("copilot.suggestion").prev()
                end,
                desc = "Prev copilot suggestion",
                mode = "i",
            },
            {
                "M-]",
                function ()
                    require("copilot.suggestion").next()
                end,
                desc = "Next copilot suggestion",
                mode = "i",
            }
        },
        opts = {
            suggestion = { enabled = true, auto_trigger = true, keymap = {} },
            panel = { enabled = false },
            filetypes = {
                markdown = true,
                help = true,
            },
        },
    },
}
