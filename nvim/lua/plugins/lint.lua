return {
    {
        "mfussenegger/nvim-lint",
        lazy = true,
        event = { "BufReadPre", "BufNewFile" },
        keys = {
            {
                "<F4>",
                function()
                    require("lint").try_lint()
                end,
                desc = "Trigger linting for current file",
            },
        },
        config = function()
            local lint = require("lint")

            lint.linters_by_ft = {
                javascript = { "eslint_d" },
                typescript = { "eslint_d" },
                javascriptreact = { "eslint_d" },
                typescriptreact = { "eslint_d" },
                vue = { "eslint_d" },
                svelte = { "eslint_d" },
                php = { "phpinsights", },
            }

            local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

            vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
                group = lint_augroup,
                callback = function()
                    lint.try_lint()
                end,
            })
        end,
    },
}
