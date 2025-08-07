return {
    {
        "nvim-treesitter/nvim-treesitter",
        version = false,
        build = ":TSUpdate",
        event = { "BufReadPre", "BufNewFile" },
        init = function(plugin)
            -- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/treesitter.lua
            require("lazy.core.loader").add_to_rtp(plugin)
            require("nvim-treesitter.query_predicates")
        end,
        cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
        config = function()
            local treesitter = require("nvim-treesitter.configs")

            treesitter.setup({
                highlight = { enable = true },
                indent = { enable = true },
                ensure_installed = {
                    "astro",
                    "bash",
                    "c",
                    "css",
                    "csv",
                    "diff",
                    "dockerfile",
                    "editorconfig",
                    "gitignore",
                    "go",
                    "html",
                    "javascript",
                    "jsdoc",
                    "json",
                    "lua",
                    "markdown",
                    "markdown_inline",
                    "nix",
                    "php",
                    "python",
                    "query",
                    "scss",
                    "sql",
                    "toml",
                    "tsx",
                    "twig",
                    "typescript",
                    "vim",
                    "vimdoc",
                    "vue",
                    "xml",
                    "yaml",
                },
                auto_install = true,
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = false,
                        node_incremental = false,
                        scope_incremental = false,
                        node_decremental = false,
                    },
                },
            })
        end,
    },
}
