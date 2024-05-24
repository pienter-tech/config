local wezterm = require("wezterm")

local config = wezterm.config_builder()

require("appearance")(config)

require("keys")(config)

require("launch")(config)

return config
