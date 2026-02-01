-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

local tasks = require("util.tasks")

---@param mode string|string[]
---@param lhs string
---@param rhs string|function
---@param opts? { desc?: string, silent?: boolean, expr?: boolean, remap?: boolean }
local function map(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- ============================================================================
--                                   SPELL
-- ============================================================================

local spell_keymaps = {
  { "<leader>ss", "<cmd>set spell!<cr>",                "Toggle spell" },
  { "<leader>sp", "<cmd>set spelllang=pt_br<cr>",       "Spell PT-BR" },
  { "<leader>se", "<cmd>set spelllang=en_us<cr>",       "Spell EN-US" },
  { "<leader>sb", "<cmd>set spelllang=pt_br,en_us<cr>", "Spell PT+EN" },
}

for _, km in ipairs(spell_keymaps) do
  map("n", km[1], km[2], { desc = km[3] })
end

-- ============================================================================
--                                   TASKS
-- ============================================================================

-- Search (vault)
map("n", "<leader>tt", tasks.find_pending,         { desc = "Pending tasks" })
map("n", "<leader>tc", tasks.find_completed,       { desc = "Completed tasks" })
map("n", "<leader>tC", tasks.find_completed_today, { desc = "Completed today" })
map("n", "<leader>tg", tasks.today_tasks,          { desc = "Today's tasks (daily)" })
map("n", "<leader>tk", tasks.week_tasks,           { desc = "Week tasks" })

-- Actions
map({ "n", "i" }, "<t-x>", tasks.create_or_convert, { desc = "Create/convert task" })
map("n", "<leader>td", tasks.toggle_done, { desc = "Toggle task done" })

-- Navigation
map("n", "]t", tasks.goto_next, { desc = "Next task" })
map("n", "[t", tasks.goto_prev, { desc = "Previous task" })

-- Weekly
map("n", "<leader>tw", tasks.open_weekly, { desc = "Open weekly note" })

-- ============================================================================
--                                  EDITING
-- ============================================================================

-- Center cursor after scroll/search
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down (centered)" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up (centered)" })
map("n", "n", "nzzzv", { desc = "Next search (centered)" })
map("n", "N", "Nzzzv", { desc = "Prev search (centered)" })
