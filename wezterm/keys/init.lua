local wezterm = require("wezterm")
local actions = wezterm.action
local Helpers = require("helpers")

local direction_keys = {
	h = "Left",
	j = "Down",
	k = "Up",
	l = "Right",
}

local function split_nav(resize_or_move, key)
	return {
		key = key,
		mods = resize_or_move == "resize" and "META" or "CTRL",
		action = wezterm.action_callback(function(win, pane)
			if Helpers.is_vim(pane) then
				-- pass the keys through to vim/nvim
				win:perform_action({
					SendKey = { key = key, mods = resize_or_move == "resize" and "META" or "CTRL" },
				}, pane)
			else
				if resize_or_move == "resize" then
					win:perform_action({ AdjustPaneSize = { direction_keys[key], 3 } }, pane)
				else
					win:perform_action({ ActivatePaneDirection = direction_keys[key] }, pane)
				end
			end
		end),
	}
end

local function keys(config)
	wezterm.on("update-right-status", function(window, _)
		local name = window:active_key_table()
		if name then
			name = "TABLE: " .. name
		end
		window:set_right_status(name or "")
	end)

	wezterm.on("split-right", function(_, pane)
		pane:split({ direction = "Right", size = 0.25 })
	end)

	config.leader = { key = "§" }

	config.keys = {
		{ key = "w", mods = "LEADER", action = actions.ActivateKeyTable({ name = "windows" }) },
		{ key = "t", mods = "LEADER", action = actions.ActivateKeyTable({ name = "tabs" }) },
		{ key = "z", mods = "LEADER", action = actions.TogglePaneZoomState },
		{
			key = "P",
			mods = "SUPER",
			action = actions.ActivateCommandPalette,
		},
		{
			key = "p",
			mods = "SUPER",
			action = actions.ShowLauncher,
		},
		{
			key = "l",
			mods = "SUPER",
			action = actions.EmitEvent("show-workspaces"),
		},
		{
			key = "Tab",
			mods = "CTRL",
			action = actions.SwitchWorkspaceRelative(1),
		},
		{
			key = "Tab",
			mods = "CTRL|SHIFT",
			action = actions.SwitchWorkspaceRelative(1),
		},

		-- move between split panes
		split_nav("move", "h"),
		split_nav("move", "j"),
		split_nav("move", "k"),
		split_nav("move", "l"),
		-- resize panes
		split_nav("resize", "h"),
		split_nav("resize", "j"),
		split_nav("resize", "k"),
		split_nav("resize", "l"),
	}

	config.key_tables = {
		windows = {
			{ key = "w", action = actions.RotatePanes("CounterClockwise") },
			{ key = "W", action = actions.RotatePanes("Clockwise") },
			{ key = "h", action = actions.SplitPane({ direction = "Left" }) },
			{ key = "j", action = actions.SplitPane({ direction = "Down" }) },
			{ key = "k", action = actions.SplitPane({ direction = "Up" }) },
			{ key = "l", action = actions.SplitPane({ direction = "Right" }) },
			{ key = "s", action = actions.SplitPane({ direction = "Right", size = { Percent = 25 } }) },
			{ key = "c", action = wezterm.action.CloseCurrentPane({ confirm = false }) },
		},
		tabs = {
			{ key = "t", action = actions.ActivateLastTab },
			{ key = "c", action = actions.CloseCurrentTab({ confirm = true }) },
			{ key = "n", action = actions.SpawnTab("CurrentPaneDomain") },
		},
	}
end

return keys
