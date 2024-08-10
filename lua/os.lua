local wezterm = require("wezterm")

local M = {}

function M.is_macos()
  return wezterm.target_triple:find("darwin") ~= nil
end

function M.is_windows()
  return wezterm.target_triple:find("windows") ~= nil
end

function M.is_linux()
  return wezterm.target_triple:find("linux") ~= nil
end

return M
