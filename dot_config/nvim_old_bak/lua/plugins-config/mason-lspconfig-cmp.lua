-- Set up nvim-cmp.
local cmp = require('cmp')
local lspkind = require('lspkind')

local lspconfig = require('lspconfig')
local lsp_defaults = lspconfig.util.default_config

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' }, -- For vsnip users.
    -- { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
    { name = 'buffer' },
    -- { name = 'codeium' }
  }),

  -- 使用onsails/lspkind.nvim显示补全片段的来源
  formatting = {
    format = lspkind.cmp_format({
      -- mode = "symbol",
      -- symbol_map = { Codeium = "", },
      with_text = true, -- do not show text alongside icons
      maxwidth = 50,    -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
      before = function(entry, vim_item)
        -- Source 显示提示来源
        vim_item.menu = "[" .. string.upper(entry.source.name) .. "]"
        return vim_item
      end
    })
  },
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
  }, {
      { name = 'buffer' },
    })
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
      { name = 'cmdline' }
    })
})

require("mason").setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  }
})

require("mason-lspconfig").setup({
  -- 需要自动安装的lspserver
  ensure_installed = { "lua_ls", "tsserver", "jsonls", "marksman", "vimls", "html", "cssls", "taplo" }
})

-- 使用 vim.tbl_deep_extend 来合并 lspconfig 提供的默认值和 nvim-cmp 添加的功能
lsp_defaults.capabilities = vim.tbl_deep_extend(
  'force',
  lsp_defaults.capabilities,
  require('cmp_nvim_lsp').default_capabilities()
)


-- 自动setup所有已经安装的lspserver
require("mason-lspconfig").setup_handlers {
  -- 默认自动setup没有配置的lsp
  function (server_name) -- default handler (optional)
    require("lspconfig")[server_name].setup{}
  end,
  -- 单独覆盖上面某个自动setup的配置
  -- ["lua_ls"] = function ()
  --   local lspconfig = require("lspconfig")
  --   lspconfig.lua_ls.setup {
  --     settings = {
  --       Lua = {
  --         diagnostics = {
  --           globals = { "vim" }
  --         }
  --       }
  --     }
  --   }
  -- end,
}
