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
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            "williamboman/mason.nvim",
        },
        opts = {
            ensure_installed = {
                "astro",
                "cssls",
                "dockerls",
                "docker_compose_language_service",
                "gopls",
                "html",
                "tsserver",
                "biome",
                "lua_ls",
                "psalm",
                "intelephense",
                "rust_analyzer",
                "volar",
                "emmet_ls",
                "lemminx",
                "taplo",
            },
            automatic_installation = true,
        },
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        dependencies = {
            "williamboman/mason.nvim",
        },
        opts = {
            ensure_installed = {
                "prettier", -- prettier formatter
                "stylua", -- lua formatter
                "eslint_d", -- js linter
                "phpmd", -- php mess detector
                "phpcs", -- php code sniffer
                "php-cs-fixer", -- php code style fixer
                "phpcbf", -- php code beautifier
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
                            }
                        }
                    }
                    require("mason-nvim-dap").default_setup(config)
                end,
            },
        },
    },
}
