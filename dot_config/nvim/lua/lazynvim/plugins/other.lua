return {
  -- themes
  {
    "folke/tokyonight.nvim",
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- load the colorscheme here
      vim.cmd([[colorscheme tokyonight]])
    end,
  },

  -- show keybindings for possible keymaps with a popup
  {
    'folke/which-key.nvim',
    event = "VeryLazy",
  },

  -- statusline
  {
    'nvim-lualine/lualine.nvim',
    event = "VeryLazy",
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require("lualine").setup()
    end,
  },

  -- syntax highlighting. Highlight, edit, and navigate code
  -- { 
  --   "nvim-treesitter/nvim-treesitter",
  --   build = ":TSUpdate",
  --   config = function () 
  --     local configs = require("nvim-treesitter.configs")
  
  --     configs.setup({
  --       ensure_installed = { 
  --         "bash",
  --         "css",      
  --         "diff",
  --         "html",
  --         "javascript",
  --         "jsdoc",
  --         "json",
  --         "jsonc",
  --         "lua",
  --         "luadoc",
  --         "markdown",
  --         "markdown_inline",
  --         "nix",
  --         "powershell",
  --         "python",
  --         "scss",
  --         "toml",
  --         "tsx",
  --         "typescript",
  --         "vim",
  --         "vimdoc",
  --         "vue",
  --         "xml",
  --         "yaml",
  --       },
  --       auto_install = true,
  --       sync_install = false,
  --       highlight = { enable = true },
  --       indent = { enable = true },  
  --     })
  --   end
  -- }
}