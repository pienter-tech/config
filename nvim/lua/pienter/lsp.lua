vim.notify("Run")

vim.lsp.enable("astro")
vim.lsp.enable("biome")
vim.lsp.enable("css_variables")
vim.lsp.enable("cssls")
vim.lsp.enable("docker_compose_language_service")
vim.lsp.enable("dockerls")
vim.lsp.enable("emmet_language_server")
vim.lsp.enable("eslint")
vim.lsp.enable("gopls")
vim.lsp.enable("html")
vim.lsp.enable("intelephense")
vim.lsp.enable("jsonls")
vim.lsp.enable("lemminx")
vim.lsp.enable("lua_ls")
vim.lsp.enable("remark_ls")
vim.lsp.enable("somesass_ls")
vim.lsp.enable("taplo")
vim.lsp.enable("ts_ls")
vim.lsp.enable("twiggy_language_server")
vim.lsp.enable("volar")
vim.lsp.enable("yamlls")

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("my.lsp", {}),
    callback = function(args)
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
        vim.notify("LSP started for " .. client.name, vim.log.levels.INFO, { title = "LSP" })

        local keymap = vim.keymap
        local opts = { noremap = true, silent = true }
        opts.buffer = args.buf
        opts.desc = "Show LSP references"

        opts.desc = "Show LSP references"
        keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

        -- Enable auto-completion. Note: Use CTRL-Y to select an item. |complete_CTRL-Y|
        if client:supports_method("textDocument/completion") then
            -- Optional: trigger autocompletion on EVERY keypress. May be slow!
            -- local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
            -- client.server_capabilities.completionProvider.triggerCharacters = chars
            vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
        end

        if client:supports_method("textDocument/references") then
            opts.desc = "Show LSP references"
            keymap.set("n", "grr", vim.lsp.buf.references, opts) -- go to declaration
            keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references
        end

        if client:supports_method("textDocument/definition") then
            opts.desc = "Go to definition"
            keymap.set("n", "grd", vim.lsp.buf.definition, opts) -- go to declaration
            keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions
        end

        if client:supports_method("textDocument/declaration") then
            opts.desc = "Go to declaration"
            keymap.set("n", "grD", vim.lsp.buf.declaration, opts) -- go to declaration
        end
        if client:supports_method("textDocument/implementation") then
            opts.desc = "Show LSP implementations"
            keymap.set("n", "gri", vim.lsp.buf.implementation, opts)
            keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations
        end

        if client:supports_method("textDocument/typeDefinition*") then
            opts.desc = "Show LSP type definitions"
            keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions
        end

        if client:supports_method("textDocument/rename") then
            opts.desc = "Smart rename"
            keymap.set("n", "<leader>cr", vim.lsp.buf.rename, opts) -- smart rename
            keymap.set("n", "grn", vim.lsp.buf.rename, opts) -- smart rename
        end

        if client:supports_method("textDocument/codeAction") then
            opts.desc = "See available code actions"
            keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection
            keymap.set({ "n", "v" }, "gra", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection
        end
        if client.server_capabilities.documentSymbolProvider then
          local navic = require("nvim-navic")
          navic.attach(client, args.buf)
        end

        opts.desc = "Show buffer diagnostics"
        keymap.set("n", "<leader>cd", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

        opts.desc = "Show line diagnostics"
        keymap.set("n", "<leader>cD", vim.diagnostic.open_float, opts) -- show diagnostics for line

        opts.desc = "Go to previous diagnostic"
        keymap.set("n", "<S-F2>", function()
            vim.diagnostic.jump({ count = -1, float = true })
        end, opts) -- jump to previous diagnostic in buffer

        opts.desc = "Go to next diagnostic"
        keymap.set("n", "<F2>", function()
            vim.diagnostic.jump({ count = 1, float = true })
        end, opts) -- jump to next diagnostic in buffer

        opts.desc = "Go to previous diagnostic"
        keymap.set("n", "<leader>@", function()
            vim.diagnostic.jump({ count = -1, float = true })
        end, opts) -- jump to previous diagnostic in buffer

        opts.desc = "Go to next diagnostic"
        keymap.set("n", "<leader>2", function()
            vim.diagnostic.jump({ count = 1, float = true })
        end, opts) -- jump to next diagnostic in buffer

        opts.desc = "Show documentation for what is under cursor"
        keymap.set("n", "<F1>", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

        opts.desc = "Show documentation for what is under cursor"
        keymap.set("n", "<leader>1", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor
    end,
})
