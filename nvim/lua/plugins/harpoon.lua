return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    keys = {
        {
            "<leader>hm",
            function()
                require("harpoon"):list():append()
            end,
            desc = "Mark file with harpoon",
            mode = "n",
        },
        {
            "<leader>hn",
            function()
                require("harpoon"):list():next()
            end,
            desc = "Go to next harpoon item",
            mode = "n",
        },
        {
            "<leader>hp",
            function()
                require("harpoon"):list():prev()
            end,
            desc = "Go to prev harpoon item",
            mode = "n",
        },
        {
            "<leader>hv",
            function()
                local harpoon = require("harpoon")
                local conf = require("telescope.config").values
                local file_paths = {}
                for _, item in ipairs(harpoon:list().items) do
                    table.insert(file_paths, item.value)
                end

                require("telescope.pickers")
                    .new({}, {
                        prompt_title = "Harpoon",
                        finder = require("telescope.finders").new_table({
                            results = file_paths,
                        }),
                        previewer = conf.file_previewer({}),
                        sorter = conf.generic_sorter({}),
                    })
                    :find()
            end,
            desc = "Show harpoon menu",
            mode = "n",
        },
        {
            "<leader>h1",
            function()
                require("harpoon"):list():select(1)
            end,
            desc = "Go to harpoon file 1",
            mode = "n",
        },
        {
            "<leader>hd1",
            function()
                require("harpoon"):list():remove(1)
            end,
            desc = "Remove harpoon file 1",
            mode = "n",
        },
        {
            "<leader>h2",
            function()
                require("harpoon"):list():select(2)
            end,
            desc = "Go to harpoon file 2",
            mode = "n",
        },
        {
            "<leader>hd2",
            function()
                require("harpoon"):list():remove(2)
            end,
            desc = "Remove harpoon file 2",
            mode = "n",
        },
        {
            "<leader>h3",
            function()
                require("harpoon"):list():select(3)
            end,
            desc = "Go to harpoon file 3",
            mode = "n",
        },
        {
            "<leader>hd3",
            function()
                require("harpoon"):list():remove(3)
            end,
            desc = "Remove harpoon file 3",
            mode = "n",
        },
        {
            "<leader>h4",
            function()
                require("harpoon"):list():select(4)
            end,
            desc = "Go to harpoon file 4",
            mode = "n",
        },
        {
            "<leader>hd4",
            function()
                require("harpoon"):list():remove(4)
            end,
            desc = "Remove harpoon file 4",
            mode = "n",
        },
        {
            "<leader>hdd",
            function()
                require("harpoon"):list():clear()
            end,
            desc = "Clear harpoon list",
            mode = "n",
        }
    },
    opts = {},
}
