vim.g.mapleader = " "
vim.g.maplocalleader = ","

local key = vim.keymap

-- Windows
key.set("n", "<leader>wo", "<C-w>o", { desc = "Close other windows" })
key.set("n", "<leader>ws", "<C-w>v<C-w>w", { desc = "Split window verticaly" })
key.set("n", "<leader>wc", "<C-w>c", { desc = "Close window (?)" })
key.set("n", "<leader>wt", function()
    vim.fn.system("wezterm cli split-pane --right --percent 25")
end, { desc = "Open terminal pane to right" })
key.set("n", "<leader>wz", function()
    vim.fn.system("wezterm cli zoom-pane --toggle")
end, { desc = "Toggle zoom state of wezterm pane" })
key.set("n", "<leader>ww", "<C-w>w", { desc = "Go to previous window" })
key.set("n", "<leader>wh", "<C-w>h", { desc = "Go to window on left" })
key.set("n", "<leader>wl", "<C-w>l", { desc = "Go to window on right" })
key.set("n", "<leader>wj", "<C-w>j", { desc = "Go to window on bottom" })
key.set("n", "<leader>wk", "<C-w>k", { desc = "Go to window on top" })
key.set("n", "<leader>w=", "<C-w>=", { desc = "Make windows equaly high en wide" })
key.set("n", "<leader>w-", "<C-w>< <C-w>< <C-w>< <C-w>< <C-w>< <C-w>< <C-w>< <C-w><", { desc = "Make window smaller" })
key.set("n", "<leader>w+", "<C-w>> <C-w>> <C-w>> <C-w>> <C-w>> <C-w>> <C-w>> <C-w>>", { desc = "Make window bigger" })
-- Tabs
key.set("n", "<leader>tn", ":tabnew<CR>", { desc = "Create new tab" })
key.set("n", "<leader>tt", ":tabnext #<CR>", { desc = "Go to previous tab" })
key.set("n", "<leader>th", ":tabnext -<CR>", { desc = "Go to tab on the left" })
key.set("n", "<leader>tl", ":tabnext +<CR>", { desc = "Go to tab on the right" })
key.set("n", "<leader>tc", ":tabclose<CR>", { desc = "Close current tab" })
key.set("n", "<leader>to", ":tabonly<CR>", { desc = "Close all tabs except the current one" })

-- Clear search highlights
key.set("n", "<leader>/", ":nohlsearch<CR>", { desc = "Stop highlighting for the search" })
-- Run macro q
key.set("n", "<leader>q", "@q", { desc = "@q (start/stop/run macro q)" })

key.set("i", "<C-a>", "<ESC><S-a>", { desc = "Move cursor to end of line in insert mode" })
key.set("i", "<C-i>", "<ESC><S-i>", { desc = "Move cursor to start of line in insert mode" })

key.set("v", "p", '"_dP', { desc = "Replace currently selected text without yanking" })

key.set("n", "<leader>hc", ":helpclose<CR>", { desc = "Close help window" })

key.set("n", "zl0", ":setlocal foldlevel=0<CR>", { desc = "Fold all level 0 folds" })
key.set("n", "zl1", ":setlocal foldlevel=1<CR>", { desc = "Fold all level 1 folds" })
key.set("n", "zl2", ":setlocal foldlevel=2<CR>", { desc = "Fold all level 2 folds" })
key.set("n", "zl3", ":setlocal foldlevel=3<CR>", { desc = "Fold all level 3 folds" })

key.set(
    "n",
    "<leader>r",
    [[:silent !osascript -e 'tell application "Google Chrome Dev" to reload active tab of window 1'<CR>]],
    { noremap = true, silent = true, desc = "Refresh active chrome tab" }
)

key.set("n", "<leader>Ma", function()
    -- AppleScript lines
    local script_lines = {
        'tell application "Mail"',
        "  try",
        "    set theMessage to item 1 of (get selection)",
        "    set theID to message id of theMessage",
        "  end try",
        "end tell",
        'return "message://<" & theID & ">"',
    }

    -- build the osascript command with multiple -e flags
    local parts = { "osascript" }
    for _, line in ipairs(script_lines) do
        table.insert(parts, "-e")
        table.insert(parts, vim.fn.shellescape(line))
    end
    local cmd = table.concat(parts, " ")
    local handle = io.popen(cmd)

    if not handle then
        vim.notify("Failed to run Mail script", vim.log.levels.ERROR)
        return
    end

    local url = handle:read("*a")
    handle:close()

    url = url:gsub("%s+$", "")

    if url == "" then
        vim.notify("No message selected in Mail.app", vim.log.levels.WARN)
        return
    end

    local link = string.format("[%s](%s)", "mail", url)
    vim.api.nvim_put({ link }, "c", true, true)
end, { noremap = true, silent = true })
