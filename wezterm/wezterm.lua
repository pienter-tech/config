local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.enable_tab_bar = false

require("appearance")(config)

require("keys")(config)

require("launch")(config)

return config
