return {
    {
        "rcarriga/nvim-notify",
        opts = {
            stages = "static",
            timeout = 3000,
            on_open = function(win)
                vim.api.nvim_win_set_config(win, { focusable = false })
            end,
        },
    },
}
