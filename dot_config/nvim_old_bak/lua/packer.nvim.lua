-- 自动安装packer.nvim
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- LSP config
  use {
    "williamboman/mason.nvim",          -- 方便安装和管理各种语言的LSPserver
    "williamboman/mason-lspconfig",     -- 连接mason和lspconfig,自动安装和自动 setup LSPserver    
    "neovim/nvim-lspconfig"             -- 快速配置lsp,lsp配置管理 
  }
  -- 增强LSP交互
  use ({
    'nvimdev/lspsaga.nvim',
    after = 'nvim-lspconfig',
    config = function()
      require('lspsaga').setup({})
    end,
  })

  -- nvim-cmp 自动补全
  use {
    "hrsh7th/cmp-nvim-lsp",  -- 补全源：通过LSP补全
    "hrsh7th/cmp-buffer",    -- 补全源：通过当前文本补全
    "hrsh7th/cmp-path",      -- 补全源：路径补全    
    "hrsh7th/cmp-cmdline",   -- 补全源：命令补全
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-vsnip",     -- 补全源：vim-vsnip代码片段引擎
    "hrsh7th/vim-vsnip",     -- 代码片段引擎
    "rafamadriz/friendly-snippets", -- 好用的代码片段
    "onsails/lspkind.nvim"   -- 给补全列表添加补全片段的来源
  }
  -- codeium补全
  -- use {
  --   "Exafunction/codeium.nvim",
  --   requires = {
  --     "nvim-lua/plenary.nvim",
  --     "hrsh7th/nvim-cmp",
  --   },
  --   config = function()
  --     require("codeium").setup({
  --     })
  --   end
  -- }

  -- nvim-treesitter 语法高亮，格式化
  -- Windows下需要安装（scoop install gcc）
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
    requires = { "JoosepAlviste/nvim-ts-context-commentstring" } -- tsx/jsx注释，须在Comment的pre_hook里配置下
  }

  -- Comment 快速注释（不支持jsx/tsx）
  use 'numToStr/Comment.nvim'

  -- autopairs 自动成对括号
  " use "windwp/nvim-autopairs"
  use "m4xshen/autoclose.nvim"

  -- colorscheme 主题
  use 'Mofiqul/dracula.nvim'
  -- indent-blankline 缩进
  use 'lukas-reineke/indent-blankline.nvim'
  -- use 'nvimdev/indentmini.nvim'
  -- bufferline 标签页
  -- use {'akinsho/bufferline.nvim', tag = "*", requires = 'nvim-tree/nvim-web-devicons'}
  -- nvim-cursorline 高亮当前行列及单词
  use "yamatsum/nvim-cursorline"
  -- statusline 状态栏
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }

  -- startuptime 查看启动用的时间
  -- use 'dstein64/vim-startuptime'

  -- nvim-tree 文件资源管理器
  use { 'nvim-tree/nvim-tree.lua', requires = { 'nvim-tree/nvim-web-devicons', } }

  -- gitsigns git支持
  use 'lewis6991/gitsigns.nvim'

  -- telescope 模糊搜索
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.4',
    -- or                            , branch = '0.1.x',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  -- which-key 快捷键提示
  use "folke/which-key.nvim"

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)

