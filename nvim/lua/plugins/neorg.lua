return {}
-- return {
--     "nvim-neorg/neorg",
--     lazy = false,
--     version = "*",
--     dependencies = { "nvim-neorg/neorg-telescope" },
--     keys = {
--         { mode = "n", "<leader>ni", ":Neorg index<CR>", desc = "Go to index file of current workspace" },
--         { mode = "n", "<leader>nc", ":Neorg return<CR>", desc = "Go close neorg, and go back to code" },
--         { mode = "n", "<LocalLeader>ct", ":Neorg toggle-concealer<CR>", desc = "Toggle neorg concealer" },
--         { mode = "n", "<leader>njj", ":Neorg journal today<CR>", desc = "Open todays note" },
--         { mode = "n", "<leader>njt", ":Neorg journal today<CR>", desc = "Open todays note" },
--         { mode = "n", "<leader>njn", ":Neorg journal tomorrow<CR>", desc = "Open tomorrows note" },
--         { mode = "n", "<leader>njp", ":Neorg journal yesterday<CR>", desc = "Open yesterdays note" },
--         { mode = "n", "<LocalLeader>jt", ":Neorg journal toc<CR>", desc = "Update journal toc" },
--         { mode = "n", "<LocalLeader>il", ":Telescope neorg insert_link<CR>", desc = "Insert link" },
--         { mode = "n", "<LocalLeader>ff", ":Telescope neorg find_norg_files<CR>", desc = "Find norg files" },
--         { mode = "n", "<LocalLeader>it", ":Neorg toc<CR>", desc = "Show Table of Content for file" },
--         { mode = "n", "<LocalLeader>mi", ":Neorg inject-metadata<CR>", desc = "Insert metadata" },
--         { mode = "n", "<LocalLeader>mu", ":Neorg update-metadata<CR>", desc = "Update metadata" },
--     },
--     opts = {
--         load = {
--             ["core.journal"] = {
--                 strategy = "flat",
--             },
--             ["core.defaults"] = {},
--             ["core.export"] = {
--                 export_dir = "/Users/korneel/Library/Mobile Documents/com~apple~CloudDocs/Neorg/export",
--             },
--             ["core.export.markdown"] = {},
--             ["core.concealer"] = {
--                 icon_preset = "diamond",
--                 init_open_folds = "always",
--             },
--             ["core.integrations.telescope"] = {},
--             ["core.dirman"] = {
--                 config = {
--                     workspaces = {
--                         one = "/Users/korneel/Library/Mobile Documents/com~apple~CloudDocs/Neorg/one",
--                     },
--                     index = "index.norg",
--                     default_workspace = "one",
--                 },
--             },
--         },
--     },
-- }
