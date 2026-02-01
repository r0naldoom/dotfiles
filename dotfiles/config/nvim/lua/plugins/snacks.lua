return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,

    ---@type snacks.Config
    opts = {
      bigfile = { enabled = true },
      dashboard = { enabled = true },
      indent = { enabled = true },
      input = { enabled = true },
      notifier = { enabled = false },
      quickfile = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },

      picker = {
        enabled = true,
        layout = {
          preset = "ivy",
          cycle = false,
        },
        -- Ordena arquivos por frequência de uso
        matcher = {
          frecency = true,
        },
        -- Keymaps do picker
        win = {
          input = {
            keys = {
              -- ESC fecha o picker (em insert e normal mode)
              ["<Esc>"] = { "close", mode = { "n", "i" } },
              -- Scroll do preview com J/K/H/L
              ["J"] = { "preview_scroll_down", mode = { "i", "n" } },
              ["K"] = { "preview_scroll_up", mode = { "i", "n" } },
              ["H"] = { "preview_scroll_left", mode = { "i", "n" } },
              ["L"] = { "preview_scroll_right", mode = { "i", "n" } },
            },
          },
        },
        -- Mostra filename primeiro, depois o path
        formatters = {
          file = {
            filename_first = true,
            truncate = 80,
          },
        },
      },

      -- Image preview (requer terminal com suporte: Kitty, Ghostty, WezTerm)
      image = {
        enabled = true,
        doc = {
          inline = false,
          float = true,
          max_width = 80,
          max_height = 40,
        },
      },

      -- Posiciona imagem no canto superior direito
      styles = {
        snacks_image = {
          relative = "editor",
          col = -1,
        },
      },
    },
  },
}
