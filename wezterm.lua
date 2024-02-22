-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.font = wezterm.font_with_fallback({
	"MonaspiceAr Nerd Font",
})
config.font_rules = {
	{
		intensity = "Bold",
		italic = true,
		font = wezterm.font({
			family = "MonaspiceRn Nerd Font",
			weight = "Bold",
			style = "Italic",
		}),
	},
	{
		intensity = "Normal",
		italic = true,
		font = wezterm.font({
			family = "MonaspiceRn Nerd Font",
			weight = "Regular",
			style = "Italic",
		}),
	},
	{
		intensity = "Half",
		italic = true,
		font = wezterm.font({
			family = "MonaspiceRn Nerd Font",
			weight = "Light",
			style = "Italic",
		}),
	},
}
config.color_scheme = "Sonokai (Gogh)"
config.use_fancy_tab_bar = false
config.enable_scroll_bar = false
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}
config.tab_bar_at_bottom = true

config.initial_rows = 60
config.initial_cols = 200

config.keys = {
	-- This will create a new split and run your default program inside it
	{
		key = "|",
		mods = "CTRL|SHIFT|ALT",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	-- This will create a new split and run your default program inside it
	{
		key = "_",
		mods = "CTRL|SHIFT|ALT",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
}

-- and finally, return the configuration to wezterm
return config
