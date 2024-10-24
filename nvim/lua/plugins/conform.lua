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
                html = { "prettier" },
                json = { "prettier" },
                yaml = { "prettier" },
                markdown = { "prettier" },
                astro = { "prettier" },
                graphql = { "prettier" },
                vue = { "prettier" },
                php = { { "pint", "phpinsights", "php_cs_fixer" } },
                toml = { "taplo" },
            },
        },
    },
}
