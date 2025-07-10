return {
    "folke/trouble.nvim",
    enabled = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
    keys = {
        {"<leader>x", desc = "Trouble keybinds"},
        {
            "<leader>xf",
            function()
                require("trouble").focus({})
            end,
            desc = "Focus trouble window",
        },
        {
            "<leader>xc",
            function()
                require("trouble").close({})
            end,
            desc = "Close trouble window",
        },
        {
            "<leader>xn",
            function()
                require("trouble").next({})
            end,
            desc = "Next trouble item",
        },
        {
            "<leader>xp",
            function()
                require("trouble").next({})
            end,
            desc = "Previous trouble item",
        },
        {
            "<leader>xx",
            "<cmd>Trouble diagnostics toggle<cr>",
            desc = "Diagnostics (Trouble)",
        },
        {
            "<leader>xX",
            "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
            desc = "Buffer Diagnostics (Trouble)",
        },
        {
            "<leader>cs",
            "<cmd>Trouble symbols toggle focus=false<cr>",
            desc = "Symbols (Trouble)",
        },
        {
            "<leader>cl",
            "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
            desc = "LSP Definitions / references / ... (Trouble)",
        },
        {
            "<leader>xL",
            "<cmd>Trouble loclist toggle<cr>",
            desc = "Location List (Trouble)",
        },
        {
            "<leader>xQ",
            "<cmd>Trouble qflist toggle<cr>",
            desc = "Quickfix List (Trouble)",
        },
    },
}
