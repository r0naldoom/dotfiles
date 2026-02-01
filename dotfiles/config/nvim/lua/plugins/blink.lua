-- Blink.cmp configuration
-- Trigger ";" para snippets (baseado em linkarzu/neobean)

local trigger_text = ";"

return {
  -- Snippets collection
  {
    "rafamadriz/friendly-snippets",
    lazy = true,
  },

  -- Emoji source for blink
  {
    "moyiz/blink-emoji.nvim",
    lazy = true,
  },

  -- Dictionary source for blink
  {
    "Kaiser-Yang/blink-cmp-dictionary",
    lazy = true,
  },

  -- Blink completion
  {
    "saghen/blink.cmp",
    lazy = false, -- Carrega antes do LSP para registrar capabilities
    dependencies = {
      "rafamadriz/friendly-snippets",
      "moyiz/blink-emoji.nvim",
      "Kaiser-Yang/blink-cmp-dictionary",
    },

    opts = function(_, opts)
      -- Disable blink in certain filetypes
      opts.enabled = function()
        local ft = vim.bo[0].filetype
        if ft == "TelescopePrompt" or ft == "minifiles" or ft == "snacks_picker_input" then
          return false
        end
        return true
      end

      -- Sources configuration
      opts.sources = vim.tbl_deep_extend("force", opts.sources or {}, {
        default = { "lsp", "path", "snippets", "buffer", "keywords", "emoji", "dictionary" },
        providers = {
          keywords = {
            name = "Keywords",
            module = "sources.blink-keywords",
            score_offset = 80,
            min_keyword_length = 2,
          },
          lsp = {
            name = "lsp",
            enabled = true,
            module = "blink.cmp.sources.lsp",
            score_offset = 90,
            min_keyword_length = 0,
          },
          path = {
            name = "Path",
            module = "blink.cmp.sources.path",
            score_offset = 25,
            fallbacks = { "snippets", "buffer" },
            opts = {
              trailing_slash = false,
              label_trailing_slash = true,
              get_cwd = function(context)
                return vim.fn.expand(("#%d:p:h"):format(context.bufnr))
              end,
              show_hidden_files_by_default = true,
            },
          },
          buffer = {
            name = "Buffer",
            enabled = true,
            max_items = 3,
            module = "blink.cmp.sources.buffer",
            min_keyword_length = 2,
            score_offset = 15,
          },
          snippets = {
            name = "snippets",
            enabled = true,
            max_items = 15,
            min_keyword_length = 2,
            module = "blink.cmp.sources.snippets",
            score_offset = 85,

            -- Only show snippets if I type ";" first
            -- Example: ";bash" shows bash snippet
            should_show_items = function()
              local col = vim.api.nvim_win_get_cursor(0)[2]
              local before_cursor = vim.api.nvim_get_current_line():sub(1, col)
              return before_cursor:match(trigger_text .. "%w*$") ~= nil
            end,

            -- Remove the ";" after accepting the snippet
            transform_items = function(_, items)
              local line = vim.api.nvim_get_current_line()
              local col = vim.api.nvim_win_get_cursor(0)[2]
              local before_cursor = line:sub(1, col)
              local start_pos, end_pos = before_cursor:find(trigger_text .. "[^" .. trigger_text .. "]*$")
              if start_pos then
                for _, item in ipairs(items) do
                  if not item.trigger_text_modified then
                    item.trigger_text_modified = true
                    item.textEdit = {
                      newText = item.insertText or item.label,
                      range = {
                        start = { line = vim.fn.line(".") - 1, character = start_pos - 1 },
                        ["end"] = { line = vim.fn.line(".") - 1, character = end_pos },
                      },
                    }
                  end
                end
              end
              return items
            end,
          },

          -- Emoji: digita :smile: para ver emojis
          emoji = {
            module = "blink-emoji",
            name = "Emoji",
            score_offset = 15,
            min_keyword_length = 2,
            opts = { insert = true },
          },

          -- Dictionary: autocomplete de palavras (apenas EN)
          -- Só aparece em markdown/text, não em código
          dictionary = {
            module = "blink-cmp-dictionary",
            name = "Dict",
            score_offset = 10,
            enabled = true,
            max_items = 8,
            min_keyword_length = 3,
            should_show_items = function()
              local ft = vim.bo.filetype
              return ft == "markdown" or ft == "text" or ft == "gitcommit"
            end,
            opts = {
              dictionary_directories = { vim.fn.stdpath("config") .. "/dictionaries" },
              dictionary_files = {
                vim.fn.stdpath("config") .. "/spell/en.utf-8.add",
              },
            },
          },
        },
      })

      -- Completion menu
      opts.completion = {
        list = {
          selection = {
            preselect = false,
            auto_insert = false,
          },
        },
        menu = {
          border = "single",
          draw = {
            columns = {
              { "label", "label_description", gap = 1 },
              { "kind_icon" },
            },
          },
        },
        documentation = {
          auto_show = true,
          window = {
            border = "single",
          },
        },
      }

      -- Cmdline
      opts.cmdline = {
        enabled = true,
      }

      -- Use LuaSnip as snippet engine
      opts.snippets = {
        preset = "luasnip",
      }

      -- Keymap
      opts.keymap = {
        preset = "default",
        ["<CR>"] = { "accept", "fallback" },
        ["<Tab>"] = { "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "snippet_backward", "fallback" },
        ["<Up>"] = { "select_prev", "fallback" },
        ["<Down>"] = { "select_next", "fallback" },
        ["<C-p>"] = { "select_prev", "fallback" },
        ["<C-n>"] = { "select_next", "fallback" },
        ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-e>"] = { "hide", "fallback" },
      }

      return opts
    end,
  },
}
