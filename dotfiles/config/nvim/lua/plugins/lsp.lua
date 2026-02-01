-- LSP Configuration with Mason
local servers = require("lsp.servers")
local diagnostics = require("lsp.diagnostics")

return {
  -- Mason: package manager
  {
    "mason-org/mason.nvim",
    opts = {
      registries = {
        "github:mason-org/mason-registry",
      },
      ui = {
        border = "rounded",
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    },
  },

  -- Mason-lspconfig: bridge between mason and lspconfig
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    opts = {
      ensure_installed = servers.ensure_installed,
      automatic_installation = true,
    },
  },

  -- Mason tool installer (ferramentas extras)
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "mason-org/mason.nvim" },
    opts = {
      ensure_installed = servers.tools,
      auto_update = true,
      run_on_start = true,
    },
  },

  -- LSPConfig
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
    },
    init = function()
      vim.diagnostic.config(diagnostics.config)
    end,
    opts = function(_, opts)
      -- Registra LSPs customizados
      servers.register_custom()

      -- Aplica configurações dos servidores
      opts.servers = vim.tbl_deep_extend("force", opts.servers or {}, servers.configs)

      -- Aplica configurações de diagnósticos
      opts.diagnostics = vim.tbl_deep_extend("force", opts.diagnostics or {}, diagnostics.config)

      return opts
    end,
  },
}
