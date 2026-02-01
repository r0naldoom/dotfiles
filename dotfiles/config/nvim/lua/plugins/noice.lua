return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      presets = {
        bottom_search = false,
        command_palette = false,
        long_message_to_split = false,
        inc_rename = false,
        lsp_doc_border = true,
      },

      cmdline = {
        view = "cmdline",
        format = {
          -- conceal: (default=true) This will hide the text in the cmdline that matches the pattern.
          -- view: (default is cmdline view)
          -- opts: any options passed to the view
          -- icon_hl_group: optional hl_group for the icon
          -- title: set to anything or empty string to hide
          cmdline = { pattern = "^:", icon = "", lang = "vim" },
          search_down = { kind = "search", pattern = "^/", icon = "  ", lang = "regex" },
          search_up = { kind = "search", pattern = "^%?", icon = "  ", lang = "regex" },
          filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
          lua = {
            pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" },
            icon = "",
            lang = "lua",
          },
          help = { pattern = "^:%s*he?l?p?%s+", icon = "?" },
          input = {}, -- Used by input()
          -- lua = false, -- to disable a format, set to `false`
        },
      },

      messages = {
        enabled = true, -- enables the Noice messages UI
        view = "mini", -- default view for messages
        view_error = "mini", -- view for errors
        view_warn = "mini", -- view for warnings
        view_history = "mini", -- view for :messages
        view_search = "mini", -- view for search count messages. Set to `false` to disable
      },
      notify = {
        enabled = true,
        view = "mini",
      },
      lsp = {
        progress = {
          enabled = false, -- Desabilitar progress para evitar erro com Roslyn
        },
        message = {
          enabled = true,
          view = "mini",
        },
      },
      -- Mini view config (estava fora do opts - bug corrigido)
      mini = {
        timeout = vim.g.neovim_mode == "skitty" and 2000 or 5000,
        align = "center",
        position = {
          row = "95%",
          col = "100%",
        },
      },
    },
  },
}
