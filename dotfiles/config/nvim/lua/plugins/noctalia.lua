-- Noctalia native theme sync
-- Temas sincronizados com Noctalia

return {
  -- ef-themes (Emacs themes portados para Neovim)
  {
    "oonamo/ef-themes.nvim",
    lazy = true,
  },

  -- gruvbox com paleta material
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      terminal_colors = true,
      undercurl = true,
      underline = true,
      bold = true,
      italic = {
        strings = true,
        emphasis = true,
        comments = true,
        operators = false,
        folds = true,
      },
      strikethrough = true,
      contrast = "",
      transparent_mode = true,
      overrides = {
        -- Estilo discreto: só keywords/strings/comments com cor,
        -- o resto usa foreground (como ef-cherie / tokyonight)
        ["@module"] = { link = "GruvboxFg1" },
        ["@module.builtin"] = { link = "GruvboxFg1" },
        ["@type"] = { link = "GruvboxFg1" },
        ["@type.builtin"] = { link = "GruvboxFg1" },
        ["@type.definition"] = { link = "GruvboxFg1" },
        ["@constructor"] = { link = "GruvboxFg1" },
        ["@function"] = { link = "GruvboxFg1" },
        ["@function.call"] = { link = "GruvboxFg1" },
        ["@function.builtin"] = { link = "GruvboxFg1" },
        ["@method"] = { link = "GruvboxFg1" },
        ["@method.call"] = { link = "GruvboxFg1" },
        ["@variable"] = { link = "GruvboxFg1" },
        ["@variable.builtin"] = { link = "GruvboxFg1" },
        ["@property"] = { link = "GruvboxFg1" },
        ["@field"] = { link = "GruvboxFg1" },
        ["@parameter"] = { link = "GruvboxFg1" },
        ["@constant"] = { link = "GruvboxFg1" },
        ["@constant.builtin"] = { link = "GruvboxFg1" },
        ["@namespace"] = { link = "GruvboxFg1" },
      },
      palette_overrides = {
        -- Backgrounds (material medium)
        dark0_hard = "#1d2021",
        dark0 = "#282828",
        dark0_soft = "#32302f",
        dark1 = "#32302f",
        dark2 = "#45403d",
        dark3 = "#5a524c",
        dark4 = "#7c6f64",
        -- Foregrounds (material)
        light0_hard = "#e2cca9",
        light0 = "#e2cca9",
        light0_soft = "#d4be98",
        light1 = "#d4be98",
        light2 = "#d4be98",
        light3 = "#a89984",
        light4 = "#928374",
        -- Bright (dark mode syntax)
        bright_red = "#ea6962",
        bright_green = "#a9b665",
        bright_yellow = "#d8a657",
        bright_blue = "#7daea3",
        bright_purple = "#d3869b",
        bright_aqua = "#89b482",
        bright_orange = "#e78a4e",
        -- Neutral
        neutral_red = "#c14a4a",
        neutral_green = "#6c782e",
        neutral_yellow = "#b47109",
        neutral_blue = "#45707a",
        neutral_purple = "#945e80",
        neutral_aqua = "#4c7a5d",
        neutral_orange = "#c35e0a",
        -- Faded
        faded_red = "#c14a4a",
        faded_green = "#6c782e",
        faded_yellow = "#b47109",
        faded_blue = "#45707a",
        faded_purple = "#945e80",
        faded_aqua = "#4c7a5d",
        faded_orange = "#c35e0a",
        gray = "#928374",
      },
    },
    config = function(_, opts)
      require("gruvbox").setup(opts)
      local sync = require("noctalia-sync")
      sync.setup()
    end,
  },
}
