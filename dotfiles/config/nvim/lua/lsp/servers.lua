-- LSP Server configurations
local M = {}

-- Servidores para instalar via mason-lspconfig
M.ensure_installed = {
  "ruff",
  "lua_ls",
  "ts_ls",
  "html",
  "cssls",
  "jsonls",
  "yamlls",
  "bashls",
  "typos_lsp",
  "ltex",
}

-- Ferramentas extras via mason-tool-installer
M.tools = {
  "zuban",
}

-- Registra LSPs não oficiais (não estão no lspconfig)
function M.register_custom()
  local configs = require("lspconfig.configs")
  local util = require("lspconfig.util")

  if not configs.zuban then
    configs.zuban = {
      default_config = {
        cmd = { "zuban", "server" },
        filetypes = { "python" },
        root_dir = util.root_pattern(
          "pyproject.toml",
          "setup.py",
          "setup.cfg",
          "requirements.txt",
          ".git"
        ),
        single_file_support = true,
      },
    }
  end
end

-- Configurações individuais de cada servidor
M.configs = {
  -- Python
  zuban = {},
  ruff = {
    init_options = {
      settings = {
        lineLength = 100,
      },
    },
  },
  pyright = { enabled = false },
  basedpyright = { enabled = false },

  -- Lua
  lua_ls = {
    settings = {
      Lua = {
        runtime = { version = "LuaJIT" },
        diagnostics = { globals = { "vim" } },
        workspace = { checkThirdParty = false },
        telemetry = { enable = false },
      },
    },
  },

  -- Typos (spell checker para código)
  typos_lsp = {
    filetypes = {
      "python", "lua", "javascript", "typescript", "rust", "go", "c", "cpp",
      "java", "ruby", "php", "sh", "bash", "zsh", "fish", "vim",
      "json", "yaml", "toml", "html", "css", "scss",
    },
    init_options = {
      diagnosticSeverity = "Hint",
    },
  },

  -- LTeX (grammar checker PT-BR + EN)
  ltex = {
    filetypes = { "markdown", "text", "gitcommit", "latex", "tex" },
    settings = {
      ltex = {
        language = "pt-BR",
        java = {
          initialHeapSize = 64,
          maximumHeapSize = 512,
        },
        additionalRules = {
          enablePickyRules = true,
          motherTongue = "pt-BR",
        },
        dictionary = {
          ["pt-BR"] = vim.fn.readfile(vim.fn.stdpath("config") .. "/spell/pt.utf-8.add"),
          ["en-US"] = vim.fn.readfile(vim.fn.stdpath("config") .. "/spell/en.utf-8.add"),
        },
      },
    },
    cmd_env = {
      JAVA_OPTS = "-Djdk.xml.totalEntitySizeLimit=0",
    },
  },
}

return M
