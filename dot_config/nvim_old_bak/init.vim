" 基础配置（同Vim）| Base configuration (same as Vim)
execute 'source ' . expand('~/.config/vim/my-base.vim')

" 加载插件配置（很久之前使用插件管理器的配置了，现在不想使用插件管理器了，喜欢自己手动安装插件） | Load plugin configuration {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" lua << EOF
" require('packer.nvim')
" require('plugins-config.mason-lspconfig-cmp')
" require('plugins-config.nvim-treesitter')
" require('plugins-config.Comment')
" require('plugins-config.nvim-autopairs')
" require('plugins-config.indent-blankline')
" require('plugins-config.indentmini')
" require('plugins-config.bufferline')
" require('plugins-config.nvim-cursorline')
" require('plugins-config.lualine')
" require('plugins-config.nvim-web-devicons')
" require('plugins-config.nvim-tree')
" require('plugins-config.gitsigns')
" require('plugins-config.telescope')
" require('plugins-config.which-key')
" EOF

" 监听packer.nvim.lua,改变自动更新插件
" augroup packer_user_config
"   autocmd!
"   autocmd BufWritePost packer.nvim.lua source <afile> | PackerCompile
" augroup end

" }}}

" 使Windows和Linux用同一个配置文件路径坏和插件安装路径 {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set packpath+=~/.local/share/nvim/site
" 设置 package.path 以支持跨平台路径
lua << EOF
package.path = package.path .. ';' .. vim.fn.expand('~') .. '/.config/nvim/lua/?.lua'
EOF

" }}}

" NeoVim原生包管理机制手动安装的插件配置 | Manual plugin configurations {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 手动安装插件命令: mkdir -p ~/.local/share/nvim/site/pack/manual/start;git clone https://github.com/nvim-lualine/lualine.nvim ~/.local/share/nvim/site/pack/manual/start/lualine;git clone https://github.com/nvim-tree/nvim-web-devicons ~/.local/share/nvim/site/pack/manual/start/nvim-web-devicons;git clone https://github.com/catppuccin/nvim.git ~/.local/share/nvim/site/pack/manual/start/catppuccin;git clone https://github.com/nvimdev/indentmini.nvim.git ~/.local/share/nvim/site/pack/manual/start/indentmini;git clone https://github.com/m4xshen/autoclose.nvim.git ~/.local/share/nvim/site/pack/manual/start/autoclose

" 插件安装目录
let s:plugin_dir = expand('~/.local/share/nvim/site/pack/manual/start/')

" 自动安装插件的函数
function! PluginAutoInstall(plugin_name, repo_url)
  let install_path = s:plugin_dir . a:plugin_name
  if !isdirectory(s:plugin_dir)
    call mkdir(s:plugin_dir, 'p')
  endif
  if empty(glob(install_path))
    call system('git clone ' . a:repo_url . ' ' . install_path)
    echo 'Installed Plugin ' . a:plugin_name
  else
    "echo a:plugin_name . ' is already installed'
  endif
endfunction

call PluginAutoInstall('lualine', 'https://github.com/nvim-lualine/lualine.nvim')
call PluginAutoInstall('bufferline', 'https://github.com/akinsho/bufferline.nvim')
call PluginAutoInstall('nvim-web-devicons', 'https://github.com/nvim-tree/nvim-web-devicons')
call PluginAutoInstall('catppuccin', 'https://github.com/catppuccin/nvim.git')
call PluginAutoInstall('indentmini', 'https://github.com/nvimdev/indentmini.nvim.git')
call PluginAutoInstall('autoclose', 'https://github.com/m4xshen/autoclose.nvim.git')

" 加载 Lua 配置文件 | Load Lua configurations
lua require('plugins-config.lualine')
lua require('plugins-config.bufferline')
lua require('plugins-config.indentmini')
lua require('plugins-config.autoclose')

" }}}

" 主题设置 | Theme settings
colorscheme catppuccin-mocha " 可选主题 catppuccin-latte catppuccin-frappe catppuccin-macchiato catppuccin-mocha
