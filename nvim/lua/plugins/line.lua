return {
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        dependencies = { "SmiteshP/nvim-navic", "nvim-tree/nvim-web-devicons", "yavorski/lualine-macro-recording.nvim" },
        opts = {
            options = {
                theme = "auto",
                globalstatus = true,
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "branch", "diff", "diagnostics" },
                lualine_c = { { "filename", file_status = true, path = 4 } },
                lualine_x = {
                    {
                        function()
                            return require("nvim-navic").get_location()
                        end,
                        cond = function()
                            return package.loaded["nvim-navic"] and require("nvim-navic").is_available()
                        end,
                    },
                    { "macro_recording", "%S" },
                    "overseer",
                },
                lualine_y = { "progress" },
                lualine_z = { "location" },
            },
        },
    },
    {
        "romgrk/barbar.nvim",
        event = "VeryLazy",
        dependencies = {
            "lewis6991/gitsigns.nvim",
            "nvim-tree/nvim-web-devicons",
        },
        keys = {
            {
                mode = "n",
                "<leader>bn",
                "<Cmd>enew | setlocal buftype=nofile bufhidden=hide noswapfile<CR>",
                desc = "Open new empty buffer",
            },
            {
                mode = "n",
                "<leader>b",
                desc = "Buffers",
            },
            {
                mode = "n",
                "<leader>bs",
                "<Cmd>BufferPick<CR>",
                desc = "Pick buffer",
            },
            {
                mode = "n",
                "<leader>bS",
                "<Cmd>BufferPickDelete<CR>",
                desc = "Pick buffer to delete",
            },
            {
                mode = "n",
                "<leader>bp",
                "<Cmd>BufferPin<CR>",
                desc = "Pin buffer",
            },
            {
                mode = "n",
                "<leader>boo",
                "<Cmd>BufferCloseAllButCurrent<CR>",
                desc = "Close all buffers except current",
            },
            {
                mode = "n",
                "<leader>bop",
                "<Cmd>BufferCloseAllButCurrentOrPinned<CR>",
                desc = "Close all buffers except current or pinned",
            },
            {
                mode = "n",
                "<leader>bop",
                "<Cmd>BufferCloseAllButCurrentOrPinned<CR>",
                desc = "Close all buffers except current or pinned",
            },
            {
                mode = "n",
                "<leader>bc",
                "<Cmd>BufferClose<CR>",
                desc = "Close buffer",
            },
            {
                mode = "n",
                "<leader>bh",
                "<Cmd>BufferNext<CR>",
                desc = "Go to buffer on left",
            },
            {
                mode = "n",
                "<leader>bl",
                "<Cmd>BufferPrevious<CR>",
                desc = "Go to buffer on right",
            },
        },
        init = function()
            vim.g.barbar_auto_setup = false
        end,
        opts = {
            animation = true,
            icons = {
                button = "",
                gitsigns = {
                    added = { enabled = true, icon = "+" },
                    changed = { enabled = true, icon = "~" },
                    deleted = { enabled = true, icon = "-" },
                },
                pinned = { button = "", filename = true },
            },
            exclude_ft = { "netrw" },
        },
    },
}
