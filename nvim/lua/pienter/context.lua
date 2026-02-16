-- Context management module
local M = {}

-- Get the project root directory (git root or current working directory)
local function get_project_root()
    -- Try to get git root first
    local git_root = vim.fn.system("git rev-parse --show-toplevel 2>/dev/null"):gsub("\n", "")
    if vim.v.shell_error == 0 and git_root ~= "" then
        return git_root
    end
    -- Fallback to current working directory
    return vim.fn.getcwd()
end

-- Get the context directory for current project
local function get_context_dir()
    return get_project_root() .. "/.context"
end

-- Ensure context directory exists
local function ensure_context_dir()
    local context_dir = get_context_dir()
    if vim.fn.isdirectory(context_dir) == 0 then
        vim.fn.mkdir(context_dir, "p")
    end
end

-- Get current context file path
local function get_current_context_file()
    local current_context = vim.b.current_context
    if not current_context then
        return nil
    end
    return get_context_dir() .. "/" .. current_context
end

-- Store current context in a project-local file
local function save_current_context(context_name)
    local project_root = get_project_root()
    local context_file = project_root .. "/.context/.current"
    local file = io.open(context_file, "w")
    if file then
        file:write(context_name)
        file:close()
    end
end

-- Load current context from project-local file
local function load_current_context()
    local project_root = get_project_root()
    local context_file = project_root .. "/.context/.current"
    if vim.fn.filereadable(context_file) == 1 then
        local file = io.open(context_file, "r")
        if file then
            local context = file:read("*l")
            file:close()
            return context
        end
    end
    return nil
end

-- List all available contexts for current project
function M.list_contexts()
    ensure_context_dir()
    local contexts = vim.fn.glob(get_context_dir() .. "/*", false, true)
    local context_names = {}
    for _, path in ipairs(contexts) do
        local name = vim.fn.fnamemodify(path, ":t")
        if name ~= ".current" then
            table.insert(context_names, name)
        end
    end
    return context_names
end

-- Select a context
function M.select_context()
    local contexts = M.list_contexts()
    if #contexts == 0 then
        vim.notify("No contexts found in project. Create one first.", vim.log.levels.WARN)
        return
    end

    vim.ui.select(contexts, {
        prompt = "Select context:",
        format_item = function(item)
            return item
        end,
    }, function(choice)
        if choice then
            vim.b.current_context = choice
            save_current_context(choice)
            vim.notify("Switched to context: " .. choice)
        end
    end)
end

-- Create new context
function M.create_context(name)
    if not name then
        vim.ui.input({
            prompt = "Enter new context name: ",
        }, function(input)
            if input then
                M.create_context(input)
            end
        end)
        return
    end

    ensure_context_dir()
    local context_file = get_context_dir() .. "/" .. name
    if vim.fn.filereadable(context_file) == 1 then
        vim.notify("Context already exists: " .. name, vim.log.levels.WARN)
        return
    end

    local file = io.open(context_file, "w")
    if file then
        file:close()
        vim.b.current_context = name
        save_current_context(name)
        vim.notify("Created and switched to context: " .. name)
    end
end

-- Add current buffer to context
function M.add_current_file()
    local context_file = get_current_context_file()
    if not context_file then
        vim.notify("No context selected", vim.log.levels.ERROR)
        return
    end

    local current_file = vim.fn.expand("%:p")
    if current_file == "" then
        vim.notify("No file in current buffer", vim.log.levels.ERROR)
        return
    end

    -- Read existing files
    local files = {}
    for line in io.lines(context_file) do
        files[line] = true
    end

    -- Add new file if not already present
    if not files[current_file] then
        local file = io.open(context_file, "a")
        if file then
            file:write(current_file .. "\n")
            file:close()
            vim.notify("Added file to context: " .. current_file)
        end
    else
        vim.notify("File already in context", vim.log.levels.INFO)
    end
end

