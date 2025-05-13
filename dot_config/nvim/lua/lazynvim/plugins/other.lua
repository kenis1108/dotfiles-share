return {
  -- auto pairs
  {
    "echasnovski/mini.pairs",
    opts = {},
  },

  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy", -- Or `LspAttach`
    priority = 1000, -- needs to be loaded in first
    opts={},
  },

  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },

  -- 用于在 Neovim 中展示 LSP 诊断、快速修复、位置列表等信息的插件
  {
    "folke/trouble.nvim",
    opts = {
      modes = {
        lsp = {
          win = { position = "right" },
        },
      },
    },
    cmd = "Trouble",
  },
}
