--- @param path string
local function get_path_last_segment(path)
	local i, j = path:find("/[a-zA-Z _-0-9]+$")
	return path:sub(i + 1, j)
end

return {
	format_tab_title = function(tab)
		local current_dir = tab.active_pane.current_working_dir
		local process_path = tab.active_pane.foreground_process_name

		local current_folder = get_path_last_segment(current_dir)
		local process_name = get_path_last_segment(process_path)

		local index = tab.tab_index + 1

		return index .. ": " .. "[" .. process_name .. "] " .. current_folder
	end,
}
