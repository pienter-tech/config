return {
    "mrjones2014/legendary.nvim",
    lazy = false,
    priority = 10000,
    keys = {
        { "<leader>kv", ":Legendary<CR>", desc = "Show legendary" },
    },
    opts = {
        extensions = {
            lazy_nvim = true,
            smart_splits = {
                directions = { "h", "j", "k", "l" },
                mods = {
                    -- for moving cursor between windows
                    move = "<C>",
                    -- for resizing windows
                    resize = "<M>",
                    -- for swapping window buffers
                    swap = false, -- false disables creating a binding
                },
            },
        },
    },
}
