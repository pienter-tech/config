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

-- Buffers
key.set("n", "<leader>b", "", {
    desc = "Buffers",
})
key.set("n", "<leader>bc", "<Cmd>bd<CR>", {
    desc = "Close buffer",
})
key.set("n", "<leader>bn", "<Cmd>enew | setlocal buftype=nofile bufhidden=hide noswapfile<CR>", {
    desc = "Open new empty buffer",
})

key.set("n", "<leader>bo", "", { desc = "Close multiple buffers" })

key.set("n", "<leader>boo", function()
    local closed_count = 0
    local win_bufs = {}
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        win_bufs[buf] = true
    end

    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if not win_bufs[buf] then
            vim.api.nvim_buf_delete(buf, { force = false })
            closed_count = closed_count + 1
        end
    end

    if closed_count > 0 then
        vim.notify(string.format("%d buffer(s) closed", closed_count), vim.log.levels.INFO)
    else
        vim.notify("No buffers to close", vim.log.levels.INFO)
    end
end, { desc = "Close all other buffers except those visible in windows" })

key.set("n", "<leader>bof", function()
    local closed_count = 0
    local cur = vim.api.nvim_get_current_buf()
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if buf ~= cur then
            vim.api.nvim_buf_delete(buf, { force = false })
            closed_count = closed_count + 1
        end
    end

    if closed_count > 0 then
        vim.notify(string.format("%d buffer(s) closed", closed_count), vim.log.levels.INFO)
    else
        vim.notify("No buffers to close", vim.log.levels.INFO)
    end
end, { desc = "Close all other buffers even if the buffer is open" })

key.set("n", "<leader>bom", function()
    local closed_count = 0
    local cur = vim.api.nvim_get_current_buf()
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if buf == cur or not vim.api.nvim_buf_is_loaded(buf) then
            goto continue
        end

        local marks = vim.fn.getmarklist(buf)
        if #marks > 0 then
            goto continue
        end

        vim.api.nvim_buf_delete(buf, { force = false })
        closed_count = closed_count + 1

        ::continue::
    end

    if closed_count > 0 then
        vim.notify(string.format("%d buffer(s) closed", closed_count), vim.log.levels.INFO)
    else
        vim.notify("No buffers to close", vim.log.levels.INFO)
    end
end, { desc = "Close all other buffers without a mark" })
