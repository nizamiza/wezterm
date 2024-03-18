local wezterm = require("wezterm")

local colors = require("lua.colors")
local keys = require("lua.keys")

local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

local color = colors.get_color_table()

local inactive_tab = {
  bg_color = colors.hsl(color.surface),
  fg_color = colors.hsl(colors.shift_hsl_color_lightness(color.text, 35)),
}

local inactive_tab_hover = {
  bg_color = colors.hsl(colors.shift_hsl_color_lightness(color.surface, 3)),
  fg_color = colors.hsl(colors.shift_hsl_color_lightness(color.text, 15)),
}

config.audible_bell = "Disabled"

config.send_composed_key_when_left_alt_is_pressed = true
config.send_composed_key_when_right_alt_is_pressed = false

config.color_scheme = colors.get_color_scheme()
config.font = wezterm.font("JetBrainsMono Nerd Font", { weight = "DemiBold" })
config.font_size = 15

config.initial_rows = 60
config.initial_cols = 190

-- Fix for Stage Manager lag
config.window_background_opacity = 0.92
config.macos_window_background_blur = 40

config.keys = keys

-- Fancy tab bar config
-- config.window_frame = {
-- 	font = wezterm.font("Helvetica Neue", { weight = "DemiBold" }),
-- 	font_size = 12,
-- 	active_titlebar_bg = colors.hsl(color.surface),
-- 	inactive_titlebar_bg = colors.hsl(color.surface),
-- }

config.use_fancy_tab_bar = false
config.tab_max_width = 48

config.colors = {
  tab_bar = {
    background = colors.hsl(colors.shift_hsl_color_lightness(color.surface, 5)),
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
