return {
    {
        "olimorris/codecompanion.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        cmd = {
            "CodeCompanion",
            "CodeCompanionActions",
            "CodeCompanionChat",
        },
        keys = {
            {
                "<leader>aa",
                "<cmd>CodeCompanionActions<cr>",
                mode = { "n", "v" },
                desc = "AI actions",
            },
            {
                "<leader>at",
                "<cmd>CodeCompanionChat Toggle<cr>",
                mode = { "n", "v" },
                desc = "AI chat toggle",
            },
            {
                "<leader>as",
                "<cmd>CodeCompanionChat Add<cr>",
                mode = "v",
                desc = "AI send selection",
            },
        },
        opts = {
            interactions = {
                chat = {
                    adapter = 'codex',
                },
            },
        },
    },
}
