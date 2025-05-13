return {
  -- themes
  {
    "folke/tokyonight.nvim",
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      vim.cmd([[colorscheme tokyonight]])
    end,
  },

  -- icon
  { "echasnovski/mini.icons" },

  -- filemanager
  {
    "echasnovski/mini.files",
    config = function()
      require("mini.files").setup()
      vim.keymap.set("n", "<Leader>e", MiniFiles.open, { desc = "[E]xplorer (Open filemanager)" })
    end,
  },

  -- show keybindings for possible keymaps with a popup
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      spec = {
        { "<leader>a", group = "[A]I" },
        {
          "<leader>b",
          group = "buffer",
          expand = function()
            return require("which-key.extras").expand.buf()
          end,
        },
        { "<leader>d", group = "[D]ropbar" },
        { "g", group = "goto" },
        { "gs", group = "surround" },
        { "<leader>s", group = "[S]earch" },
        {
          "<leader>w",
          group = "windows",
          proxy = "<c-w>",
          expand = function()
            return require("which-key.extras").expand.win()
          end,
        },
        { "z", group = "fold" },
        {
          "<leader>?",
          function()
            require("which-key").show({ global = false })
          end,
          desc = "Buffer Local Keymaps (which-key)",
        }
      },
    },

  },

  -- statusline
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {},
  },

  -- winbar中显示面包屑下拉菜单
  -- A polished, IDE-like, highly-customizable winbar for Neovim
  -- with drop-down menu support and multiple backends
  {
    "Bekaboo/dropbar.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
    config = function()
      require("dropbar").setup()
      local dropbar_api = require("dropbar.api")
      vim.keymap.set("n", "<Leader>d;", dropbar_api.pick, { desc = "Pick symbols in winbar" })
      -- vim.keymap.set("n", "[;", dropbar_api.goto_context_start, { desc = "Go to start of current context" })
      -- vim.keymap.set("n", "];", dropbar_api.select_next_context, { desc = "Select next context" })
    end,
  },

  -- indent-blankline
  {
    "folke/snacks.nvim",
    priority = 1000,
    opts = {
      indent = {
        enabled = true,
        chunk = {
          enabled = true,
          char = {
            corner_top = "╭",
            corner_bottom = "╰",
            horizontal = "─",
            vertical = "│",
            arrow = ">",
          },
        },
      },
    },
  },
}
