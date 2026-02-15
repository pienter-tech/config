local show_lsp_notifications = vim.g.lsp_debug_notifications == true

local lsp_servers = {
    "astro",
    "biome",
    "css_variables",
    "cssls",
    "docker_compose_language_service",
    "dockerls",
    "emmet_language_server",
    "eslint",
    "gopls",
    "html",
    "intelephense",
    "jsonls",
    "lemminx",
    "luals",
    "remark_ls",
    "somesass_ls",
    "taplo",
    "vtsls",
    "twiggy_language_server",
    "vue_ls",
    "pylsp",
    "yamlls",
}

for _, server in ipairs(lsp_servers) do
    vim.lsp.enable(server)
end

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("my.lsp", {}),
    callback = function(args)
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
        if show_lsp_notifications then
            vim.notify("LSP started for " .. client.name, vim.log.levels.INFO, { title = "LSP" })
        end

        local function map(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, {
                noremap = true,
                silent = true,
                buffer = args.buf,
                desc = desc,
            })
        end

        if client:supports_method("textDocument/references") then
            map("n", "grr", vim.lsp.buf.references, "Show LSP references")
            map("n", "gR", "<cmd>Telescope lsp_references<CR>", "Show LSP references")
        end

        if client:supports_method("textDocument/definition") then
            map("n", "grd", vim.lsp.buf.definition, "Go to definition")
            map("n", "gd", "<cmd>Telescope lsp_definitions<CR>", "Show LSP definitions")
        end

        if client:supports_method("textDocument/declaration") then
            map("n", "grD", vim.lsp.buf.declaration, "Go to declaration")
        end
        if client:supports_method("textDocument/implementation") then
            map("n", "gri", vim.lsp.buf.implementation, "Show LSP implementations")
            map("n", "gi", "<cmd>Telescope lsp_implementations<CR>", "Show LSP implementations")
        end

        if client:supports_method("textDocument/typeDefinition") then
            map("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", "Show LSP type definitions")
        end

        if client:supports_method("textDocument/rename") then
            map("n", "<leader>cr", vim.lsp.buf.rename, "Smart rename")
            map("n", "grn", vim.lsp.buf.rename, "Smart rename")
        end

        if client:supports_method("textDocument/codeAction") then
            map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "See available code actions")
            map({ "n", "v" }, "gra", vim.lsp.buf.code_action, "See available code actions")
        end

        -- if client.server_capabilities.documentSymbolProvider then
        --   local navic = require("nvim-navic")
        --   navic.attach(client, args.buf)
        -- end

        map("n", "<leader>cd", "<cmd>Telescope diagnostics bufnr=0<CR>", "Show buffer diagnostics")

        map("n", "<leader>cD", vim.diagnostic.open_float, "Show line diagnostics")

        map("n", "<S-F2>", function()
            vim.diagnostic.jump({ count = -1, float = true })
        end, "Go to previous diagnostic")

        map("n", "<F2>", function()
            vim.diagnostic.jump({ count = 1, float = true })
        end, "Go to next diagnostic")

        map("n", "<leader>@", function()
            vim.diagnostic.jump({ count = -1, float = true })
        end, "Go to previous diagnostic")

        map("n", "<leader>2", function()
            vim.diagnostic.jump({ count = 1, float = true })
        end, "Go to next diagnostic")

        map("n", "<F1>", vim.lsp.buf.hover, "Show documentation for what is under cursor")

        map("n", "<leader>1", vim.lsp.buf.hover, "Show documentation for what is under cursor")
    end,
})
