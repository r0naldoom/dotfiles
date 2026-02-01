-- Global snippets (all filetypes)
-- Trigger: ";" (ex: ;todo, ;date, ;fixme)

local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

local M = {}

-- Helpers
local function date()
  return os.date("%Y-%m-%d")
end

local function datetime()
  return os.date("%Y-%m-%d %H:%M")
end

M.snippets = {
  -- Todo
  s({ trig = ";todo", name = "TODO comment", desc = "TODO: " }, {
    t("TODO: "),
    i(1),
  }),

  -- Fixme
  s({ trig = ";fixme", name = "FIXME comment", desc = "FIXME: " }, {
    t("FIXME: "),
    i(1),
  }),

  -- Date
  s({ trig = ";date", name = "Current date", desc = "YYYY-MM-DD" }, {
    f(date, {}),
  }),

  -- Datetime
  s({ trig = ";datetime", name = "Current datetime", desc = "YYYY-MM-DD HH:MM" }, {
    f(datetime, {}),
  }),

  -- Separator line
  s({ trig = ";sep", name = "Separator", desc = "---" }, {
    t("---"),
  }),
}

return M