-- Add all file-backed buffers in open windows to context
function M.add_open_window_files()
    local context_file = get_current_context_file()
    if not context_file then
        vim.notify("No context selected", vim.log.levels.ERROR)
        return
    end

    local files = {}
    for line in io.lines(context_file) do
        files[line] = true
    end

    local seen_buffers = {}
    local files_to_add = {}
    local open_file_count = 0

    for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        if not seen_buffers[buf] and vim.bo[buf].buftype == "" then
            seen_buffers[buf] = true

            local filepath = vim.api.nvim_buf_get_name(buf)
            if filepath ~= "" then
                filepath = vim.fn.fnamemodify(filepath, ":p")
                open_file_count = open_file_count + 1

                if not files[filepath] then
                    files[filepath] = true
                    table.insert(files_to_add, filepath)
                end
            end
        end
    end

    if #files_to_add == 0 then
        if open_file_count == 0 then
            vim.notify("No file-backed buffers in open windows", vim.log.levels.INFO)
        else
            vim.notify("All open window files are already in context", vim.log.levels.INFO)
        end
        return
    end

    local file = io.open(context_file, "a")
    if not file then
        vim.notify("Could not open context file for writing", vim.log.levels.ERROR)
        return
    end

    for _, filepath in ipairs(files_to_add) do
        file:write(filepath .. "\n")
    end
    file:close()

    vim.notify(
        string.format("Added %d of %d open file(s) to context", #files_to_add, open_file_count),
        vim.log.levels.INFO
    )
end

-- Remove file from context
function M.remove_file(filepath)
    local context_file = get_current_context_file()
    if not context_file then
        vim.notify("No context selected", vim.log.levels.ERROR)
        return
    end

    -- Read files and filter out the specified one
    local files = {}
    for line in io.lines(context_file) do
        if line ~= filepath then
            table.insert(files, line)
        end
    end

    -- Write back the filtered list
    local file = io.open(context_file, "w")
    if file then
        file:write(table.concat(files, "\n"))
        if #files > 0 then
            file:write("\n")
        end
        file:close()
        vim.notify("Removed file from context: " .. filepath)
    end
end

-- Select file to remove from context
function M.select_file_to_remove()
    local context_file = get_current_context_file()
    if not context_file then
        vim.notify("No context selected", vim.log.levels.ERROR)
        return
    end

    local files = {}
    for line in io.lines(context_file) do
        table.insert(files, line)
    end

    if #files == 0 then
        vim.notify("No files in current context", vim.log.levels.INFO)
        return
    end

    vim.ui.select(files, {
        prompt = "Select file to remove:",
        format_item = function(item)
            return vim.fn.fnamemodify(item, ":~")
        end,
    }, function(choice)
        if choice then
            M.remove_file(choice)
        end
    end)
end

-- Create buffer with context files
function M.create_context_buffer()
    local context_file = get_current_context_file()
    if not context_file then
        vim.notify("No context selected", vim.log.levels.ERROR)
        return
    end

    local files = {}
    for line in io.lines(context_file) do
        table.insert(files, line)
    end

    if #files == 0 then
        vim.notify("No files in current context", vim.log.levels.INFO)
        return
    end

    -- Create new buffer
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, files)

    -- Set buffer options
    vim.bo[buf].modifiable = false
    vim.bo[buf].buftype = "nofile"
    vim.bo[buf].bufhidden = "wipe"

    -- Create window
    local width = math.min(80, vim.o.columns - 4)
    local height = math.min(#files + 2, vim.o.lines - 4)
    local win = vim.api.nvim_open_win(buf, true, {
        relative = "editor",
        width = width,
        height = height,
        row = (vim.o.lines - height) / 2,
        col = (vim.o.columns - width) / 2,
        style = "minimal",
        border = "rounded",
    })

    -- Set keymaps for the buffer
    local opts = { noremap = true, silent = true, buffer = buf }
    vim.keymap.set("n", "q", ":close<CR>", opts)
    vim.keymap.set("n", "<ESC>", ":close<CR>", opts)
    vim.keymap.set("n", "<CR>", function()
        local line = vim.fn.getline(".")
        if vim.fn.filereadable(line) == 1 then
            vim.cmd("close")
            vim.cmd("edit " .. vim.fn.fnameescape(line))
        end
    end, opts)
    vim.keymap.set("n", "d", function()
        local line = vim.fn.getline(".")
        M.remove_file(line)
        -- Refresh the buffer
        vim.cmd("close")
        M.create_context_buffer()
    end, opts)
end

-- Copy contents of all files in context
function M.copy_context_contents()
    local context_file = get_current_context_file()
    if not context_file then
        vim.notify("No context selected", vim.log.levels.ERROR)
        return
    end

    local contents = {}
    for filepath in io.lines(context_file) do
        if vim.fn.filereadable(filepath) == 1 then
            table.insert(contents, "--- File: " .. filepath .. " ---")
            local file_contents = vim.fn.readfile(filepath)
            table.insert(contents, table.concat(file_contents, "\n"))
            table.insert(contents, "\n")
        end
    end

    if #contents == 0 then
        vim.notify("No readable files in context", vim.log.levels.WARN)
        return
    end

    local all_content = table.concat(contents, "\n")
    vim.fn.setreg("+", all_content)
    vim.notify("Copied contents of all context files to clipboard")
end

-- Auto-load context when entering a buffer
local function setup_autocommands()
    vim.api.nvim_create_autocmd({ "BufEnter" }, {
        callback = function()
            if not vim.b.current_context then
                vim.b.current_context = load_current_context()
            end
        end,
    })
end

local function create_context_with_prompt()
    vim.ui.input({
        prompt = "Enter new context name: ",
    }, function(input)
        if input and input ~= "" then
            M.create_context(input)
        end
    end)
end

-- Initialize
function M.setup()
    setup_autocommands()

    -- Set up commands
    vim.api.nvim_create_user_command("ContextSelect", M.select_context, {})
    vim.api.nvim_create_user_command("ContextCreate", function(opts)
        M.create_context(opts.args)
    end, { nargs = "?" })
    vim.api.nvim_create_user_command("ContextAddFile", M.add_current_file, {})
    vim.api.nvim_create_user_command("ContextAddWindowFiles", M.add_open_window_files, {})
    vim.api.nvim_create_user_command("ContextRemoveFile", M.select_file_to_remove, {})
    vim.api.nvim_create_user_command("ContextList", M.create_context_buffer, {})
    vim.api.nvim_create_user_command("ContextCopyContents", M.copy_context_contents, {})

    -- Context management key mappings
    local context_mappings = {
        {
            key = "<leader>ks",
            cmd = ":ContextSelect<CR>",
            desc = "Select from available contexts",
        },
        {
            key = "<leader>kn",
            cmd = create_context_with_prompt,
            desc = "Create a new context",
        },
        {
            key = "<leader>ka",
            cmd = ":ContextAddFile<CR>",
            desc = "Add current file to context",
        },
        {
            key = "<leader>kw",
            cmd = ":ContextAddWindowFiles<CR>",
            desc = "Add files from open windows to context",
        },
        {
            key = "<leader>kd",
            cmd = ":ContextRemoveFile<CR>",
            desc = "Remove file from context",
        },
        {
            key = "<leader>kv",
            cmd = ":ContextList<CR>",
            desc = "List files in current context",
        },
        {
            key = "<leader>ky",
            cmd = ":ContextCopyContents<CR>",
            desc = "Copy contents of all context files",
        },
    }

    -- Set up the mappings with descriptions
    for _, mapping in ipairs(context_mappings) do
        vim.keymap.set("n", mapping.key, mapping.cmd, {
            noremap = true,
            silent = true,
            desc = mapping.desc,
        })
    end
end

return M
