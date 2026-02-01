-- Python snippets
-- Trigger: ";" (ex: ;pyclass, ;def, ;main)

local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

local M = {}

M.snippets = {
  -- Shebang
  s({ trig = ";shebang", name = "Python shebang", desc = "#!/usr/bin/env python3" }, {
    t({ "#!/usr/bin/env python3", "" }),
  }),

  -- Main template
  s({ trig = ";main", name = "Main template", desc = "if __name__ == '__main__'" }, {
    t({ 'if __name__ == "__main__":', "    " }),
    i(1, "pass"),
  }),

  -- Function
  s({ trig = ";def", name = "Function", desc = "def function():" }, {
    t("def "),
    i(1, "name"),
    t("("),
    i(2),
    t(")"),
    i(3, " -> None"),
    t({ ":", "    " }),
    i(4, "pass"),
  }),

  -- Async function
  s({ trig = ";adef", name = "Async function", desc = "async def function():" }, {
    t("async def "),
    i(1, "name"),
    t("("),
    i(2),
    t(")"),
    i(3, " -> None"),
    t({ ":", "    " }),
    i(4, "pass"),
  }),

  -- Class
  s({ trig = ";class", name = "Class", desc = "class Name:" }, {
    t("class "),
    i(1, "Name"),
    t({ ":", "    def __init__(self" }),
    i(2),
    t({ "):", "        " }),
    i(3, "pass"),
  }),

  -- Dataclass
  s({ trig = ";dataclass", name = "Dataclass", desc = "@dataclass" }, {
    t({ "from dataclasses import dataclass", "", "", "@dataclass", "class " }),
    i(1, "Name"),
    t({ ":", "    " }),
    i(2, "field"),
    t(": "),
    i(3, "str"),
  }),

  -- Try/except
  s({ trig = ";try", name = "Try/except", desc = "try/except block" }, {
    t({ "try:", "    " }),
    i(1, "pass"),
    t({ "", "except " }),
    i(2, "Exception"),
    t({ " as e:", "    " }),
    i(3, "raise"),
  }),

  -- List comprehension
  s({ trig = ";lc", name = "List comprehension", desc = "[x for x in iterable]" }, {
    t("["),
    i(1, "x"),
    t(" for "),
    i(2, "x"),
    t(" in "),
    i(3, "iterable"),
    t("]"),
  }),

  -- Dict comprehension
  s({ trig = ";dc", name = "Dict comprehension", desc = "{k: v for k, v in items}" }, {
    t("{"),
    i(1, "k"),
    t(": "),
    i(2, "v"),
    t(" for "),
    i(3, "k, v"),
    t(" in "),
    i(4, "items"),
    t("}"),
  }),

  -- With statement
  s({ trig = ";with", name = "With statement", desc = "with open() as f:" }, {
    t("with "),
    i(1, 'open("file")'),
    t(" as "),
    i(2, "f"),
    t({ ":", "    " }),
    i(3, "pass"),
  }),

  -- Logger
  s({ trig = ";logger", name = "Logger setup", desc = "logging.getLogger(__name__)" }, {
    t({ "import logging", "", "logger = logging.getLogger(__name__)", "" }),
  }),

  -- Pytest fixture
  s({ trig = ";fixture", name = "Pytest fixture", desc = "@pytest.fixture" }, {
    t({ "@pytest.fixture", "def " }),
    i(1, "name"),
    t({ "():", "    " }),
    i(2, "pass"),
  }),

  -- Type hint imports
  s({ trig = ";typing", name = "Typing imports", desc = "from typing import ..." }, {
    t("from typing import "),
    i(1, "Optional, List, Dict"),
  }),

  -- Pydantic model
  s({ trig = ";pydantic", name = "Pydantic model", desc = "class Model(BaseModel):" }, {
    t({ "from pydantic import BaseModel", "", "", "class " }),
    i(1, "Name"),
    t({ "(BaseModel):", "    " }),
    i(2, "field"),
    t(": "),
    i(3, "str"),
  }),

  -- FastAPI endpoint
  s({ trig = ";fastapi", name = "FastAPI endpoint", desc = "@app.get('/path')" }, {
    t("@app."),
    i(1, "get"),
    t('("'),
    i(2, "/"),
    t({ '")', "async def " }),
    i(3, "handler"),
    t("("),
    i(4),
    t({ "):", "    " }),
    i(5, "pass"),
  }),
}

return M
