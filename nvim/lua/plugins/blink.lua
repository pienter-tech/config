return {
    "saghen/blink.cmp",
    dependencies = {
        "rafamadriz/friendly-snippets",
        "nvim-tree/nvim-web-devicons",
        "ribru17/blink-cmp-spell",
        "alexandre-abrioux/blink-cmp-npm.nvim",
        "onsails/lspkind.nvim",
        "jdrupal-dev/css-vars.nvim",
    },
    enabled = false,
    version = "1.*",
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opt = {
        keymap = { preset = "default" },
        appearance = "mono",
        sources = {
            default = { "lsp", "path", "snippets", "buffer", "npm", "spell", "css_vars" },
        },
        completion = {
            meny = {
                draw = {
                    components = {
                        kind_icon = {
                            text = function(ctx)
                                local icon = ctx.kind_icon
                                if vim.tbl_contains({ "Path" }, ctx.source_name) then
                                    local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
                                    if dev_icon then
                                        icon = dev_icon
                                    end
                                else
                                    icon = require("lspkind").symbolic(ctx.kind, {
                                        mode = "symbol",
                                    })
                                end

                                return icon .. ctx.icon_gap
                            end,
                        },
                    },
                },
            },
            documentation = { auto_show = true, auto_show_delay_ms = 500 },
        },
        fuzzy = { implementation = "prefer_rust_with_warning" },
        opts_extend = { "sources.default" },
        providers = {
            css_vars = {
                name = "css-vars",
                module = "css-vars.blink",
                opts = {
                    search_extensions = { ".scss" },
                },
            },
            npm = {
                name = "npm",
                module = "blink-cmp-npm",
                async = true,
                score_offset = 100,
                -- optional - blink-cmp-npm config
                ---@module "blink-cmp-npm"
                ---@type blink-cmp-npm.Options
                opts = {
                    ignore = {},
                    only_semantic_versions = true,
                    only_latest_version = false,
                },
            },
            spell = {
                name = "Spell",
                module = "blink-cmp-spell",
                opts = {
                    -- EXAMPLE: Only enable source in `@spell` captures, and disable it
                    -- in `@nospell` captures.
                    enable_in_context = function()
                        local curpos = vim.api.nvim_win_get_cursor(0)
                        local captures = vim.treesitter.get_captures_at_pos(0, curpos[1] - 1, curpos[2] - 1)
                        local in_spell_capture = false
                        for _, cap in ipairs(captures) do
                            if cap.capture == "spell" then
                                in_spell_capture = true
                            elseif cap.capture == "nospell" then
                                return false
                            end
                        end
                        return in_spell_capture
                    end,
                },
            },
        },
    },
}
