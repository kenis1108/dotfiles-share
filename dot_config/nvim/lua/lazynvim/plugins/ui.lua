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
      vim.keymap.set("n", "<Leader>e", MiniFiles.open, { desc = "[E]xplorer (mini.files)" })
    end,
  },

  -- show keybindings for possible keymaps with a popup
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      spec = {
        { "g", group = "[G]oto" },
        { "s", group = "[S]urround" },
        { "z", group = "Fold" },
        { "<leader>a", group = "[A]I" },
        {
          "<leader>b",
          group = "[B]uffer",
          expand = function()
            return require("which-key.extras").expand.buf()
          end,
        },
        { "<leader>d", group = "[D]ropbar" },
        { "<leader>s", group = "[S]earch" },
        {
          "<leader>w",
          group = "[W]indows",
          proxy = "<c-w>",
          expand = function()
            return require("which-key.extras").expand.win()
          end,
        },
        {
          "<leader>?",
          function()
            require("which-key").show()
          end,
          desc = "Show Keymaps (which-key)",
        },
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

  -- completely replaces the UI for messages, cmdline and the popupmenu
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      routes = {
        -- 弹窗 显示 recording @
        -- NOTE: See https://github.com/folke/noice.nvim/wiki/A-Guide-to-Messages#showmode
        {
          view = "notify",
          filter = { event = "msg_showmode" },
        },
        -- 底部状态栏 显示 "written" 消息
        {
          view = "mini", -- 显示区域配置选项 命令行区域: cmdline, 底部状态栏: mini, 通知弹窗: notify
          filter = {
            event = "msg_show",
            find = "written",
          },
          opts = { title = "💾 File Saved" },
        },
      },
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
        },
      },
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false, -- add a border to hover docs and signature help
      },
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    },
  },
}
