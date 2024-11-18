return {
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {
            fast_wrap = {},
            check_ts = true,
        },
        init = function()
            local Rule = require("nvim-autopairs.rule")
            local npairs = require("nvim-autopairs")

            npairs.add_rule(
                Rule("*", "*", "markdown"):with_move(function(opts)
                    return string.find(opts.text, "***", 1, true) == nil
                end)
            )
        end,
    },
    {
        "windwp/nvim-ts-autotag",
        event = "InsertEnter",
        opts = {
            opts = {
                enable_close = true, -- Auto close tags
                enable_rename = true, -- Auto rename pairs of tags
                enable_close_on_slash = false, -- Auto close on trailing </
            },
        },
    },
}
