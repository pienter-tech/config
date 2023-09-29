return {
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        event = { 'BufReadPost', 'BufNewFile' },
        config = function()
            require('nvim-treesitter.configs').setup({
                {
                    ensure_installed = {
                        "c",
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
                    },
                },
                auto_install = true,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "<leader>ss", -- set to `false` to disable one of the mappings
                        node_incremental = "<leader>ss",
                        scope_incremental = "grc",
                        node_decremental = "<leader>sd",
                    },
                },
                indent = {
                    enable = true
                },

            })
        end,
    },
    {
        'nvim-treesitter/nvim-treesitter-context',
        dependencies = 'nvim-treesitter/nvim-treesitter',
        event = { 'BufReadPost', 'BufNewFile' },
        config = true,
    }
}
