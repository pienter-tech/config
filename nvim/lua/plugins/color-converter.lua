return {
    "NTBBloodbath/color-converter.nvim",
    opts = {
      hsl_pattern = "hsl([h] [s]% [l]%)",
      hsla_pattern = "hsl([h] [s]% [l]% / [a])"
    },
    keys = {
        {
            "<leader>cC",
            mode = {"n", "v"},
            function()
                require("color-converter").pick()
            end,
            desc = "Color converter",
        },
    },
}
