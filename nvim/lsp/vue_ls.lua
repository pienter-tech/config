local blink = require("blink.cmp")

---@brief
---
--- https://github.com/vuejs/language-tools/tree/master/packages/language-server
---
--- Volar language server for Vue
---
--- Volar can be installed via npm:
--- ```sh
--- npm install -g @vue/language-server
--- ```
---
--- Volar by default supports Vue 3 projects.
--- For Vue 2 projects, [additional configuration](https://github.com/vuejs/language-tools/blob/master/extensions/vscode/README.md?plain=1#L19) are required.
---
--- **Hybrid Mode (by default)**
---
--- In this mode, the Vue Language Server exclusively manages the CSS/HTML sections.
--- You need the `ts_ls` server with the `@vue/typescript-plugin` plugin to support TypeScript in `.vue` files.
--- See `ts_ls` section for more information
---
--- **No Hybrid Mode**
---
--- Volar will run embedded `ts_ls` therefore there is no need to run it separately.
--- ```lua
--- local lspconfig = require('lspconfig')
---
--- vim.lsp.config('volar', {
---   -- add filetypes for typescript, javascript and vue
---   filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
---   init_options = {
---     vue = {
---       -- disable hybrid mode
---       hybridMode = false,
---     },
---   },
--- })
--- -- you must remove "ts_ls" config
--- -- vim.lsp.config['ts_ls'] = {}
--- ```
---
--- **Overriding the default TypeScript Server used by Volar**
---
--- The default config looks for TypeScript in the local `node_modules`. This can lead to issues
--- e.g. when working on a [monorepo](https://monorepo.tools/). The alternatives are:
---
--- - use a global TypeScript Server installation
--- ```lua
--- vim.lsp.config('volar', {
---   init_options = {
---     typescript = {
---       -- replace with your global TypeScript library path
---       tsdk = '/path/to/node_modules/typescript/lib'
---     }
---   }
--- })
--- ```
---
--- - use a local server and fall back to a global TypeScript Server installation
--- ```lua
--- vim.lsp.config('volar', {
---   init_options = {
---     typescript = {
---       -- replace with your global TypeScript library path
---       tsdk = '/path/to/node_modules/typescript/lib'
---     }
---   },
---   before_init = function(params, config)
---     local lib_path = vim.fs.find('node_modules/typescript/lib', { path = new_root_dir, upward = true })[1]
---     if lib_path then
---       config.init_options.typescript.tsdk = lib_path
---     end
---   end
--- })
--- ```

-- local function get_typescript_server_path(root_dir)
--     local project_roots = vim.fs.find("node_modules", { path = root_dir, upward = true, limit = math.huge })
--     for _, project_root in ipairs(project_roots) do
--         local typescript_path = project_root .. "/typescript"
--         local stat = vim.loop.fs_stat(typescript_path)
--         if stat and stat.type == "directory" then
--             return typescript_path .. "/lib"
--         end
--     end
--     return ""
-- end
--
-- -- https://github.com/vuejs/language-tools/blob/master/packages/language-server/lib/types.ts
-- local volar_init_options = {
--     typescript = {
--         tsdk = "",
--     },
-- }
--
-- return {
--     cmd = { "vue-language-server", "--stdio" },
--     filetypes = { "vue" },
--     root_markers = { "package.json" },
--     init_options = volar_init_options,
--     before_init = function(_, config)
--         if config.init_options and config.init_options.typescript and config.init_options.typescript.tsdk == "" then
--             config.init_options.typescript.tsdk = get_typescript_server_path(config.root_dir)
--         end
--     end,
--     capabilities = vim.tbl_deep_extend(
--         "force",
--         {},
--         vim.lsp.protocol.make_client_capabilities(),
--         blink.get_lsp_capabilities()
--     ),
-- }
---@brief
---
--- https://github.com/vuejs/language-tools/tree/master/packages/language-server
---
--- The official language server for Vue
---
--- It can be installed via npm:
--- ```sh
--- npm install -g @vue/language-server
--- ```
---
--- The language server only supports Vue 3 projects by default.
--- For Vue 2 projects, [additional configuration](https://github.com/vuejs/language-tools/blob/master/extensions/vscode/README.md?plain=1#L19) are required.
---
--- The Vue language server works in "hybrid mode" that exclusively manages the CSS/HTML sections.
--- You need the `vtsls` server with the `@vue/typescript-plugin` plugin to support TypeScript in `.vue` files.
--- See `vtsls` section and https://github.com/vuejs/language-tools/wiki/Neovim for more information.
---
--- NOTE: Since v3.0.0, the Vue Language Server [no longer supports takeover mode](https://github.com/vuejs/language-tools/pull/5248).

---@type vim.lsp.Config
return {
    cmd = { "vue-language-server", "--stdio" },
    filetypes = { "vue" },
    root_markers = { "package.json" },
    capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        blink.get_lsp_capabilities()
    ),
    on_init = function(client)
        local retries = 0

        ---@param _ lsp.ResponseError
        ---@param result any
        ---@param context lsp.HandlerContext
        local function typescriptHandler(_, result, context)
            local ts_client = vim.lsp.get_clients({ bufnr = context.bufnr, name = "ts_ls" })[1]
                or vim.lsp.get_clients({ bufnr = context.bufnr, name = "vtsls" })[1]
                or vim.lsp.get_clients({ bufnr = context.bufnr, name = "typescript-tools" })[1]

            if not ts_client then
                -- there can sometimes be a short delay until `ts_ls`/`vtsls` are attached so we retry for a few times until it is ready
                if retries <= 10 then
                    retries = retries + 1
                    vim.defer_fn(function()
                        typescriptHandler(_, result, context)
                    end, 100)
                else
                    vim.notify(
                        "Could not find `ts_ls`, `vtsls`, or `typescript-tools` lsp client required by `vue_ls`.",
                        vim.log.levels.ERROR
                    )
                end
                return
            end

            local param = unpack(result)
            local id, command, payload = unpack(param)
            ts_client:exec_cmd({
                title = "vue_request_forward", -- You can give title anything as it's used to represent a command in the UI, `:h Client:exec_cmd`
                command = "typescript.tsserverRequest",
                arguments = {
                    command,
                    payload,
                },
            }, { bufnr = context.bufnr }, function(_, r)
                local response_data = { { id, r and r.body } }
                ---@diagnostic disable-next-line: param-type-mismatch
                client:notify("tsserver/response", response_data)
            end)
        end

        client.handlers["tsserver/request"] = typescriptHandler
    end,
}
