return {
    {
        "rmagatti/auto-session",
        opts = {
            auto_restore_enabled = true,
            auto_session_suppress_dirs = { "~/", "~/Dev/", "~/Downloads", "~/Documents", "~/Desktop/" },
            auto_save_enabled = true,
        },
        keys = {
            { "<leader>wr", "<cmd>SessionRestore<CR>", desc = "Resore session for cwd", mode = "n" },
            { "<leader>ws", "<cmd>SessionSave<CR>",    desc = "Save session for cwd",   mode = "n" },
        }
    }
}
