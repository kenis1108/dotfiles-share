return {
  -- 有lsp了还需要treesitter吗?
  -- lsp 提供智能编程功能（补全、跳转、诊断等）
  -- treesitter 解析代码生成语法树，用于语法高亮、代码折叠等

  -- mason.nvim 主要功能是安装和管理开发工具，比如 LSP 服务器、DAP 适配器、格式化工具（如 stylua）和 linters（如 luacheck）。
  -- 避免在不同系统上安装工具，比如省去手动scoop install stylua
  {
    "mason-org/mason.nvim",
    config = function()
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })
    end,
  },

  -- mason-lspconfig.nvim 是 mason.nvim 和 nvim-lspconfig 的桥梁，主要用于自动配置由 mason 安装的 LSP 服务器
  {
    "mason-org/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        automatic_enable = {
          "lua_ls",
          "vimls",
        },
      })
    end,
  },

  -- 配置需要自动安装工具
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    config = function()
      require("mason-tool-installer").setup({
        ensure_installed = {
          -- lsp
          "lua-language-server",

          -- formatter
          "stylua",
        },

        start_delay = 3000,
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
  },
}
