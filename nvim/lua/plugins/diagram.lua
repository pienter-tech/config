return {
    {
        "3rd/diagram.nvim",
        ft = { "markdown", "norg" },
        dependencies = {
            "3rd/image.nvim",
        },
        opts = function()
            return {
                integrations = {
                    require("diagram.integrations.markdown"),
                },
                events = {
                    render_buffer = { "BufWinEnter", "InsertLeave", "TextChanged" },
                    clear_buffer = { "BufLeave" },
                },
                renderer_options = {
                    mermaid = {
                        background = nil,
                        theme = "neutral",
                        scale = 2,
                    },
                },
            }
        end,
        keys = {
            {
                "<leader>dm",
                function()
                    require("diagram").show_diagram_hover()
                end,
                mode = "n",
                ft = { "markdown", "norg" },
                desc = "Show diagram at cursor",
            },
        },
    },
}
