local wezterm = require("wezterm")

local function get_projects()
	local projects = require("launch.projects")
	local active_workspaces = wezterm.mux.get_workspace_names()

	for i = 1, #projects do
		for j = 1, #active_workspaces do
			if projects[i].label == active_workspaces[j] then
				projects[i].label = wezterm.format({
					{ Attribute = { Underline = "Single" } },
					{ Foreground = { AnsiColor = "Yellow" } },
					{ Text = "*" .. projects[i].label .. "*" },
				})
			end
		end
	end

	table.sort(projects, function(a, b)
		local a_active = string.match(a.label, "%*")
		local b_active = string.match(b.label, "%*")

        if a.active and not b_active then
            return true
        end

		return a.label < b.label
	end)

	return projects
end

local function init(config)
	wezterm.on("user-var-changed", function(window, pane, name, value)
		wezterm.log_info("user-var-changed: " .. name .. " = " .. value)
		if name ~= "switch-workspace" then
			return
		end
		wezterm.log_info("switch-workspace: " .. value)
		window:toast_notification("switch-workspace", "before", nil, 4000)
	end)

	wezterm.on("show-workspaces", function(window, pane)
		window:perform_action(
			wezterm.action.InputSelector({
				action = wezterm.action_callback(function(inner_window, inner_pane, id, label)
					if not id and not label then
						wezterm.log_info("No project selected")
					else
						local clean_label = string.gsub(label, "^.-%*", ""):gsub("%*.-$", "")
						wezterm.log_info(clean_label .. " selected")

						if label ~= clean_label then
							wezterm.log_info("active workspace")
							wezterm.mux.set_active_workspace(clean_label)
							return
						end

						inner_window:perform_action(
							wezterm.action.SwitchToWorkspace({
								name = clean_label,
								spawn = {
									cwd = id,
								},
							}),
							inner_pane
						)
					end
				end),
				title = "Select a project: ",
				choices = get_projects(),
				fuzzy_description = "Search project: ",
			}),
			pane
		)
	end)
end

return init
