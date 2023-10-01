local colors = require("lua.colors")

--- @param path string
local function get_path_last_segment(path)
	local i, j = path:find("/[a-zA-Z _-0-9]+$")
	return path:sub(i + 1, j)
end

local default_pad = " "

--- @param value string
--- @param padding string|nil
local function pad(value, padding)
	padding = padding or default_pad
	return padding .. value .. padding
end

--- @param value string
--- @param max_length number|nil
--- @param suffix string|nil
local function limit_string(value, max_length, suffix)
	max_length = max_length or 48
	suffix = suffix or "..."

	if value:len() <= max_length then
		return value
	end

	return value:sub(0, max_length - suffix:len()) .. suffix
end

return {
	format_tab_title = function(tab, tabs, panes, config, hover, max_width)
		local current_dir = tab.active_pane.current_working_dir
		local process_path = tab.active_pane.foreground_process_name

		local current_folder = get_path_last_segment(current_dir)
		local process_name = get_path_last_segment(process_path)

		local index = tab.tab_index + 1

		local is_ssh = process_name == "ssh"

		local color = colors.get_color_table()
		local default_active_bg_color = config.colors.tab_bar.active_tab.bg_color
		local default_inactive_bg_color = config.colors.tab_bar.inactive_tab.bg_color

		local active_ssh_bg_color = colors.hsl(color.ssh)
		local inactive_ssh_bg_color = colors.hsl(colors.shift_hsl_color_lightness(color.ssh, 7))

		local is_active = tab.is_active
		local bg_color = is_ssh and (is_active and active_ssh_bg_color or inactive_ssh_bg_color)
			or (is_active and default_active_bg_color or default_inactive_bg_color)

		local default_active_fg_color = config.colors.tab_bar.active_tab.fg_color
		local default_inactive_fg_color = config.colors.tab_bar.inactive_tab.fg_color

		local ssh_fg_color = color.text

		local active_ssh_fg_color = colors.hsl(ssh_fg_color)
		local inactive_ssh_fg_color = colors.hsl(colors.shift_hsl_color_lightness(ssh_fg_color, 30))

		local fg_color = is_ssh and (is_active and active_ssh_fg_color or inactive_ssh_fg_color)
			or (is_active and default_active_fg_color or default_inactive_fg_color)

		local default_title = index .. ": " .. "[" .. process_name .. "] " .. current_folder

		local ssh_title = index .. ": " .. tab.window_title

		local title = is_ssh and ssh_title or default_title

		return {
			{
				Foreground = {
					Color = fg_color,
				},
			},
			{
				Background = {
					Color = bg_color,
				},
			},
			{
				Text = pad(limit_string(title, max_width - default_pad:len() * 2)),
			},
		}
	end,
}
