return {
    {
        "pienter-tech/codeium.nvim",
        enabled = false,
        event = "BufEnter",
        keys = {
            {
                mode = "i",
                "<C-j>",
                function()
                    local blink = require("blink.cmp")
                    blink.cancel()

                    require("codeium.virtual_text").cycle_or_complete()
                end,
                desc = "Codeium cycle or complete",
            },
        },
        init = function()
            vim.api.nvim_create_autocmd("User", {
                pattern = "BlinkCmpMenuOpen",
                callback = function()
                    require("codeium.virtual_text").clear()
                end,
            })
        end,
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
    {
        "milanglacier/minuet-ai.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        enabled = true,
        main = "minuet",
        keys = {
            {
                mode = "i",
                "<C-j>",
                function()
                    local blink = require("blink.cmp")
                    blink.cancel()

                    require("minuet.virtualtext").action.next()
                end,
                desc = "Codeium cycle or complete",
            },
        },
        opts = {
            provider = "gemini",
            virtualtext = {
                auto_trigger_ft = {},
                keymap = {
                    accept = "<C-l>",
                    accept_line = nil,
                    accept_n_lines = nil,
                    prev = "<C-k>",
                    next = nil,
                    dismiss = "<C-h>",
                },
            },
        },
        show_on_completion_menu = false,
    },
}
