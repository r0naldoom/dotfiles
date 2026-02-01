-- grug-far.nvim - Search and Replace avançado
-- https://github.com/MagicDuck/grug-far.nvim
--
-- Exemplos de uso:
--   Substituir com regex:
--     Search: colors\["(color\d+)"\]
--     Replace: "$1"
--
--   Excluir arquivos:
--     Files Filter: !arquivo.lua
--
--   Adicionar sufixo a links markdown:
--     Search: \[(.*?)\]\((http[s]?:\/\/.*?)\)(?:[^{]|$)
--     Replace: [$1]($2){:target="_blank"}

return {
  "MagicDuck/grug-far.nvim",
  cmd = "GrugFar",
  keys = {
    {
      "<leader>sr",
      function()
        local grug = require("grug-far")
        local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
        grug.open({
          transient = true,
          prefills = {
            filesFilter = ext and ext ~= "" and "*." .. ext or nil,
          },
        })
      end,
      mode = { "n", "v" },
      desc = "Search and Replace",
    },
    {
      "<leader>sR",
      function()
        require("grug-far").open({
          transient = true,
        })
      end,
      mode = { "n", "v" },
      desc = "Search and Replace (all files)",
    },
    {
      "<leader>sw",
      function()
        local grug = require("grug-far")
        grug.open({
          transient = true,
          prefills = {
            search = vim.fn.expand("<cword>"),
          },
        })
      end,
      desc = "Search word under cursor",
    },
  },
  opts = {
    -- Fecha com ESC após entrar em normal mode
    keymaps = {
      close = { n = "<Esc>" },
    },
  },
}
