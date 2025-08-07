local blink = require("blink.cmp")

---@brief
---
--- https://github.com/moetelo/twiggy
---
--- `twiggy-language-server` can be installed via `npm`:
--- ```sh
--- npm install -g twiggy-language-server
--- ```
return {
    cmd = { "twiggy-language-server", "--stdio" },
    filetypes = { "twig" },
    root_markers = { "composer.json", ".git" },
    capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        blink.get_lsp_capabilities()
    ),
}
