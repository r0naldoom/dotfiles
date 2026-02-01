-- Task System
-- Unified tasks + agenda, scope: ~/zettelkasten
local M = {}

local vault = vim.fn.expand("~") .. "/zettelkasten"

-- ============================================================================
--                                  SEARCH
-- ============================================================================

--- Pending tasks in the vault
function M.find_pending()
  Snacks.picker.grep({
    prompt = "Pending Tasks ",
    search = "^\\s*- \\[ \\]",
    regex = true,
    live = false,
    dirs = { vault },
    args = { "--no-ignore" },
  })
end

--- Completed tasks in the vault
function M.find_completed()
  Snacks.picker.grep({
    prompt = "Completed Tasks ",
    search = "^\\s*- \\[x\\]",
    regex = true,
    live = false,
    dirs = { vault },
    args = { "--no-ignore" },
  })
end

--- Tasks completed today in the vault
function M.find_completed_today()
  local today = os.date("%Y-%m-%d")
  Snacks.picker.grep({
    prompt = "Completed Today ",
    search = "done: " .. today,
    regex = false,
    live = false,
    dirs = { vault },
    args = { "--no-ignore" },
  })
end

--- Pending tasks in today's daily note
function M.today_tasks()
  local today = os.date("%Y-%m-%d")
  local daily_file = vault .. "/daily/" .. today .. ".md"

  if vim.fn.filereadable(daily_file) == 0 then
    vim.notify("Daily note does not exist: " .. today, vim.log.levels.WARN)
    return
  end

  Snacks.picker.grep({
    prompt = "Today: Pending Tasks ",
    search = "^\\s*- \\[ \\]",
    regex = true,
    live = false,
    dirs = { vault .. "/daily" },
    args = { "--no-ignore", "-g", today .. ".md" },
  })
end

--- Current ISO week dates (Monday to Sunday)
---@return string[]
local function current_week_dates()
  local now = os.time()
  local wday = os.date("*t", now).wday
  local offset_from_monday = (wday - 2) % 7

  local dates = {}
  for d = 0, 6 do
    local day_time = now - (offset_from_monday - d) * 86400
    table.insert(dates, os.date("%Y-%m-%d", day_time))
  end
  return dates
end

--- Pending tasks in this week's daily notes
function M.week_tasks()
  local dates = current_week_dates()

  local args = { "--no-ignore" }
  for _, date in ipairs(dates) do
    table.insert(args, "-g")
    table.insert(args, date .. ".md")
  end

  Snacks.picker.grep({
    prompt = "Week: Pending Tasks ",
    search = "^\\s*- \\[ \\]",
    regex = true,
    live = false,
    dirs = { vault .. "/daily" },
    args = args,
  })
end

-- ============================================================================
--                                 ACTIONS
-- ============================================================================

--- Create checkbox or convert bullet to task
function M.create_or_convert()
  local row = vim.api.nvim_win_get_cursor(0)[1]
  local line = vim.api.nvim_get_current_line()

  if line:match("^%s*$") then
    vim.api.nvim_set_current_line("- [ ] ")
    vim.api.nvim_win_set_cursor(0, { row, 6 })
    vim.cmd("startinsert!")
    return
  end

  local bullet, text = line:match("^([%s]*[-*]%s+)(.*)$")
  if bullet then
    local new_line = bullet .. "[ ] " .. text
    vim.api.nvim_set_current_line(new_line)
    vim.api.nvim_win_set_cursor(0, { row, #bullet + 4 })
    return
  end

  vim.api.nvim_set_current_line("- [ ] " .. line)
  vim.api.nvim_win_set_cursor(0, { row, 6 })
end

--- Toggle task: [ ] <-> [x] with timestamp
function M.toggle_done()
  local line = vim.api.nvim_get_current_line()
  local timestamp = os.date("%Y-%m-%d %H:%M")

  if line:match("%- %[ %]") then
    local new_line = line:gsub("%- %[ %]", "- [x]")
    new_line = new_line .. " `done: " .. timestamp .. "`"
    vim.api.nvim_set_current_line(new_line)
    vim.notify("Task done!", vim.log.levels.INFO)
    return
  end

  if line:match("%- %[x%]") then
    local new_line = line:gsub("%- %[x%]", "- [ ]")
    new_line = new_line:gsub("%s*`done:.-`", "")
    vim.api.nvim_set_current_line(new_line)
    vim.notify("Task reopened", vim.log.levels.INFO)
    return
  end

  vim.notify("Not a task", vim.log.levels.WARN)
end

-- ============================================================================
--                               NAVIGATION
-- ============================================================================

--- Jump to next pending task
function M.goto_next()
  vim.fn.search("^\\s*- \\[ \\]", "w")
end

--- Jump to previous pending task
function M.goto_prev()
  vim.fn.search("^\\s*- \\[ \\]", "bw")
end

-- ============================================================================
--                              WEEKLY NOTE
-- ============================================================================

--- Open or create current week's weekly note
function M.open_weekly()
  local year = tonumber(os.date("%G"))
  local week = tonumber(os.date("%V"))
  local filename = string.format("%d-W%02d.md", year, week)
  local weekly_dir = vault .. "/weekly"
  local filepath = weekly_dir .. "/" .. filename

  vim.fn.mkdir(weekly_dir, "p")

  if vim.fn.filereadable(filepath) == 1 then
    vim.cmd("edit " .. vim.fn.fnameescape(filepath))
    return
  end

  local dates = current_week_dates()
  local day_names = { "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday" }

  local lines = {
    "---",
    string.format('id: "%s"', filename:gsub("%.md$", "")),
    "aliases:",
    string.format('  - "Week %02d of %d"', week, year),
    "tags:",
    "  - weekly",
    string.format('date: "%s"', dates[1]),
    string.format('week_end: "%s"', dates[7]),
    "---",
    "",
    string.format("# Week %02d · %d · %s to %s", week, year, dates[1], dates[7]),
    "",
    "## Goals",
    "",
    "- [ ] ",
    "",
  }

  for i, day_name in ipairs(day_names) do
    table.insert(lines, string.format("## %s · [[daily/%s]]", day_name, dates[i]))
    table.insert(lines, "")
    table.insert(lines, "")
  end

  table.insert(lines, "## Review")
  table.insert(lines, "")
  table.insert(lines, "**What went well?**")
  table.insert(lines, "")
  table.insert(lines, "")
  table.insert(lines, "**What can improve?**")
  table.insert(lines, "")

  vim.cmd("edit " .. vim.fn.fnameescape(filepath))
  vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
  vim.api.nvim_win_set_cursor(0, { 15, 6 })
end

return M
