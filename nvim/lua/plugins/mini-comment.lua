return {
    {
        "JoosepAlviste/nvim-ts-context-commentstring",
        lazy = true,
        opts = {
            enable_autocmd = false,
        },
    },
    {
        "echasnovski/mini.comment",
        version = "*",
        event = "VeryLazy",
        dependencies = {
            "JoosepAlviste/nvim-ts-context-commentstring",
        },
        opts = {
            options = {
                custom_commentstring = function()
                    return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo
                    .commentstring
                end
            },
            mappings = {
                comment = "gc",
                comment_line = "gcc",
                comment_visual = "gc",
                textobject = "gc",
            }
        }
    }
}
