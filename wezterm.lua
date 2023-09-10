local wezterm = require("wezterm")

local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

local function get_appearance()
	if wezterm.gui then
		return wezterm.gui.get_appearance()
	end
	return "Dark"
end

local function get_color_scheme_by_appearance(appearance)
	if appearance:find("Dark") then
		return "One Dark (Gogh)"
	else
		return "One Light (Gogh)"
	end
end

config.send_composed_key_when_left_alt_is_pressed = true
config.send_composed_key_when_right_alt_is_pressed = false

config.color_scheme = get_color_scheme_by_appearance(get_appearance())
config.font = wezterm.font("JetBrains Mono", { weight = "DemiBold" })
config.font_size = 14

config.initial_rows = 60
config.initial_cols = 165

-- Fix for Stage Manager lag
config.window_background_opacity = 0.999

config.keys = {
	{
		key = "d",
		mods = "SUPER",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "w",
		mods = "CMD",
		action = wezterm.action.CloseCurrentPane({ confirm = true }),
	},
}

return config
