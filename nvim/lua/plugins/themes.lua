return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = false,
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                flavour = "auto",
                background = {
                    light = "latte",
                    dark = "mocha",
                },
                term_colors = true,
                dim_inactive = {
                    enabled = true,
                    shade = "dark",
                    percentage = "0.05",
                },
                highlight_overrides = {
                    all = function(colors)
                        return {
                            LineNr = { fg = colors.lavender },
                            CursorLineNr = { fg = colors.mauve },
                            NeoCodeiumSuggestion = { fg = colors.teal },
                        }
                    end,
                },
            })
            vim.cmd.colorscheme("catppuccin")
        end,
    },
    {
        "f-person/auto-dark-mode.nvim",
        opts = {
            update_interval = 1000,
            set_dark_mode = function()
                vim.api.nvim_set_option_value("background", "dark", {})
            end,
            set_light_mode = function()
                vim.api.nvim_set_option_value("background", "light", {})
            end,
        },
    },
}
