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
            local cond = require 'nvim-autopairs.conds'

            npairs.add_rule(Rule("*", "*", "markdown"):with_move(function(opts)
                return string.find(opts.text, "***", 1, true) == nil
            end))

            npairs.add_rule(Rule("%", "%", { "twig", "tmp" })
                :with_pair(function(opts)
                    return "{" .. "}" == opts.line:sub(opts.col - #"{", opts.col + #"}" - 1)
                end)
                :with_move(cond.none())
                :with_cr(cond.none())
                :with_del(function(opts)
                    local col = vim.api.nvim_win_get_cursor(0)[2]
                    return "{" .. "%" .. "%" .. "}" == opts.line:sub(col - #"{" - #"%" + 1, col + #"%" + #"}")
                end))
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
