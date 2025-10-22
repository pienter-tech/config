return {
    "mrjones2014/smart-splits.nvim",
    lazy = false,
    priority = 999,
    keys = {
        {
            mode = "n",
            "<C-h>",
            function()
                require("smart-splits").move_cursor_left()
            end,
            desc = "Move to window: left",
        },
        {
            mode = "n",
            "<C-j>",
            function()
                require("smart-splits").move_cursor_down()
            end,
            desc = "Move to window: down",
        },
        {
            mode = "n",
            "<C-k>",
            function()
                require("smart-splits").move_cursor_up()
            end,
            desc = "Move to window: up",
        },
        {
            mode = "n",
            "<C-l>",
            function()
                require("smart-splits").move_cursor_right()
            end,
            desc = "Move to window: right",
        },
        {
            mode = "n",
            "<C-S-h>",
            function()
                require("smart-splits").resize_left()
            end,
            desc = "Resize window: left",
        },
        {
            mode = "n",
            "<C-S-j>",
            function()
                require("smart-splits").resize_down()
            end,
            desc = "Resize window: down",
        },
        {
            mode = "n",
            "<C-S-k>",
            function()
                require("smart-splits").resize_up()
            end,
            desc = "Resize window: up",
        },
        {
            mode = "n",
            "<C-S-l>",
            function()
                require("smart-splits").resize_right()
            end,
            desc = "Resize window: right",
        },
    },
    opts = {
        at_edge = "stop",
        float_win_behavior = "mux",
    },
}
