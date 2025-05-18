return {
  -- syntax highlighting. Highlight, edit, and navigate code
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" }, -- 文件打开时加载
    dependencies = {
      -- 增强代码折叠
      {
        "nvim-treesitter/nvim-treesitter-context",
        config = function()
          -- 使用 Tree-sitter 增强折叠
          vim.opt.foldmethod = "expr"
          vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
          vim.opt.foldlevel = 99 -- 初始不折叠所有代码
        end,
      },
      -- 语法感知的 textobjects
      -- "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "bash",
          "css",
          "diff",
          "html",
          "javascript",
          "jsdoc",
          "json",
          "jsonc",
          "lua",
          "luadoc",
          "markdown",
          "markdown_inline",
          "nix",
          "powershell",
          "python",
          "scss",
          "toml",
          "tsx",
          "typescript",
          "vim",
          "vimdoc",
          "vue",
          "xml",
          "yaml",
          "regex",
        },
        auto_install = true,
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },
}
