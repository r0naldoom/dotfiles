-- Inicia servidor para receber comandos remotos (noctalia-theme-sync)
local socket_path = "/tmp/nvim-" .. vim.env.USER .. ".sock"
if not vim.loop.fs_stat(socket_path) then
  pcall(vim.fn.serverstart, socket_path)
end

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
