local wezterm = require("wezterm")

wezterm.on("user-var-changed", function(window, pane, name, value)
    wezterm.log_info("user-var-changed: " .. name .. " = " .. value)
	if name ~= "switch-workspace" then
		return
	end
    wezterm.log_info("switch-workspace: " .. value)
	window:toast_notification("switch-workspace", "before", nil, 4000)
end)

local function init(config)
	local projects = require("launch.projects")

	wezterm.on("show-workspaces", function(window, pane)
		window:perform_action(
			wezterm.action.InputSelector({
				action = wezterm.action_callback(function(inner_window, inner_pane, id, label)
					if not id and not label then
						wezterm.log_info("No project selected")
					else
                        wezterm.log_info(label .. " selected")
						inner_window:perform_action(
							wezterm.action.SwitchToWorkspace({
								name = label,
								spawn = {
									label = label,
									cwd = id,
									args = {
                                        os.getenv("SHELL"),
                                        "-c",
                                        "/opt/homebrew/bin/nvim ."
                                        -- 'printf "\033]1337;SetUserVar=%s=%s\007" switch-workspace `echo -n asp | base64`'
									}
								},
							}),
							inner_pane
						)
					end
				end),
				title = "Select a project: ",
				choices = projects,
				fuzzy = true,
				fuzzy_description = "Search project: ",
			}),
			pane
		)
	end)
end

return init
