local wezterm = require("wezterm")

return {
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
	{
		key = "RightArrow",
		mods = "CTRL|ALT|SHIFT",
		action = wezterm.action.MoveTabRelative(1),
	},
	{
		key = "LeftArrow",
		mods = "CTRL|ALT|SHIFT",
		action = wezterm.action.MoveTabRelative(-1),
	},
	{
		key = "RightArrow",
		mods = "SHIFT|OPT",
		action = wezterm.action.ActivateTabRelative(1),
	},
	{
		key = "LeftArrow",
		mods = "SHIFT|OPT",
		action = wezterm.action.ActivateTabRelative(-1),
	},
	{
		key = "Backspace",
		mods = "SHIFT",
		action = wezterm.action.SendKey({ key = "Backspace" }),
	},
  {
    key = "r",
    mods = "CTRL|SHIFT",
    action = wezterm.action.PromptInputLine {
      description = "Enter new name for the current tab",
      action = wezterm.action_callback(function(window, pane, line)
        -- line will be `nil` if they hit escape without entering anything
        -- An empty string if they just hit enter
        -- Or the actual line of text they wrote
        if line then
          window:active_tab():set_title(line)
        end
      end),
    },
  },
}
