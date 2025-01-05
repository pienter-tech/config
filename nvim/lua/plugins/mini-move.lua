return {
    {
        "echasnovski/mini.move",
        version = "*",
        keys = {
            { mode = "v", "<C-h>", desc = "Move visual selection left" },
            { mode = "v", "<C-l>", desc = "Move visual selection right" },
            { mode = "v", "<C-j>", desc = "Move visual selection down" },
            { mode = "v", "<C-k>", desc = "Move visual selection up" },
        },
        opts = {
            mappings = {
                left = "<C-h>",
                right = "<C-l>",
                down = "<C-j>",
                up = "<C-k>",

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
