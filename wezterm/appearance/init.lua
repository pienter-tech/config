local function appearance(config)
    config.font_size = 14

    config.window_decorations = "RESIZE"

	config.color_scheme = "Arthur (Gogh)"

	config.use_fancy_tab_bar = false

	config.colors = {
		tab_bar = {
			background = "#262626",

			active_tab = {
				bg_color = "#1C1C1C",
				fg_color = "#E8AE5B",
				intensity = "Bold",
			},

			inactive_tab = {
				bg_color = "#262626",
				fg_color = "#BBAA99",
			},

			inactive_tab_hover = {
				bg_color = "#1C1C1C",
				fg_color = "#DDEEDD",
				intensity = "Bold",
			},

			new_tab = {
				bg_color = "#262626",
				fg_color = "#BBAA99",
			},

			new_tab_hover = {
				bg_color = "#1C1C1C",
				fg_color = "#DDEEDD",
				intensity = "Bold",
			},
		},
	}

	config.window_background_opacity = 9.8
end

return appearance
