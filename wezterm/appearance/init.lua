local wezterm = require("wezterm")

local function format_window_title()
	wezterm.on("format-window-title", function(tab, _, tabs)
		local window_id = tab.window_id
		local window = wezterm.mux.get_window(window_id)
		local workspace = window:get_workspace()

		local zoomed = ""
		if tab.active_pane.is_zoomed then
			zoomed = "[Z] "
		end

		local index = ""
		if #tabs > 1 then
			index = string.format("[%d/%d] ", tab.tab_index + 1, #tabs)
		end

		return workspace .. " | " .. zoomed .. index .. tab.active_pane.title
	end)
end

local function scheme_for_appearance()
    local cur_appearance = 'DarkNotFound'

    if (wezterm.gui) then
        cur_appearance = wezterm.gui.get_appearance()
    end

	if cur_appearance:find("Dark") then
		return "Catppuccin Frappe"
	else
		return "Catppuccin Latte"
	end
end

local function appearance(config)
	config.font_size = 14

	config.color_scheme = scheme_for_appearance()

    config.enable_tab_bar = true
	config.use_fancy_tab_bar = false

	config.window_background_opacity = 9.8

    config.inactive_pane_hsb = {
        saturation = 0.5,
        brightness = 0.7,
    }

	format_window_title()
end

return appearance
