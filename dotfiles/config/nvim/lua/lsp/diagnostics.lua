-- LSP Diagnostics configuration
local M = {}

M.icons = {
  error = "󰅚 ",
  warn = "󰀪 ",
  info = "󰋽 ",
  hint = "󰌶 ",
}

M.config = {
  virtual_lines = false,
  virtual_text = false,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = "rounded",
    source = true,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = M.icons.error,
      [vim.diagnostic.severity.WARN] = M.icons.warn,
      [vim.diagnostic.severity.INFO] = M.icons.info,
      [vim.diagnostic.severity.HINT] = M.icons.hint,
    },
  },
}

return M
