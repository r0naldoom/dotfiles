-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua

---@param name string
local function augroup(name)
  return vim.api.nvim_create_augroup("custom_" .. name, { clear = true })
end

-- ============================================================================
--                           AUTOCMD DEFINITIONS
-- ============================================================================

local autocmds = {
  -- Auto spell para markdown/text/gitcommit
  {
    event = "FileType",
    group = "auto_spell",
    pattern = { "markdown", "text", "gitcommit", "plaintex" },
    callback = function()
      vim.opt_local.spell = true
      vim.opt_local.spelllang = { "pt_br", "en" }
    end,
  },

  -- Clear jumps ao iniciar (limpa histórico de navegação)
  {
    event = "BufWinEnter",
    group = "clear_jumps",
    once = true,
    callback = function()
      vim.schedule(function()
        vim.cmd("clearjumps")
      end)
    end,
  },

  -- Auto resize splits quando redimensiona janela
  {
    event = "VimResized",
    group = "resize_splits",
    callback = function()
      vim.cmd("tabdo wincmd =")
    end,
  },

  -- Highlight on yank (pisca o texto copiado)
  {
    event = "TextYankPost",
    group = "highlight_yank",
    callback = function()
      vim.highlight.on_yank({ timeout = 200 })
    end,
  },

  -- Volta para última posição no arquivo ao reabrir
  {
    event = "BufReadPost",
    group = "last_position",
    callback = function()
      local mark = vim.api.nvim_buf_get_mark(0, '"')
      local lcount = vim.api.nvim_buf_line_count(0)
      if mark[1] > 0 and mark[1] <= lcount then
        pcall(vim.api.nvim_win_set_cursor, 0, mark)
      end
    end,
  },

  -- Fecha alguns filetypes com <q>
  {
    event = "FileType",
    group = "close_with_q",
    pattern = { "help", "lspinfo", "notify", "qf", "checkhealth", "man", "gitcommit", "git" },
    callback = function(event)
      vim.bo[event.buf].buflisted = false
      vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
    end,
  },
}

-- ============================================================================
--                           REGISTER AUTOCMDS
-- ============================================================================

for _, autocmd in ipairs(autocmds) do
  vim.api.nvim_create_autocmd(autocmd.event, {
    group = augroup(autocmd.group),
    pattern = autocmd.pattern,
    once = autocmd.once,
    callback = autocmd.callback,
  })
end
