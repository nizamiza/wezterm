local wezterm = require("wezterm")
local colors = require("colors")
local keys = require("keys")

local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

wezterm.on("format-tab-title", function(tab)
	local current_dir = tab.active_pane.current_working_dir
	local i, j = current_dir:find("/[a-zA-Z _-0-9]+$")

	local current_folder = current_dir:sub(i + 1, j)
	local index = tab.tab_index + 1

	return index .. ": " .. current_folder
end)

local color = colors.get_color_table()

local inactive_tab = {
	bg_color = colors.hsl(color.surface),
	fg_color = colors.hsl(colors.shift_hsl_color_lightness(color.text, 35)),
}

local inactive_tab_hover = {
	bg_color = colors.hsl(colors.shift_hsl_color_lightness(color.surface, 3)),
	fg_color = colors.hsl(colors.shift_hsl_color_lightness(color.text, 15)),
}

config.send_composed_key_when_left_alt_is_pressed = true
config.send_composed_key_when_right_alt_is_pressed = false

config.color_scheme = colors.get_color_scheme()
config.font = wezterm.font("JetBrains Mono", { weight = "DemiBold" })
config.font_size = 14

config.initial_rows = 60
config.initial_cols = 165

-- Fix for Stage Manager lag
config.window_background_opacity = 0.999

config.keys = keys

config.window_frame = {
	font = wezterm.font("Helvetica Neue", { weight = "DemiBold" }),
	font_size = 12,
	active_titlebar_bg = colors.hsl(color.surface),
	inactive_titlebar_bg = colors.hsl(color.surface),
}

config.colors = {
	tab_bar = {
		active_tab = {
			bg_color = colors.hsl(colors.shift_hsl_color_lightness(color.surface, 7)),
			fg_color = colors.hsl(color.text),
		},
		inactive_tab_edge = colors.hsl(colors.shift_hsl_color_lightness(color.text, 60)),
		inactive_tab = inactive_tab,
		inactive_tab_hover = inactive_tab_hover,
		new_tab = inactive_tab,
		new_tab_hover = inactive_tab_hover,
	},
}

return config
