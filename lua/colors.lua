--- @alias Appearance "Light" | "Dark"
--- @alias Color { h: number, s: number, l: number }

local wezterm = require("wezterm")

--- @return Appearance
local function get_appearance()
	return wezterm.gui and wezterm.gui.get_appearance() or "Dark"
end

local function is_dark_appearance()
	return get_appearance():find("Dark") ~= nil
end

local function get_color_scheme()
  -- return is_dark_appearance() and "Modus-Vivendi" or "Modus-Operandi"
  return is_dark_appearance() and "Default (dark) (terminal.sexy)" or "One Light (Gogh)"
end

--- @param color Color
local function hsl(color)
	return "hsl(" .. color.h .. " " .. color.s .. "% " .. color.l .. "%)"
end

--- @param color Color
--- @param delta number
local function shift_hsl_color_lightness(color, delta)
	local coeff = is_dark_appearance() and 1 or -1

	return {
		h = color.h,
		s = color.s,
		l = color.l - delta * coeff,
	}
end

--- @return { surface: Color, text: Color, ssh: Color }
local function get_color_table()
	local function l(value)
		local coeff = is_dark_appearance() and -1 or 1
		local diff = is_dark_appearance() and 0 or 100
		return (diff - value) * coeff
	end

	return {
		surface = {
			h = 220,
			s = 9,
			l = l(is_dark_appearance() and 21 or 10),
		},
		text = {
			h = 0,
			s = 0,
			l = l(94),
		},
		ssh = {
			h = 338,
			s = 80,
			l = l(is_dark_appearance() and 32 or 28),
		},
	}
end

return {
	get_appearance = get_appearance,
	is_dark_appearance = is_dark_appearance,
	get_color_scheme = get_color_scheme,
	get_color_table = get_color_table,
	hsl = hsl,
	shift_hsl_color_lightness = shift_hsl_color_lightness,
}
