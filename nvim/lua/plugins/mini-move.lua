return {
    {
        "echasnovski/mini.move",
        version = "*",
        keys = {
            { mode = "v", "<M-h>", desc = "Move visual selection left" },
            { mode = "v", "<M-l>", desc = "Move visual selection right" },
            { mode = "v", "<M-j>", desc = "Move visual selection down" },
            { mode = "v", "<M-k>", desc = "Move visual selection up" },
        },
        opts = {
            mappings = {
                left = "<M-h>",
                right = "<M-l>",
                down = "<M-j>",
                up = "<M-k>",

                line_left = "",
                line_right = "",
                line_down = "",
                line_up = "",
            },
            options = {
                reindent_linewise = true,
            },
        },
    },
}
