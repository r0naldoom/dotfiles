-- Options are automatically loaded before lazy.nvim startup
-- Default options: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

-- LSP Server to use for Python
vim.g.lazyvim_python_lsp = "basedpyright"
vim.g.lazyvim_python_ruff = "ruff"
vim.g.lazyvim_rust_diagnostics = "rust-analyzer"

-- Spell checking (en + pt-BR)
vim.opt.spelllang = { "en", "pt_br" }
vim.opt.spell = false -- habilitado por autocmd em markdown
vim.opt.spellfile = vim.fn.stdpath("config") .. "/spell/en.utf-8.add"

-- Text width e visual guide
vim.opt.textwidth = 80
vim.opt.colorcolumn = "80"
vim.opt.wrap = true
vim.opt.linebreak = true -- quebra em palavras, não no meio

-- Diagnostics hover mais rápido
vim.o.updatetime = 200

-- Mostra todos símbolos markdown (não esconde com conceal)
vim.opt.conceallevel = 0

-- Desabilita animações do snacks (mais rápido)
vim.g.snacks_animate = false

-- Salva spell language na sessão
vim.opt.sessionoptions = {
  "buffers",
  "curdir",
  "tabpages",
  "winsize",
  "help",
  "globals",
  "skiprtp",
  "folds",
  "localoptions",
}

-- Winbar customizado
require("util.ui").setup_winbar()
