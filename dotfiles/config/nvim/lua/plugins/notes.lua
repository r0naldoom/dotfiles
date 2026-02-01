-- Obsidian.nvim - Zettelkasten note-taking
-- Plugin: obsidian-nvim/obsidian.nvim (community fork)
-- Vault: ~/zettelkasten

return {
  -- =========================================================================
  -- obsidian.nvim - Obsidian vault integration
  -- =========================================================================
  {
    "obsidian-nvim/obsidian.nvim",
    version = "*",
    event = {
      "BufReadPre " .. vim.fn.expand("~") .. "/zettelkasten/**.md",
      "BufNewFile " .. vim.fn.expand("~") .. "/zettelkasten/**.md",
    },

    keys = {
      -- Daily notes
      { "<leader>nd", "<cmd>Obsidian today<cr>", desc = "Daily note (today)" },
      { "<leader>nD", "<cmd>Obsidian today 1<cr>", desc = "Daily note (tomorrow)" },
      { "<leader>ny", "<cmd>Obsidian today -1<cr>", desc = "Daily note (yesterday)" },

      -- Navigation & search
      { "<leader>no", "<cmd>Obsidian quick_switch<cr>", desc = "Open note (picker)" },
      { "<leader>ns", "<cmd>Obsidian search<cr>", desc = "Search vault" },
      { "<leader>nb", "<cmd>Obsidian backlinks<cr>", desc = "Backlinks" },
      { "<leader>nl", "<cmd>Obsidian links<cr>", desc = "Links in note" },
      { "<leader>nt", "<cmd>Obsidian tags<cr>", desc = "Search tags" },

      -- Create & edit
      { "<leader>nn", "<cmd>Obsidian new<cr>", desc = "New note" },
      { "<leader>nT", "<cmd>Obsidian new_from_template<cr>", desc = "New from template" },
      { "<leader>nr", "<cmd>Obsidian rename<cr>", desc = "Rename note" },
      { "<leader>nc", "<cmd>Obsidian toc<cr>", desc = "Table of contents" },

      -- Open in Obsidian app
      { "<leader>nO", "<cmd>Obsidian open<cr>", desc = "Open in app" },

      -- Visual mode: link selection
      { "<leader>nk", "<cmd>Obsidian link<cr>", mode = "v", desc = "Link selection" },
      { "<leader>ne", "<cmd>Obsidian extract_note<cr>", mode = "v", desc = "Extract to note" },
    },

    opts = {
      workspaces = {
        {
          name = "zettelkasten",
          path = "~/zettelkasten",
        },
      },

      daily_notes = {
        folder = "daily",
        date_format = "%Y-%m-%d",
        template = "daily.md",
        default_tags = { "daily" },
        workdays_only = false,
      },

      templates = {
        folder = "templates",
        date_format = "%Y-%m-%d",
        time_format = "%H:%M",
      },

      -- New notes go to vault root, not current directory
      new_notes_location = "notes_subdir",
      notes_subdir = "notes",

      preferred_link_style = "wiki",

      -- Use alias as link text: [[guix-vm-setup]] instead of [[1769723969-OPPN|guix-vm-setup]]
      wiki_link_func = function(opts)
        if opts.label ~= opts.path then
          return string.format("[[%s]]", opts.label)
        end
        return string.format("[[%s]]", opts.path)
      end,

      -- render-markdown.nvim handles all visual rendering
      ui = { enable = false },

      checkbox = {
        enabled = true,
        create_new = true,
        order = { " ", "x", "~", "!", ">" },
      },

      legacy_commands = false,

      attachments = {
        folder = "attachments",
      },

      callbacks = {
        enter_note = function()
          vim.opt_local.conceallevel = 2

          -- <cr> = smart action (toggle checkbox, follow link, fold heading)
          vim.keymap.set("n", "<cr>", function()
            return require("obsidian.actions").smart_action()
          end, { buffer = true, expr = true, desc = "Obsidian smart action" })

          -- gf = follow link
          vim.keymap.set("n", "gf", function()
            return require("obsidian.actions").smart_action()
          end, { buffer = true, expr = true, desc = "Obsidian follow link" })
        end,
      },
    },
  },

  -- =========================================================================
  -- Which-key group
  -- =========================================================================
  {
    "folke/which-key.nvim",
    opts = function(_, opts)
      opts.spec = opts.spec or {}
      table.insert(opts.spec, {
        mode = "n",
        { "<leader>n", group = "notes" },
      })
    end,
  },
}
