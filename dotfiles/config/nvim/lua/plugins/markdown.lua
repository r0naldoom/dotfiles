-- Markdown configuration
-- Baseado em linkarzu/neobean

return {
  -- =========================================================================
  -- render-markdown.nvim - Renderiza markdown com ícones bonitos
  -- =========================================================================
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      bullet = {
        enabled = true,
      },
      checkbox = {
        enabled = true,
        position = "inline",
        unchecked = {
          icon = "   󰄱 ",
          highlight = "RenderMarkdownUnchecked",
        },
        checked = {
          icon = "   󰱒 ",
          highlight = "RenderMarkdownChecked",
        },
        -- Custom checkboxes
        custom = {
          todo = { raw = "[-]", rendered = "   󰥔 ", highlight = "RenderMarkdownTodo" },
          important = { raw = "[!]", rendered = "   󰀨 ", highlight = "DiagnosticWarn" },
          cancel = { raw = "[~]", rendered = "   󰜺 ", highlight = "RenderMarkdownError" },
        },
      },
      html = {
        enabled = true,
        comment = {
          conceal = false,
        },
      },
      link = {
        image = "󰥶 ",
        custom = {
          youtu = { pattern = "youtu%.be", icon = "󰗃 " },
          youtube = { pattern = "youtube%.com", icon = "󰗃 " },
          github = { pattern = "github%.com", icon = " " },
        },
      },
      heading = {
        sign = false,
        icons = { "󰎤 ", "󰎧 ", "󰎪 ", "󰎭 ", "󰎱 ", "󰎳 " },
        backgrounds = {},
      },
      code = {
        sign = false,
        width = "block",
        right_pad = 1,
      },
    },
  },

  -- =========================================================================
  -- markdown-preview.nvim - Preview no browser
  -- =========================================================================
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && npm install",
    keys = {
      { "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>", ft = "markdown", desc = "Markdown Preview" },
    },
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
      vim.g.mkdp_page_title = "${name}"
      -- Abre no browser padrão
      vim.g.mkdp_browser = ""
      -- Auto-close quando sai do buffer
      vim.g.mkdp_auto_close = 1
    end,
  },

  -- =========================================================================
  -- bullets.vim - Auto bullet lists
  -- =========================================================================
  {
    "bullets-vim/bullets.vim",
    ft = { "markdown", "text", "gitcommit" },
    init = function()
      vim.g.bullets_delete_last_bullet_if_empty = 2
      vim.g.bullets_enabled_file_types = { "markdown", "text", "gitcommit" }
      -- Continue checkboxes (not just plain bullets)
      vim.g.bullets_checkbox_markers = " x~!>"
      vim.g.bullets_checkbox_partials_toggle = 0
    end,
  },

  -- =========================================================================
  -- img-clip.nvim - Colar imagens do clipboard
  -- =========================================================================
  {
    "HakonHarnes/img-clip.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>pi", "<cmd>PasteImage<cr>", desc = "Paste image from clipboard" },
    },
    opts = {
      default = {
        -- Usa path relativo ao arquivo atual
        use_absolute_path = false,
        relative_to_current_file = true,

        -- Salva em pasta {nome-do-arquivo}-img/
        dir_path = function()
          return vim.fn.expand("%:t:r") .. "-img"
        end,

        -- Nome do arquivo: data-hora
        prompt_for_file_name = false,
        file_name = "%Y%m%d-%H%M%S",

        -- Converte para webp com qualidade 80%
        extension = "webp",
        process_cmd = "convert - -quality 80 webp:-",
      },
      filetypes = {
        markdown = {
          url_encode_path = true,
          template = "![${cursor}](./$FILE_PATH)",
        },
      },
    },
  },

  -- =========================================================================
  -- Keymaps para markdown
  -- =========================================================================
  {
    "folke/which-key.nvim",
    opts = function(_, opts)
      opts.spec = opts.spec or {}
      table.insert(opts.spec, {
        mode = "n",
        { "<leader>m", group = "markdown" },
      })
    end,
  },
}
