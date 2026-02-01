-- UI utilities (winbar, statusline helpers)
local M = {}

--- Encurta path longo para exibição
---@param path string
---@return string
function M.shorten_path(path)
  local home = vim.fn.expand("$HOME")
  path = path:gsub(home, "~")

  local parts = {}
  for part in string.gmatch(path, "[^/]+") do
    table.insert(parts, part)
  end

  -- Se mais de 5 diretórios, encurta
  if #parts > 5 then
    return parts[1] .. "/../" .. parts[#parts - 1] .. "/" .. parts[#parts]
  end
  return path
end

--- Conta buffers listados
---@return integer
function M.get_buffer_count()
  return vim.fn.len(vim.fn.getbufinfo({ buflisted = 1 }))
end

--- Atualiza winbar com formato: (bufcount) filename  path
function M.update_winbar()
  local path = M.shorten_path(vim.fn.expand("%:p:h"))
  local bufcount = M.get_buffer_count()
  local filename = vim.fn.expand("%:t")

  if filename == "" then
    return
  end

  vim.opt.winbar = "%#Comment#(" .. bufcount .. ") %*%#Normal#" .. filename .. "%*%=%#Comment#" .. path .. "%*"
end

--- Configura autocmd para atualizar winbar
function M.setup_winbar()
  vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
    group = vim.api.nvim_create_augroup("custom_winbar", { clear = true }),
    callback = M.update_winbar,
  })
end

return M
