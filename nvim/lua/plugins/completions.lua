return {
    {
        "saghen/blink.cmp",
        enabled = true,
        dependencies = {
            "rafamadriz/friendly-snippets",
        },
        version = "*",
        init = function() end,
        config = function(_, opts)
            -- Add project snippet path if available
            if vim.g.project_snippet_path then
                if
                    opts.sources
                    and opts.sources.providers
                    and opts.sources.providers.snippets
                    and opts.sources.providers.snippets.opts
                then
                    table.insert(opts.sources.providers.snippets.opts.search_paths, vim.g.project_snippet_path)
                end
            end
            require("blink.cmp").setup(opts)
        end,
        opts = {
            signature = { enabled = true },
            appearance = {
                use_nvim_cmp_as_default = false,
                nerd_font_variant = "mono",
            },
            sources = {
                default = { "lsp", "path", "snippets", "buffer" },
                providers = {
                    snippets = {
                        opts = {
                            friendly_snippets = true,
                            search_paths = { vim.fn.stdpath("config") .. "/snippets" },
                        },
                    },
                    cmdline = {
                        min_keyword_length = 2,
                    },
                },
            },
            keymap = {
                preset = "none",
                ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
                ["<C-e>"] = { "hide" },
                ["<C-y>"] = { "select_and_accept" },

                ["<C-p>"] = { "select_prev", "snippet_backward", "fallback_to_mappings" },
                ["<C-n>"] = { "select_next", "snippet_forward", "fallback_to_mappings" },

                ["<C-b>"] = { "scroll_documentation_up", "fallback" },
                ["<C-f>"] = { "scroll_documentation_down", "fallback" },

                ["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
            },
            cmdline = {
                enabled = false,
                completion = { menu = { auto_show = true } },
                keymap = {
                    ["<CR>"] = { "accept_and_enter", "fallback" },
                },
            },
            completion = {
                menu = {
                    border = nil,
                    scrolloff = 1,
                    scrollbar = false,
                    draw = {
                        columns = {
                            { "kind_icon" },
                            { "label", "label_description", gap = 1 },
                            { "kind" },
                            { "source_name" },
                        },
                    },
                },
                documentation = {
                    window = {
                        border = nil,
                        scrollbar = false,
                        winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,EndOfBuffer:BlinkCmpDoc",
                    },
                    auto_show = true,
                    auto_show_delay_ms = 500,
                },
            },
        },
    },
}
