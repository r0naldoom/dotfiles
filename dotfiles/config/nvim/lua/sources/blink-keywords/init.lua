--- blink-keywords: Source de keywords para blink.cmp
--- Baseado em company-keywords do Emacs

---@class blink.cmp.Source
local source = {}

-- Keywords por linguagem
local keywords = {
  python = {
    "False", "None", "True", "and", "as", "assert", "async", "await",
    "break", "class", "continue", "def", "del", "elif", "else", "except",
    "finally", "for", "from", "global", "if", "import", "in", "is",
    "lambda", "nonlocal", "not", "or", "pass", "raise", "return", "try",
    "while", "with", "yield",
  },
  lua = {
    "and", "break", "do", "else", "elseif", "end", "false", "for",
    "function", "goto", "if", "in", "local", "nil", "not", "or",
    "repeat", "return", "then", "true", "until", "while",
  },
  javascript = {
    "async", "await", "break", "case", "catch", "class", "const",
    "continue", "debugger", "default", "delete", "do", "else", "enum",
    "export", "extends", "false", "finally", "for", "function", "if",
    "implements", "import", "in", "instanceof", "interface", "let",
    "new", "null", "of", "package", "private", "protected", "public",
    "return", "static", "super", "switch", "this", "throw", "true",
    "try", "typeof", "undefined", "var", "void", "while", "with", "yield",
  },
  typescript = {
    "abstract", "any", "as", "async", "await", "bigint", "boolean",
    "break", "case", "catch", "class", "const", "constructor", "continue",
    "debugger", "declare", "default", "delete", "do", "else", "enum",
    "export", "extends", "false", "finally", "for", "from", "function",
    "get", "if", "implements", "import", "in", "infer", "instanceof",
    "interface", "is", "keyof", "let", "module", "namespace", "never",
    "new", "null", "number", "object", "of", "package", "private",
    "protected", "public", "readonly", "require", "return", "set",
    "static", "string", "super", "switch", "symbol", "this", "throw",
    "true", "try", "type", "typeof", "undefined", "unique", "unknown",
    "var", "void", "while", "with", "yield",
  },
  rust = {
    "Self", "as", "async", "await", "break", "const", "continue", "crate",
    "dyn", "else", "enum", "extern", "false", "fn", "for", "if", "impl",
    "in", "let", "loop", "match", "mod", "move", "mut", "pub", "ref",
    "return", "self", "static", "struct", "super", "trait", "true",
    "type", "unsafe", "use", "where", "while",
  },
  go = {
    "break", "case", "chan", "const", "continue", "default", "defer",
    "else", "fallthrough", "for", "func", "go", "goto", "if", "import",
    "interface", "map", "package", "range", "return", "select", "struct",
    "switch", "type", "var",
  },
  sh = {
    "case", "do", "done", "elif", "else", "esac", "fi", "for", "function",
    "if", "in", "select", "then", "time", "until", "while",
  },
  bash = {
    "case", "do", "done", "elif", "else", "esac", "fi", "for", "function",
    "if", "in", "select", "then", "time", "until", "while",
  },
}

-- Mapeamento de filetype para keywords
local filetype_map = {
  python = "python",
  lua = "lua",
  javascript = "javascript",
  javascriptreact = "javascript",
  typescript = "typescript",
  typescriptreact = "typescript",
  rust = "rust",
  go = "go",
  sh = "sh",
  bash = "bash",
  zsh = "sh",
  fish = "sh",
}

function source.new(opts)
  local self = setmetatable({}, { __index = source })
  self.opts = opts or {}
  return self
end

function source:enabled()
  local ft = vim.bo.filetype
  return filetype_map[ft] ~= nil
end

function source:get_completions(ctx, callback)
  local ft = vim.bo.filetype
  local lang = filetype_map[ft]

  if not lang or not keywords[lang] then
    callback({ items = {} })
    return
  end

  local items = {}
  for _, kw in ipairs(keywords[lang]) do
    table.insert(items, {
      label = kw,
      kind = vim.lsp.protocol.CompletionItemKind.Keyword,
      insertText = kw,
    })
  end

  callback({
    is_incomplete_forward = false,
    is_incomplete_backward = false,
    items = items,
  })
end

return source
