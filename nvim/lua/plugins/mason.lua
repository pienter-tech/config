return {
    {
        "mason-org/mason.nvim",
        opts = {
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        },
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        dependencies = {
            "mason-org/mason.nvim",
        },
        opts = {
            auto_update = true,
            ensure_installed = {
                "astro-language-server",
                "biome",
                "css-lsp",
                "css-variables-language-server",
                "docker-compose-language-service",
                "dockerfile-language-server",
                "emmet-language-server",
                "eslint-lsp",
                "gopls",
                "html-lsp",
                "intelephense",
                "json-lsp",
                "php-debug-adapter",
                "lemminx",
                "lua-language-server",
                "markdownlint",
                "prettier", -- prettier formatter
                "python-lsp-server",
                "remark-language-server",
                "some-sass-language-server",
                "stylua", -- lua formatter
                "taplo",
                "vtsls",
                "twiggy-language-server",
                "twig-cs-fixer",
                "vue-language-server",
                "yaml-language-server",
            },
        },
    },
    {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = {
            "mason-org/mason.nvim",
            "mfussenegger/nvim-dap",
        },
        opts = {
            automatic_setup = true,
            ensure_installed = {
                "php",
            },
            handlers = {
                function(config)
                    require("mason-nvim-dap").default_setup(config)
                end,
                php = function(config)
                    config.configurations = {
                        {
                            type = "php",
                            request = "launch",
                            name = "Dry Xdebug",
                            port = 9003,
                            stopOnEntry = false,
                            pathMappings = {
                                ["/var/www/html"] = "${workspaceFolder}",
                                ["/var/www/dry/src/dry"] = "${workspaceFolder}/dry",
                            },
                        },
                        {
                            type = "php",
                            request = "launch",
                            name = "ASP Debug",
                            port = 9003,
                            stopOnEntry = false,
                            pathMappings = {
                                ["/var/www/html"] = "${workspaceFolder}/backend",
                            },
                        },
                    }
                    require("mason-nvim-dap").default_setup(config)
                end,
            },
        },
    },
}
