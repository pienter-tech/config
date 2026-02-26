local M = {}

---@param cwd string
---@param args string[]
---@return string[]|nil, string|nil
local function git_system(cwd, args)
    args = args or {}
    local cmd = { "git", "-c", "core.quotepath=false", "-C", cwd }
    vim.list_extend(cmd, args)
    local output = vim.fn.systemlist(cmd)
    if vim.v.shell_error ~= 0 then
        return nil, table.concat(output, "\n")
    end
    return output, nil
end

local function to_git_rel(path, cwd)
    if type(path) ~= "string" or path == "" then
        return nil
    end
    if cwd and path:sub(1, #cwd + 1) == cwd .. "/" then
        return path:sub(#cwd + 2)
    end
    return path
end

local function resolve_git_blob_path(item)
    if not (item and item.commit and item.cwd) then
        return nil
    end

    local candidates = {}
    local seen = {}

    local function add(path)
        local rel = to_git_rel(path, item.cwd)
        if rel and rel ~= "" and not seen[rel] then
            seen[rel] = true
            candidates[#candidates + 1] = rel
        end
    end

    add(item.file)
    if type(item.files) == "table" then
        for _, file in ipairs(item.files) do
            add(file)
        end
    end

    for _, rel in ipairs(candidates) do
        local _, err = git_system(item.cwd, { "cat-file", "-e", ("%s:%s"):format(item.commit, rel) })
        if not err then
            return rel
        end
    end

    return nil
end

local function open_git_file_revision(picker, item, action)
    item = item or picker:current()
    if not item then
        return
    end

    if not item.commit then
        vim.notify("No commit selected", vim.log.levels.WARN)
        return
    end

    if not item.cwd then
        vim.notify("Could not resolve git root for this item", vim.log.levels.ERROR)
        return
    end

    local rel = resolve_git_blob_path(item)
    if not rel then
        vim.notify("Could not resolve file path for selected revision", vim.log.levels.ERROR)
        return
    end

    local lines, err = git_system(item.cwd, { "show", ("%s:%s"):format(item.commit, rel) })
    if err then
        vim.notify(err, vim.log.levels.ERROR)
        return
    end
    if not lines then
        vim.notify("Could not load file contents for selected revision", vim.log.levels.ERROR)
        return
    end
    ---@cast lines string[]

    local cmd = (action and action.cmd) or "vsplit"

    picker:close()
    if picker.main and vim.api.nvim_win_is_valid(picker.main) then
        vim.api.nvim_set_current_win(picker.main)
    end

    if cmd == "split" then
        vim.cmd("split")
    elseif cmd == "tab" then
        vim.cmd("tabnew")
    else
        vim.cmd("vsplit")
    end

    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_win_set_buf(0, buf)

    vim.bo[buf].buflisted = false
    vim.bo[buf].buftype = "nofile"
    vim.bo[buf].bufhidden = "wipe"
    vim.bo[buf].swapfile = false
    vim.bo[buf].modifiable = true
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    vim.bo[buf].modifiable = false
    vim.bo[buf].readonly = true

    local ft = vim.filetype.match({ filename = rel })
    if ft then
        vim.bo[buf].filetype = ft
    end

    pcall(vim.api.nvim_buf_set_name, buf, ("%s@%s"):format(rel, item.commit))
    vim.api.nvim_win_set_cursor(0, { 1, 0 })
end

function M.open_file_history()
    require("snacks").picker.git_log_file({
        confirm = "open_git_file_revision_vsplit",
        actions = {
            open_git_file_revision = open_git_file_revision,
            open_git_file_revision_split = { action = "open_git_file_revision", cmd = "split" },
            open_git_file_revision_vsplit = { action = "open_git_file_revision", cmd = "vsplit" },
            open_git_file_revision_tab = { action = "open_git_file_revision", cmd = "tab" },
        },
        win = {
            input = {
                keys = {
                    ["<c-s>"] = {
                        "open_git_file_revision_split",
                        mode = { "i", "n" },
                        desc = "Open revision in split",
                    },
                    ["<c-v>"] = {
                        "open_git_file_revision_vsplit",
                        mode = { "i", "n" },
                        desc = "Open revision in vsplit",
                    },
                    ["<c-t>"] = {
                        "open_git_file_revision_tab",
                        mode = { "i", "n" },
                        desc = "Open revision in tab",
                    },
                },
            },
        },
    })
end

return M
