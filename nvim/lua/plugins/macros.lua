return {
    {
        "jesseleite/nvim-macroni",
        lazy = false,
        keys = {
            { "<leader>m", desc = "Macros", mode = "n" },
            { "<leader>my", "<cmd>YankMacro q<CR>", desc = "Yank macro q", mode = "n" },
        },
        opts = {
            macros = {
                obs_todo_finish = {
                    macro = '0f[<Esc>lrx<Ignore>ddGp<C-O>',
                },
                obs_todo_done = {
                    macro = '0f[<Esc>lrx',
                }
            }
        },
    },
}
