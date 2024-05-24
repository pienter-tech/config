local wezterm = require("wezterm")
local actions = wezterm.action

local function keys(config)
config.keys = {
        {
            key = "P",
            mods = "SUPER",
            action = actions.ActivateCommandPalette,
        },
        {
            key = "L",
            mods = "SUPER",
            action = actions.ShowLauncher,
        },
        {
            key = "l",
            mods = "SUPER",
            action = actions.EmitEvent("show-workspaces"),
        }
    }
end

return keys
