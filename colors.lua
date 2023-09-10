local wezterm = require("wezterm")

local function get_appearance()
	return wezterm.gui and wezterm.gui.get_appearance() or "Dark"
end

local function is_dark_appearance()
	return get_appearance():find("Dark")
end

local function get_color_scheme()
	return is_dark_appearance() and "One Dark (Gogh)" or "One Light (Gogh)"
end

local function hsl(color)
	return "hsl(" .. color.h .. " " .. color.s .. "% " .. color.l .. "%)"
end

local function shift_hsl_color_lightness(color, delta)
	local is_dark = is_dark_appearance()
	local coeff = is_dark and 1 or -1

	return {
		h = color.h,
		s = color.s,
		l = color.l - delta * coeff,
	}
end

local function get_color_table()
	local is_dark = is_dark_appearance()

	local diff = is_dark and 0 or 100
	local coeff = is_dark and -1 or 1

	local function l(value)
		return (diff - value) * coeff
	end

	return {
		surface = {
			h = 220,
			s = 9,
			l = l(is_dark and 21 or 10),
		},
		text = {
			h = 0,
			s = 0,
			l = l(94),
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
