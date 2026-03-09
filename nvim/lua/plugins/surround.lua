return {
    {
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        init = function()
            vim.g.nvim_surround_no_mappings = true
        end,
        keys = {
            { "<C-g>s", "<Plug>(nvim-surround-insert)", mode = "i", desc = "Add surround (insert mode)" },
            { "<C-g>S", "<Plug>(nvim-surround-insert-line)", mode = "i", desc = "Add surround with new lines (insert mode)" },
            { "ys", "<Plug>(nvim-surround-normal)", mode = "n", desc = "Add surround around motion" },
            { "yss", "<Plug>(nvim-surround-normal-cur)", mode = "n", desc = "Add surround around current line" },
            { "yS", "<Plug>(nvim-surround-normal-line)", mode = "n", desc = "Add surround around motion with new lines" },
            { "ySS", "<Plug>(nvim-surround-normal-cur-line)", mode = "n", desc = "Add surround around current line with new lines" },
            { "u", "<Plug>(nvim-surround-visual)", mode = "x", desc = "Add surround around visual selection" },
            { "gS", "<Plug>(nvim-surround-visual-line)", mode = "x", desc = "Add surround around visual selection with new lines" },
            { "ds", "<Plug>(nvim-surround-delete)", mode = "n", desc = "Delete surround" },
            { "cs", "<Plug>(nvim-surround-change)", mode = "n", desc = "Change surround" },
            { "cS", "<Plug>(nvim-surround-change-line)", mode = "n", desc = "Change surround with new lines" },
        },
    },
}
