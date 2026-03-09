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
}
