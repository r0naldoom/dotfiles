-- Custom highlight utilities
local M = {}

---@param highlights table<string, vim.api.keyset.highlight>
function M.apply(highlights)
  for group, opts in pairs(highlights) do
    vim.api.nvim_set_hl(0, group, opts)
  end
end

--- Gera highlights para ef-melissa-dark com transparência
---@return table<string, vim.api.keyset.highlight>
function M.ef_melissa_dark()
  -- Paleta ef-melissa-dark
  local p = {
    -- Backgrounds
    bg_main = "#352718",
    bg_dim = "#483426",
    bg_alt = "#59463f",
    bg_hover = "#4f311f",
    -- Foregrounds
    fg_main = "#e8e4b1",
    fg_dim = "#90918a",
    fg_alt = "#ccaa70",
    border = "#6f5f58",
    -- Accents
    yellow = "#e4b53f",
    green = "#6fd560",
    red = "#ff7f7f",
    blue = "#57aff6",
    magenta = "#f0aac5",
    cyan = "#6fcad0",
    orange = "#f5aa80",
    purple = "#d0a0f0",
  }

  return {
    -- Base (transparente)
    Normal = { bg = "none", fg = p.fg_main },
    NormalFloat = { bg = "none", fg = p.fg_main },
    FloatBorder = { bg = "none", fg = p.border },
    FloatTitle = { bg = "none", fg = p.yellow },
    FoldColumn = { bg = "none", fg = p.fg_dim },
    SignColumn = { bg = "none" },
    EndOfBuffer = { bg = "none", fg = p.fg_dim },

    -- Snacks picker
    SnacksPickerTitle = { bg = "none", fg = p.fg_main },
    SnacksPickerBorder = { bg = "none", fg = p.border },
    SnacksPickerNormal = { bg = "none" },
    SnacksPickerPromptNormal = { bg = "none", fg = p.fg_main },
    SnacksPickerResultsNormal = { bg = "none", fg = p.fg_main },
    SnacksPickerSelection = { bg = p.bg_alt, fg = p.fg_main },
    SnacksPickerMatching = { bold = false, bg = "none", fg = p.green },

    -- Editor
    Visual = { bg = p.bg_alt },
    ColorColumn = { bg = p.bg_dim },
    CursorLine = { bg = p.bg_dim, blend = 25 },

    -- Git signs
    GitSignsAdd = { bg = "none", fg = p.green },
    GitSignsChange = { bg = "none", fg = p.yellow },
    GitSignsDelete = { bg = "none", fg = p.red },

    -- Diff
    DiffAdd = { bg = "none", fg = p.green },
    DiffChange = { bg = "none", fg = p.yellow },
    DiffDelete = { bg = "none", fg = p.red },
    DiffText = { bg = "none", fg = p.blue },

    -- LSP
    LspInfoBorder = { bg = "none", fg = p.border },
    MatchParen = { bg = p.fg_dim, fg = p.bg_main },
    DiagnosticSignWarn = { bg = "none", fg = p.yellow },
    ErrorMsg = { fg = p.red },

    -- Statusline
    StatusLine = { bg = p.bg_main, fg = p.fg_main },
    StatusLineAccent = { bg = p.bg_dim, fg = p.yellow },
    StatusLineInsertAccent = { bg = p.bg_dim, fg = p.green },
    StatusLineVisualAccent = { bg = p.bg_dim, fg = p.magenta },
    StatusLineReplaceAccent = { bg = p.bg_dim, fg = p.red },
    StatusLineCmdLineAccent = { bg = p.bg_dim, fg = p.cyan },
    StatusLineTerminalAccent = { bg = p.bg_dim, fg = p.blue },
    StatusLineExtra = { bg = p.bg_dim, fg = p.blue },
  }
end

--- Gera highlights para gruvbox-material com transparência
---@param palette table Paleta de cores do gruvbox-material
---@return table<string, vim.api.keyset.highlight>
function M.gruvbox_material(palette)
  local p = palette
  return {
    -- Base (transparente)
    Normal = { bg = "none", fg = p.fg0[1] },
    NormalFloat = { bg = "none", fg = p.fg0[1] },
    FloatBorder = { bg = "none" },
    FloatTitle = { bg = "none", fg = p.orange[1] },
    FoldColumn = { bg = "none", fg = p.grey0[1] },
    SignColumn = { bg = "none" },
    EndOfBuffer = { bg = "none", fg = p.grey0[1] },

    -- Snacks picker
    SnacksPickerTitle = { bg = "none", fg = p.fg0[1] },
    SnacksPickerBorder = { bg = "none", fg = p.fg0[1] },
    SnacksPickerNormal = { fg = "none" },
    SnacksPickerPromptNormal = { bg = "none", fg = p.fg0[1] },
    SnacksPickerResultsNormal = { bg = "none", fg = p.fg0[1] },
    SnacksPickerSelection = { bg = p.bg5[1], fg = p.fg0[1] },
    SnacksPickerMatching = { bold = false, bg = "none", fg = p.green[1] },

    -- Editor
    Visual = { bg = p.bg_visual_red[1] },
    ColorColumn = { bg = p.bg_visual_blue[1] },
    CursorLine = { bg = p.bg3[1], blend = 25 },

    -- Git signs
    GitSignsAdd = { bg = "none", fg = p.green[1] },
    GitSignsChange = { bg = "none", fg = p.yellow[1] },
    GitSignsDelete = { bg = "none", fg = p.red[1] },

    -- Diff
    DiffAdd = { bg = "none", fg = p.green[1] },
    DiffChange = { bg = "none", fg = p.yellow[1] },
    DiffDelete = { bg = "none", fg = p.red[1] },
    DiffText = { bg = "none", fg = p.blue[1] },

    -- LSP
    LspInfoBorder = { bg = "none", fg = p.fg0[1] },
    MatchParen = { bg = p.grey2[1], fg = p.bg0[1] },
    DiagnosticSignWarn = { bg = "none", fg = p.yellow[1] },
    ErrorMsg = { fg = p.red[1] },

    -- Statusline
    StatusLine = { bg = p.bg0[1], fg = p.fg0[1] },
    StatusLineAccent = { bg = p.bg1[1], fg = p.orange[1] },
    StatusLineInsertAccent = { bg = p.bg1[1], fg = p.green[1] },
    StatusLineVisualAccent = { bg = p.bg1[1], fg = p.purple[1] },
    StatusLineReplaceAccent = { bg = p.bg1[1], fg = p.red[1] },
    StatusLineCmdLineAccent = { bg = p.bg1[1], fg = p.yellow[1] },
    StatusLineTerminalAccent = { bg = p.bg1[1], fg = p.aqua[1] },
    StatusLineExtra = { bg = p.bg1[1], fg = p.blue[1] },
  }
end

return M
