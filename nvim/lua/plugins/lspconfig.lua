return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            { "antosha417/nvim-lsp-file-operations", config = true },
            "williamboman/mason-lspconfig.nvim",
        },
        config = function()
            local keymap = vim.keymap
            local lspconfig = require("lspconfig")
            local mason_lspconfig = require("mason-lspconfig")
            local cmp_nvim_lsp = require("cmp_nvim_lsp")

            local default_caps = {
                workspace = {
                    didChangeWatchedFiles = {
                        dynamicRegistration = true,
                    },
                },
            }
            local capabilities = vim.tbl_deep_extend("keep", default_caps, cmp_nvim_lsp.default_capabilities())

            local flags = {
                debounce_text_changes = 150,
            }

            local function on_attach(client, bufnr)
                vim.notify("LSP started for " .. client.name, vim.log.levels.INFO, { title = "LSP" })
                local opts = { noremap = true, silent = true }

                opts.buffer = bufnr

                opts.desc = "Show LSP references"
                keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

                opts.desc = "Go to declaration"
                keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

                opts.desc = "Show LSP definitions"
                keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

                opts.desc = "Show LSP implementations"
                keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

                opts.desc = "Show LSP type definitions"
                keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

                opts.desc = "See available code actions"
                keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

                opts.desc = "Smart rename"
                keymap.set("n", "<leader>cr", vim.lsp.buf.rename, opts) -- smart rename

                opts.desc = "Show buffer diagnostics"
                keymap.set("n", "<leader>cd", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

                opts.desc = "Show line diagnostics"
                keymap.set("n", "<leader>cD", vim.diagnostic.open_float, opts) -- show diagnostics for line

                opts.desc = "Go to previous diagnostic"
                keymap.set("n", "<S-F2>", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

                opts.desc = "Go to next diagnostic"
                keymap.set("n", "<F2>", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

                opts.desc = "Show documentation for what is under cursor"
                keymap.set("n", "<F1>", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

                opts.desc = "Show LSP Info"
                keymap.set("n", "<leader>li", ":LspInfo<CR>", opts)

                opts.desc = "Restart LSP"
                keymap.set("n", "<leader>lr", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
            end

            mason_lspconfig.setup_handlers({
                function(server_name)
                    lspconfig[server_name].setup({
                        capabilities = capabilities,
                        flags = flags,
                        on_attach = on_attach,
                    })
                end,
                ["volar"] = function()
                    lspconfig.volar.setup({
                        capabilities = capabilities,
                        flags = flags,
                        on_attach = function(client, bufnr)
                            local active_clients = vim.lsp.get_active_clients()
                            for _, active_client in pairs(active_clients) do
                                if active_client.name == "tsserver" then
                                    active_client.stop()
                                    return
                                end
                            end

                            on_attach(client, bufnr)
                        end,
                        filetypes = {
                            "vue",
                            "typescript",
                            "javascript",
                        },
                        root_dir = lspconfig.util.root_pattern("src/App.vue"),
                    })
                end,
                ["tsserver"] = function()
                    lspconfig.tsserver.setup({
                        capabilities = capabilities,
                        flags = flags,
                        on_attach = function(client, bufnr)
                            local active_clients = vim.lsp.get_active_clients()
                            for _, active_client in pairs(active_clients) do
                                if active_client.name == "volar" then
                                    client.stop()
                                    return
                                end
                            end
                            on_attach(client, bufnr)
                        end,
                        filetypes = {
                            "javascript",
                            "javascriptreact",
                            "javascript.jsx",
                            "typescript",
                            "typescriptreact",
                            "typescript.tsx",
                            "vue",
                        },
                    })
                end,
                ["emmet_ls"] = function()
                    lspconfig.emmet_ls.setup({
                        capabilities = capabilities,
                        flags = flags,
                        on_attach = on_attach,
                        filetypes = {
                            "html",
                            "typescriptreact",
                            "javascriptreact",
                            "css",
                            "sass",
                            "scss",
                            "less",
                            "svelte",
                            "vue",
                        },
                    })
                end,
                ["intelephense"] = function()
                    lspconfig.intelephense.setup({
                        capabilities = capabilities,
                        flags = flags,
                        on_attach = function(client, bufnr)
                            local active_clients = vim.lsp.get_active_clients()
                            for _, active_client in pairs(active_clients) do
                                if active_client.name == "psalm" then
                                    client.stop()
                                    return
                                end
                            end
                            on_attach(client, bufnr)
                        end,
                        filetypes = {
                            "php",
                            "tpl",
                            "blade",
                        },
                    })
                end,
                ["psalm"] = function()
                    lspconfig.psalm.setup({
                        capabilities = capabilities,
                        flags = flags,
                        on_attach = function(client, bufnr)
                            local active_clients = vim.lsp.get_active_clients()
                            for _, active_client in pairs(active_clients) do
                                if active_client.name == "intelephense" then
                                    active_client.stop()
                                    return
                                end
                            end
                            on_attach(client, bufnr)
                        end,
                        filetypes = {
                            "php",
                            "tpl",
                            "blade",
                        },
                    })
                end,
                ["lua_ls"] = function()
                    lspconfig.lua_ls.setup({
                        capabilities = capabilities,
                        flags = flags,
                        on_attach = on_attach,
                        settings = {
                            Lua = {
                                runtime = {
                                    version = "LuaJIT",
                                },
                                diagnostics = {
                                    globals = { "vim" },
                                },
                                workspace = {
                                    library = {
                                        [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                                        [vim.fn.stdpath("config") .. "/lua"] = true,
                                    },
                                },
                            },
                        },
                    })
                end,
            })
        end,
    },
}
