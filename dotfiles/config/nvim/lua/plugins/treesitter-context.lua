-- nvim-treesitter-context
-- Mostra o contexto (função/classe/heading) no topo da tela
-- https://github.com/nvim-treesitter/nvim-treesitter-context

return {
  "nvim-treesitter/nvim-treesitter-context",
  event = "BufReadPost",
  opts = {
    -- "cursor" mostra contexto baseado na posição do cursor
    -- "topline" mostra baseado na primeira linha visível
    mode = "cursor",
    -- Máximo de linhas de contexto
    max_lines = 3,
    -- Mínimo de linhas entre contexto e cursor
    min_window_height = 0,
    -- Separador entre contexto e código
    separator = nil,
    -- Trim context quando linha é muito longa
    trim_scope = "outer",
  },
  keys = {
    {
      "<leader>ut",
      function()
        local tsc = require("treesitter-context")
        tsc.toggle()
        vim.notify(
          "Treesitter Context: " .. (tsc.enabled() and "enabled" or "disabled"),
          vim.log.levels.INFO
        )
      end,
      desc = "Toggle Treesitter Context",
    },
    {
      "[c",
      function()
        require("treesitter-context").go_to_context(vim.v.count1)
      end,
      desc = "Go to context",
    },
  },
}
