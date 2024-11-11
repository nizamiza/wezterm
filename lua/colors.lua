--- @alias Appearance "Light" | "Dark"
--- @alias Color { h: number, s: number, l: number }

local wezterm = require("wezterm")

local M = {}

--- @return Appearance
function M.get_appearance()
  return "Dark"
  -- return wezterm.gui and wezterm.gui.get_appearance() or "Dark"
end

function M.is_dark_appearance()
  return M.get_appearance():find("Dark") ~= nil
end

function M.get_color_scheme()
  -- return is_dark_appearance() and "Modus-Vivendi" or "Modus-Operandi"
  return M.is_dark_appearance() and "Default (dark) (terminal.sexy)" or "One Light (Gogh)"
end

--- @param color Color
function M.hsl(color)
  return "hsl(" .. color.h .. " " .. color.s .. "% " .. color.l .. "%)"
end

--- @param color Color
--- @param delta number
function M.shift_hsl_color_lightness(color, delta)
  local coeff = M.is_dark_appearance() and 1 or -1

  return {
    h = color.h,
    s = color.s,
    l = color.l - delta * coeff,
  }
end

--- @return { surface: Color, text: Color, ssh: Color }
function M.get_color_table()
  local function l(value)
    local coeff = M.is_dark_appearance() and -1 or 1
    local diff = M.is_dark_appearance() and 0 or 100
    return (diff - value) * coeff
  end

  return {
    surface = {
      h = 220,
      s = 9,
      l = l(M.is_dark_appearance() and 21 or 10),
    },
    text = {
      h = 0,
      s = 0,
      l = l(94),
    },
    ssh = {
      h = 338,
      s = 80,
      l = l(M.is_dark_appearance() and 32 or 28),
    },
  }
end

return M
