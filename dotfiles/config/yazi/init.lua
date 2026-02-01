-- ============================================
-- Yazi Configuration - init.lua
-- ============================================

-- Full border around panels
require("full-border"):setup()

-- Starship prompt integration
require("starship"):setup()

-- Git integration (for status line)
require("git"):setup()

-- ============================================
-- Bunny bookmarks configuration
-- ============================================
require("bunny"):setup({
  hops = {
    { key = "~", path = "~", desc = "Home" },
    { key = "d", path = "~/Downloads", desc = "Downloads" },
    { key = "D", path = "~/Desktop", desc = "Desktop" },
    { key = ".", path = "~/dotfiles", desc = "Dotfiles" },
    { key = "t", path = "/tmp", desc = "Temp" },
    { key = "/", path = "/", desc = "Root" },
  }
})

-- ============================================
-- Custom header showing current path
-- ============================================
Header:children_add(function()
  if ya.target_family() ~= "unix" then
    return ui.Line {}
  end
  return ui.Span(ya.user_name() .. "@" .. ya.host_name() .. ":"):fg("blue")
end, 500, Header.LEFT)

-- ============================================
-- Status line customization
-- ============================================
function Status:name()
  local h = self._tab.current.hovered
  if not h then
    return ui.Line {}
  end

  local linked = ""
  if h.link_to ~= nil then
    linked = " -> " .. tostring(h.link_to)
  end
  return ui.Line(" " .. h.name .. linked)
end
