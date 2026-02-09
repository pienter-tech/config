local opt = vim.opt  -- Create a shorthand variable for vim.opt for easier access to options

-- EditorConfig plugin settings
vim.g.editorconfig = true  -- Enable EditorConfig plugin
vim.g.editorconfig_root_chdir = 1  -- Change directory to the project root when opening a file
vim.g.editorconfig_verbose = 1  -- Enable verbose mode for EditorConfig

-- File handling and saving behavior
opt.autowriteall = true  -- Automatically save files when changing focus
opt.autoread = true  -- Automatically reload files when changed externally
opt.confirm = true  -- Ask for confirmation before closing unsaved buffers

-- Completion menu settings
opt.completeopt = "menu,menuone,noselect"  -- Configure completion menu behavior: show menu even for single match, but don't auto-select

-- Cursor and line display
opt.cursorline = true  -- Highlight the current line
opt.nu = true  -- Show line numbers
opt.relativenumber = true  -- Show relative line numbers (current line is absolute)

-- Text formatting
opt.formatoptions = "jcroqlnt"  -- Control auto-formatting: join comments, auto-wrap comments, continue comments, etc.
opt.shiftround = true  -- Round indent to multiple of shiftwidth when using < and >

-- Search settings
opt.grepformat = "%f:%l:%c:%m"  -- Format for grep results (file:line:column:message)
opt.grepprg = "rg --vimgrep"  -- Use ripgrep for grep operations

-- Indentation settings
opt.smartindent = true  -- Enable smart auto-indenting
opt.tabstop = 2  -- Number of spaces a tab counts for
opt.shiftwidth = 2  -- Number of spaces for each step of auto-indent
opt.expandtab = true  -- Convert tabs to spaces

-- Text display
opt.wrap = false  -- Don't wrap long lines

-- Search behavior
opt.ignorecase = true  -- Ignore case in search patterns
opt.smartcase = true  -- Override ignorecase when pattern has uppercase
opt.hlsearch = true  -- Highlight all matches of search pattern
opt.incsearch = true  -- Show matches as you type

-- Visual settings
opt.termguicolors = true  -- Enable true color support
opt.scrolloff = 15  -- Minimum lines to keep above/below cursor when scrolling
opt.sidescrolloff = 10  -- Minimum columns to keep left/right of cursor when scrolling horizontally
opt.timeout = true  -- Enable timeout for key mappings
opt.timeoutlen = 300  -- Time in milliseconds to wait for a mapped sequence to complete
opt.colorcolumn = "0"  -- Disable vertical column highlight

-- System integration
opt.clipboard = "unnamedplus"  -- Use system clipboard for all operations

-- Session settings
opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"  -- What to save in sessions

-- Undo settings
opt.undofile = true  -- Enable persistent undo (save undo history between sessions)
opt.undolevels = 10000  -- Maximum number of changes that can be undone

-- Performance and responsiveness
opt.updatetime = 200  -- Milliseconds of inactivity before swap file is written and CursorHold event is triggered

-- Editing behavior
opt.virtualedit = "block"  -- Allow cursor to move where there is no text in visual block mode

-- Folding settings
opt.foldmethod = "indent"  -- Use indentation for code folding
opt.foldcolumn = "0"  -- Don't show fold indicators in the sign column
opt.foldtext = ""  -- Don't show fold text
opt.foldlevel = 99  -- Start with all folds open
opt.foldlevelstart = 99  -- Start with all folds open when opening new files
opt.foldnestmax = 20  -- Maximum fold nesting level

-- Diff settings
opt.diffopt:append("algorithm:patience")  -- Use patience algorithm for better diff quality
opt.diffopt:append("indent-heuristic")    -- Use indent heuristic to align diffs more intelligently
opt.diffopt:append("iwhite")              -- Ignore whitespace differences in diffs

-- Concealing text (for markdown, etc.)
vim.o.conceallevel = 2  -- Hide concealed text unless replacement character is defined

-- Netrw file explorer settings
vim.g.netrw_bufsettings = "noma nomod nonu nobl nowrap ro rnu"  -- Settings for netrw buffers

-- File type associations
vim.filetype.add({
    extension = {
        astro = "astro",  -- Associate .astro files with astro filetype
        mjml = "html",    -- Associate .mjml files with html filetype
        tpl = "html",     -- Associate .tpl files with html filetype
    },
})
