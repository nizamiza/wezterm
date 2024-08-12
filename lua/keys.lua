local wezterm = require("wezterm")
local os = require("lua.os")

local ctrl = os.is_windows() and "CTRL" or "CMD"
local opt = os.is_windows() and "ALT" or "OPT"

-- base navigation keys
local keys = {
  {
    key = "d",
    mods = "SHIFT|" .. ctrl,
    action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
  },
  {
    key = "w",
    mods = "SHIFT|" .. ctrl,
    action = wezterm.action.CloseCurrentPane({ confirm = true }),
  },
  {
    key = "t",
    mods = ctrl,
    action = wezterm.action({ SpawnTab = "CurrentPaneDomain" }),
  },
  {
    key = "RightArrow",
    mods = "CTRL|SHIFT|" .. opt,
    action = wezterm.action.MoveTabRelative(1),
  },
  {
    key = "LeftArrow",
    mods = "CTRL|SHIFT|" .. opt,
    action = wezterm.action.MoveTabRelative(-1),
  },
  {
    key = "RightArrow",
    mods = "CTRL|" .. opt,
    action = wezterm.action.ActivateTabRelative(1),
  },
  {
    key = "LeftArrow",
    mods = "CTRL|" .. opt,
    action = wezterm.action.ActivateTabRelative(-1),
  },
  {
    key = "LeftArrow",
    mods = opt,
    action = wezterm.action({ SendString = "\x1bb" }),
  },
  {
    key = "RightArrow",
    mods = opt,
    action = wezterm.action({ SendString = "\x1bf" }),
  },
  {
    key = "Backspace",
    mods = "SHIFT",
    action = wezterm.action.SendKey({ key = "Backspace" }),
  },
  {
    key = "r",
    mods = "CTRL|SHIFT",
    action = wezterm.action.PromptInputLine({
      description = "Enter new name for the current tab",
      action = wezterm.action_callback(function(window, pane, line)
        -- line will be `nil` if they hit escape without entering anything
        -- An empty string if they just hit enter
        -- Or the actual line of text they wrote
        if line then
          window:active_tab():set_title(line)
        end
      end),
    }),
  },
}

-- insert tab navigation keys
for i = 1, 9 do
  table.insert(keys, {
    key = tostring(i),
    mods = "CTRL",
    action = wezterm.action.ActivateTab(i == 9 and -1 or i - 1),
  })
end

return keys
