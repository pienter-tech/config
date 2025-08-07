local blink = require("blink.cmp")

---@brief
---
--- https://intelephense.com/
--- https://raw.githubusercontent.com/neovim/nvim-lspconfig/refs/heads/master/lsp/intelephense.lua
---
--- `intelephense` can be installed via `npm`:
--- ```sh
--- npm install -g intelephense
--- ```
---
--- ```lua
--- -- See https://github.com/bmewburn/intelephense-docs/blob/master/installation.md#initialisation-options
--- init_options = {
---   storagePath = …, -- Optional absolute path to storage dir. Defaults to os.tmpdir().
---   globalStoragePath = …, -- Optional absolute path to a global storage dir. Defaults to os.homedir().
---   licenceKey = …, -- Optional licence key or absolute path to a text file containing the licence key.
---   clearCache = …, -- Optional flag to clear server state. State can also be cleared by deleting {storagePath}/intelephense
--- }
--- -- See https://github.com/bmewburn/intelephense-docs
--- settings = {
---   intelephense = {
---     files = {
---       maxSize = 1000000;
---     };
---   };
--- }
--- ```
---
local blink = require("blink.cmp")

local get_intelephense_license = function()
    local f = assert(io.open(os.getenv("HOME") .. "/dev/projects/pienter/config/.intelephense-license", "rb"))
    local content = f:read("*a")
    f:close()
    return string.gsub(content, "%s+", "")
end

return {
    cmd = { "intelephense", "--stdio" },
    filetypes = { "php" },
    init_options = {
        licenceKey = get_intelephense_license(),
    },
    settings = {},
    root_dir = function(bufnr, on_dir)
        local fname = vim.api.nvim_buf_get_name(bufnr)
        local cwd = assert(vim.uv.cwd())
        local root = vim.fs.root(fname, { "composer.json", ".git" })

        -- prefer cwd if root is a descendant
        on_dir(root and vim.fs.relpath(cwd, root) and cwd)
    end,
    capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        blink.get_lsp_capabilities()
    ),
}
