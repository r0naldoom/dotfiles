-- Noctalia theme template for Neovim
-- This file is processed by Noctalia's template processor

local M = {}

M.colors = {
  base00 = "{{colors.surface.default.hex}}",           -- Background
  base01 = "{{colors.surface_container_low.default.hex}}", -- Lighter bg
  base02 = "{{colors.surface_container.default.hex}}", -- Selection bg
  base03 = "{{colors.outline.default.hex}}",           -- Comments
  base04 = "{{colors.outline_variant.default.hex}}",   -- Dark fg
  base05 = "{{colors.on_surface.default.hex}}",        -- Foreground
  base06 = "{{colors.on_surface_variant.default.hex}}", -- Light fg
  base07 = "{{colors.surface_bright.default.hex}}",    -- Lightest fg
  base08 = "{{colors.error.default.hex}}",             -- Red (errors)
  base09 = "{{colors.tertiary.default.hex}}",          -- Orange (warnings)
  base0A = "{{colors.secondary.default.hex}}",         -- Yellow
  base0B = "{{colors.primary.default.hex}}",           -- Green (strings)
  base0C = "{{colors.tertiary_container.default.hex}}", -- Cyan
  base0D = "{{colors.primary.default.hex}}",           -- Blue (functions)
  base0E = "{{colors.secondary.default.hex}}",         -- Purple (keywords)
  base0F = "{{colors.error_container.default.hex}}",   -- Brown
}

function M.setup()
  local ok, base16 = pcall(require, 'base16-colorscheme')
  if ok then
    base16.setup(M.colors)
  end
end

-- Reload on SIGUSR1 signal from Noctalia
vim.loop.new_signal():start("sigusr1", function()
  vim.schedule(function()
    package.loaded['matugen'] = nil
    require('matugen').setup()
  end)
end)

return M
