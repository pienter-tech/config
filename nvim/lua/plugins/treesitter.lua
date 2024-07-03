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
                    "bash",
                    "c",
                    "diff",
                    "lua",
                    "vim",
                    "vimdoc",
                    "query",
                    "astro",
                    "css",
                    "csv",
                    "dockerfile",
                    "gitignore",
                    "go",
                    "html",
                    "javascript",
                    "jsdoc",
                    "json",
                    "php",
                    "python",
                    "scss",
                    "sql",
                    "toml",
                    "typescript",
                    "tsx",
                    "vue",
                    "yaml",
                    "toml",
                    "markdown",
                    "markdown_inline",
                    "xml",
                },
                auto_install = true,
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "<C-Space>",
                        node_incremental = "<C-Space>",
                        scope_incremental = false,
                        node_decremental = "<C-M-Space>",
                    },
                },
            })
        end,
    },
}
