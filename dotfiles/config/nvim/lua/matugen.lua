-- Noctalia theme template for Neovim
-- This file is processed by Noctalia's template processor

local M = {}

M.colors = {
  base00 = "#190a0f",           -- Background
  base01 = "#21141a", -- Lighter bg
  base02 = "#291f26", -- Selection bg
  base03 = "#755761",           -- Comments
  base04 = "#49363d",   -- Dark fg
  base05 = "#d3cfcf",        -- Foreground
  base06 = "#808898", -- Light fg
  base07 = "#4c3946",    -- Lightest fg
  base08 = "#ff7359",             -- Red (errors)
  base09 = "#8fbaef",          -- Orange (warnings)
  base0A = "#e5b76f",         -- Yellow
  base0B = "#ef80bf",           -- Green (strings)
  base0C = "#0a5cc1", -- Cyan
  base0D = "#ef80bf",           -- Blue (functions)
  base0E = "#e5b76f",         -- Purple (keywords)
  base0F = "#a61a00",   -- Brown
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
