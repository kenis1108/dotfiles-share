return {
  -- 有lsp了还需要treesitter吗?
  -- lsp 提供智能编程功能（补全、跳转、诊断等）
  -- treesitter 解析代码生成语法树，用于语法高亮、代码折叠等
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- mason.nvim 主要功能是安装和管理开发工具，比如 LSP 服务器、DAP 适配器、格式化工具（如 stylua）和 linters（如 luacheck）。
      -- 避免在不同系统上安装工具，比如省去手动scoop install stylua
      {
        "mason-org/mason.nvim",
        opts = {
          ui = {
            icons = {
              package_installed = "✓",
              package_pending = "➜",
              package_uninstalled = "✗",
            },
          },
        },
      },

      -- mason-lspconfig.nvim 是 mason.nvim 和 nvim-lspconfig 的桥梁，主要用于自动安装LSP和自动配置由 mason 安装的 LSP 服务器到nvim-lspconfig中
      {
        "mason-org/mason-lspconfig.nvim",
        opts = {},
      },

      -- 配置需要自动安装的工具，mason-lspconfig不支持自动安装非 LSP 工具（如代码格式化器、静态分析工具等），所以使用这个插件来自动安装所有的开发工具并确保它们与 mason.nvim 同步更新
      {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        opts = {
          ensure_installed = {
            -- lsp
            "lua-language-server",
            "vue-language-server",
            "html-lsp",
            "css-lsp",
            "css-variables-language-server",
            "cssmodules-language-server",
            "eslint-lsp",
            "python-lsp-server",
            "pyright",

            -- formatter
            "stylua",
            "prettier",
            "prettierd",
            "black",
            "isort",
          },

          start_delay = 3000,
        },
      },
    },
    config = function()
      require("lspconfig").lua_ls.setup({
        settings = {
          Lua = {
            hint = {
              enable = true, -- necessary
            },
          },
        },
      })
    end,
  },
}
