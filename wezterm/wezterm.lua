local wezterm = require("wezterm")
local config = {}

config.color_scheme = "AtomOneLight"
config.default_prog = { "nu" }
config.font = wezterm.font_with_fallback({
	"Fira Code Retina",
	"FiraCode Nerd Font",
})
config.font_size = 11.5

return config
