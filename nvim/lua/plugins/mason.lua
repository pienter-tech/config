return {
    {
        "williamboman/mason.nvim",
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
            "williamboman/mason-lspconfig.nvim",
            "williamboman/mason.nvim",
        },
        opts = {
            auto_update = true,
            integrations = {
                ["mason-lspconfig"] = true,
            },
            ensure_installed = {
                "astro",
                "biome",
                "cssls",
                "docker_compose_language_service",
                "dockerls",
                "emmet_ls",
                "eslint",
                "gopls",
                "html",
                "intelephense",
                "jsonls",
                "lemminx",
                "lua_ls",
                "markdownlint",
                "nil_ls",
                "php-cs-fixer", -- php code style fixer
                "phpcbf", -- php code beautifier
                "phpcs", -- php code sniffer
                "phpmd", -- php mess detector
                "prettier", -- prettier formatter
                "remark_ls",
                "rust_analyzer",
                "some-sass-language-server",
                "stylua", -- lua formatter
                "taplo",
                "ts_ls",
                "twiggy-language-server",
                "twig-cs-fixer",
                "volar",
                "yamlls",
            },
        },
    },
    {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = {
            "williamboman/mason.nvim",
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
