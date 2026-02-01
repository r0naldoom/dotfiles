-- Markdown snippets
-- Trigger: ";" (ex: ;link, ;bash, ;table)

local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

local M = {}

-- Helpers
local function clipboard()
  return vim.fn.getreg("+")
end

local function date()
  return os.date("%Y-%m-%d")
end

-- Helper: create codeblock snippet for any language
local function codeblock(lang)
  return s({
    trig = ";" .. lang,
    name = "Codeblock " .. lang,
    desc = "```" .. lang .. " code block",
  }, {
    t({ "```" .. lang, "" }),
    i(1),
    t({ "", "```" }),
  })
end

-- Languages for codeblocks
local languages = {
  "bash", "sh", "zsh", "fish",
  "python", "py",
  "lua",
  "javascript", "js", "typescript", "ts",
  "json", "yaml", "toml",
  "html", "css",
  "sql",
  "go", "rust", "c", "cpp",
  "nix", "scm", "lisp",
  "diff", "txt",
}

-- Generate snippets
M.snippets = {}

-- Codeblock snippets for all languages
for _, lang in ipairs(languages) do
  table.insert(M.snippets, codeblock(lang))
end

-- Link
table.insert(M.snippets, s({
  trig = ";link",
  name = "Markdown link",
  desc = "[text](url)",
}, {
  t("["),
  i(1, "text"),
  t("]("),
  i(2, "url"),
  t(")"),
}))

-- Link with clipboard
table.insert(M.snippets, s({
  trig = ";linkc",
  name = "Link with clipboard",
  desc = "[text](clipboard)",
}, {
  t("["),
  i(1, "text"),
  t("]("),
  f(clipboard, {}),
  t(")"),
}))

-- Image
table.insert(M.snippets, s({
  trig = ";img",
  name = "Image",
  desc = "![alt](url)",
}, {
  t("!["),
  i(1, "alt"),
  t("]("),
  i(2, "url"),
  t(")"),
}))

-- Image with clipboard
table.insert(M.snippets, s({
  trig = ";imgc",
  name = "Image with clipboard",
  desc = "![alt](clipboard)",
}, {
  t("!["),
  i(1, "alt"),
  t("]("),
  f(clipboard, {}),
  t(")"),
}))

-- Task (checkbox)
table.insert(M.snippets, s({
  trig = ";task",
  name = "Task checkbox",
  desc = "- [ ] task",
}, {
  t("- [ ] "),
  i(1),
}))

-- Done task
table.insert(M.snippets, s({
  trig = ";done",
  name = "Done checkbox",
  desc = "- [x] task",
}, {
  t("- [x] "),
  i(1),
}))

-- Frontmatter
table.insert(M.snippets, s({
  trig = ";front",
  name = "YAML frontmatter",
  desc = "--- frontmatter ---",
}, {
  t({ "---", "title: " }),
  i(1, "Title"),
  t({ "", "date: " }),
  f(date, {}),
  t({ "", "tags: [" }),
  i(2),
  t({ "]", "---", "", "" }),
  i(3),
}))

-- Table
table.insert(M.snippets, s({
  trig = ";table",
  name = "Markdown table",
  desc = "| col | col |",
}, {
  t("| "),
  i(1, "Header 1"),
  t(" | "),
  i(2, "Header 2"),
  t({ " |", "| --- | --- |", "| " }),
  i(3),
  t(" | "),
  i(4),
  t(" |"),
}))

-- Callouts (GitHub style)
table.insert(M.snippets, s({
  trig = ";note",
  name = "Note callout",
  desc = "> [!NOTE]",
}, {
  t({ "> [!NOTE]", "> " }),
  i(1),
}))

table.insert(M.snippets, s({
  trig = ";tip",
  name = "Tip callout",
  desc = "> [!TIP]",
}, {
  t({ "> [!TIP]", "> " }),
  i(1),
}))

table.insert(M.snippets, s({
  trig = ";warn",
  name = "Warning callout",
  desc = "> [!WARNING]",
}, {
  t({ "> [!WARNING]", "> " }),
  i(1),
}))

table.insert(M.snippets, s({
  trig = ";important",
  name = "Important callout",
  desc = "> [!IMPORTANT]",
}, {
  t({ "> [!IMPORTANT]", "> " }),
  i(1),
}))

-- Details/Summary (collapsible)
table.insert(M.snippets, s({
  trig = ";details",
  name = "Collapsible section",
  desc = "<details><summary>",
}, {
  t({ "<details>", "<summary>" }),
  i(1, "Click to expand"),
  t({ "</summary>", "", "" }),
  i(2),
  t({ "", "", "</details>" }),
}))

-- Headings
table.insert(M.snippets, s({
  trig = ";h1",
  name = "Heading 1",
  desc = "# Heading",
}, {
  t("# "),
  i(1),
}))

table.insert(M.snippets, s({
  trig = ";h2",
  name = "Heading 2",
  desc = "## Heading",
}, {
  t("## "),
  i(1),
}))

table.insert(M.snippets, s({
  trig = ";h3",
  name = "Heading 3",
  desc = "### Heading",
}, {
  t("### "),
  i(1),
}))

return M
