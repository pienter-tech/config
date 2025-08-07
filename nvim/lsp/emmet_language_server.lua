local blink = require("blink.cmp")

---@brief
---
--- https://github.com/olrtg/emmet-language-server
---
--- Package can be installed via `npm`:
--- ```sh
--- npm install -g @olrtg/emmet-language-server
--- ```
return {
    cmd = { "emmet-language-server", "--stdio" },
    filetypes = {
        "astro",
        "css",
        "eruby",
        "html",
        "htmlangular",
        "htmldjango",
        "javascriptreact",
        "less",
        "pug",
        "sass",
        "scss",
        "svelte",
        "templ",
        "typescriptreact",
        "vue",
    },
    root_markers = { ".git" },
    init_options = {
        showSuggestionsAsSnippets = true,
    },
    capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        blink.get_lsp_capabilities()
    ),
}
