return {
    {
        "pienter-tech/codeium.nvim",
        enabled = true,
        event = "BufEnter",
        keys = {
            {
                mode = "i",
                "<C-j>",
                function()
                    require("cmp").abort()

                    require("codeium.virtual_text").cycle_or_complete()
                end,
                desc = "Codeium cycle or complete",
            },
        },
        opts = {
            enable_cmp_source = false,
            virtual_text = {
                enabled = true,
                manual = false,
                manual_render = true,

                map_keys = true,
                key_bindings = {
                    -- Accept the current completion.
                    accept = "<C-l>",
                    -- Accept the next word.
                    accept_word = false,
                    -- Accept the next line.
                    accept_line = false,
                    -- Clear the virtual text.
                    clear = "<C-h>",
                    -- Cycle to the next completion.
                    next = false,
                    -- Cycle to the previous completion.
                    prev = "<C-k>",
                },
            },
            workspace_root = {
                use_lsp = true,
                find_root = nil,
                paths = {
                    ".wakatime-project",
                    ".bzr",
                    ".git",
                    ".hg",
                    ".svn",
                    "_FOSSIL_",
                    "package.json",
                },
            },
        },
    },
}
