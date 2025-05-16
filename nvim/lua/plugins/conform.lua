return {
    {
        "stevearc/conform.nvim",
        lazy = true,
        event = { "BufReadPre", "BufNewFile" },
        keys = {
            {
                "<F3>",
                function()
                    require("conform").format({ lsp_fallback = true })
                end,
                desc = "Format file",
            },
            {
                "<leader>3",
                function()
                    require("conform").format({ lsp_fallback = true })
                end,
                desc = "Format file",
            },
        },
        opts = {
            formatters_by_ft = {
                lua = { "stylua" },
                javascript = { "prettier" },
                typescript = { "prettier" },
                javascriptreact = { "prettier" },
                typescriptreact = { "prettier" },
                svelte = { "prettier" },
                css = { "prettier" },
                scss = { "prettier" },
                html = { "prettier" },
                json = { "prettier" },
                yaml = { "prettier" },
                markdown = { "markdownlint" },
                astro = { "prettier" },
                graphql = { "prettier" },
                vue = { "prettier" },
                php = { "pint", "prettier", "phpinsights", "php_cs_fixer", stop_after_first = true },
                toml = { "taplo" },
                twig = { "prettier", "twig-cs-fixer", stop_after_first = false },
            },
        },
    },
}
