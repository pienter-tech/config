return {
    {
        "olimorris/persisted.nvim",
        lazy = false,
        opts = {
            autostart = true,
            autoload = true,
            on_autoload_no_session = function()
                vim.notify("No existing session to load.")
            end,
        },
    },
}
