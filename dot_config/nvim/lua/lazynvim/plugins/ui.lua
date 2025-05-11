return {
  -- themes
  {
    "folke/tokyonight.nvim",
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      vim.cmd([[colorscheme tokyonight]])
    end,
  },

  -- show keybindings for possible keymaps with a popup
  {
    "folke/which-key.nvim",
    event = "VeryLazy", -- Sets the loading event to 'VimEnter'
    opts = {
      -- Document existing key chains
      spec = {
        { "<leader>s", group = "[S]earch" },
        { "<leader>w", group = "[W]indow" },
        {
          "<leader>d",
          group = "[D]ropbar",
          -- condition = function()
          --   local ft = vim.bo.filetype
          --   local excluded = { "netrw", "NvimTree", "alpha" } -- 排除的文件类型列表
          --   return not vim.tbl_contains(excluded, ft)
          -- end,
        },
      },
    },
  },

  -- statusline
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup()
    end,
  },

  -- 只使用winbar也就是面包屑，目前的配置还启用了tab栏，看看后面怎么禁用
  {
    "rebelot/heirline.nvim",
    event = "VeryLazy",
    config = function(_, opts)
      opts.winbar = nil
    end,
  },
  -- 面包屑下拉菜单
  -- A polished, IDE-like, highly-customizable winbar for Neovim
  -- with drop-down menu support and multiple backends
  {
    "Bekaboo/dropbar.nvim",
    event = "VeryLazy",
    config = function()
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
