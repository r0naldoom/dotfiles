-- LuaSnip configuration
-- Snippets são carregados de lua/snippets/
-- Trigger: ";" (ex: ;def, ;link, ;bash)

return {
  "L3MON4D3/LuaSnip",
  opts = function(_, opts)
    local ls = require("luasnip")

    -- Load snippets from modules
    local python_snippets = require("snippets.python").snippets
    local markdown_snippets = require("snippets.markdown").snippets
    local all_snippets = require("snippets.all").snippets

    -- Register snippets
    ls.add_snippets("python", python_snippets)
    ls.add_snippets("markdown", markdown_snippets)
    ls.add_snippets("all", all_snippets)

    return opts
  end,
}
