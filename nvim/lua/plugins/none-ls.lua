return {
	"nvimtools/none-ls.nvim", -- configure formatters & linters
	dependencies = {
		"jay-babu/mason-null-ls.nvim",
	},
	config = function()
		local mason_null_ls = require("mason-null-ls")
		local null_ls = require("null-ls")
		local null_ls_utils = require("null-ls.utils")

		mason_null_ls.setup({
			ensure_installed = {
				"prettier", -- prettier formatter
				"stylua", -- lua formatter
			},
		})

		local formatting = null_ls.builtins.formatting -- to setup formatters

		null_ls.setup({
			root_dir = null_ls_utils.root_pattern(".null-ls-root", "Makefile", ".git", "package.json"),
			sources = {
				formatting.prettier.with({
					extra_filetypes = { "svelte", "astro" },
				}),
				formatting.stylua,
			},
		})
	end,
}
