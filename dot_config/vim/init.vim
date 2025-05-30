" ===============================================================================
" Author: Kenneth <kennisdsg@outlook.com>
" Create Date: 2023-10-23
" Desc:  (Neo)Vim 配置文件❤(vimrc for Unix/Linux/Windows/Mac, GUI/Console)
" ===============================================================================

let g:vim_start_time = reltime()

" ===============
" packpath
" ===============
let g:custom_packpath = expand('~/.config/vim')
if !isdirectory(g:custom_packpath)
  call mkdir(g:custom_packpath, 'p')
endif

let &packpath = g:custom_packpath . ',' . &packpath " 添加到 packpath 的开头

" ================
" options
" ================
filetype plugin indent on
syntax enable

set encoding=utf-8
set fileencoding=utf-8
set nocompatible
set number relativenumber
set termguicolors
set clipboard=unnamed,unnamedplus
set completeopt=menu,menuone,noselect
set backspace=indent,eol,start
set breakindent
set linebreak
set updatetime=300
set mouse=a
set autochdir

set hlsearch
set incsearch

set list
set listchars=tab:»\ ,nbsp:␣,trail:·,eol:\ 

set signcolumn=yes
" set fillchars=foldopen:,foldclose:,fold:\ ,foldsep:\ ,diff:╱,eob:\

set winminwidth=5
" set winminheight=5

set cursorline
set cursorlineopt=both

set scrolloff=4
set sidescrolloff=8

set smartcase
set smartindent

set wildmenu
set wildmode=longest:full,full

set confirm
set autoread
set autowrite

set splitright
set splitbelow
set splitkeep=screen

set shiftwidth=2
set tabstop=2
set expandtab
set shiftround

set foldmethod=indent
set foldlevel=99

set modeline
set modelines=2

set noswapfile

" set undofile
" set undolevels=10000

" set spell
" set spelllang=en,zh

" ================
" autocmd
" ================
augroup StartupTime
  autocmd!
  autocmd VimEnter * echom printf('Vim fully loaded in %.2f ms', reltimefloat(reltime(g:vim_start_time)) * 1000)
augroup END

" ================
" keymaps
" ================
let g:mapleader=" "
let g:maplocalleader=" "

" Roload Configuration
nnoremap <leader>rc <cmd>source ~/Desktop/vim_scratch/init.vim<cr>

" Move to window using the <ctrl> hjkl keys
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Resize window using <ctrl> arrow keys
nnoremap <C-Up> <cmd>resize +2<cr>
nnoremap <C-Down> <cmd>resize -2<cr>
nnoremap <C-Left> <cmd>vertical resize -2<cr>
nnoremap <C-Right> <cmd>vertical resize +2<cr>

" Move Lines
nnoremap <A-j> <cmd>execute 'move .+' . v:count1<cr>==
nnoremap <A-k> <cmd>execute 'move .-' . (v:count1 + 1)<cr>==
inoremap <A-j> <esc><cmd>m .+1<cr>==gi
inoremap <A-k> <esc><cmd>m .-2<cr>==gi
vnoremap <A-j> :<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv
vnoremap <A-k> :<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv

" Save File
nnoremap <C-s> <cmd>w<cr><esc>
inoremap <C-s> <cmd>w<cr><esc>
xnoremap <C-s> <cmd>w<cr><esc>
snoremap <C-s> <cmd>w<cr><esc>

" Quit All
nnoremap <C-q> <cmd>qa<cr>
nnoremap <leader>q <cmd>q<cr>

nnoremap <silent> <esc> <cmd>nohlsearch<cr><esc>
inoremap <silent> <esc> <cmd>nohlsearch<cr><esc>
snoremap <silent> <esc> <cmd>nohlsearch<cr><esc>

" 使用 <leader>v 触发可视块模式
nnoremap <leader>v <C-v>
vnoremap <leader>v <C-v>

function! ToggleBackground()
  " 获取当前 Normal 组的高亮设置
  let l:normal_hl = execute('hi Normal')

  " 检查当前 guibg 是否不是 NONE
  if l:normal_hl =~ 'guibg=#1E1E2E'
    " 如果不是 NONE，则清除背景和前景
    hi Normal guifg=NONE guibg=NONE ctermbg=NONE
    hi SignColumn guibg=NONE
  else
    " 如果是 NONE，则恢复默认颜色
    hi Normal guifg=#CDD6F4 guibg=#1E1E2E
    hi SignColumn term=standout ctermfg=11 ctermbg=8 guifg=#45475A guibg=#1E1E2E
  endif
endfunction
" 切换背景透明
nnoremap <Leader>bg :call ToggleBackground()<CR>

" ================
" plugins
" ================
let s:plugins_dir = expand(g:custom_packpath . '/pack/plugins/start')
if !isdirectory(s:plugins_dir)
  call mkdir(s:plugins_dir, 'p')
endif

" ============================================================================
" 函数名称: InstallPlugin
" 功能描述: 通过Git命令安装Vim插件
" 入参格式: 二维数组 [[插件名称, Git命令], ...]
" 返回值:  无
" 依赖项:  s:plugins_dir 变量（插件安装根目录）
" ============================================================================
" 示例调用:
" call InstallPlugin([
" \ ['vim-fugitive', 'git clone https://github.com/tpope/vim-fugitive.git'],
" \ ['coc.nvim', 'git clone --branch release https://github.com/neoclide/coc.nvim'],
" \ ['nerdtree', 'git clone --depth 1 https://github.com/preservim/nerdtree']
" \ ])
" ============================================================================
function! InstallPlugin(plugins)
  for plugin in a:plugins
    if len(plugin) < 2
      echoerr '错误: 插件条目格式应为 [插件名称, Git命令]'
      continue
    endif

    let name = plugin[0]           " 插件名称（安装后的目录名）
    let git_cmd = plugin[1]        " 完整的Git克隆命令（不含目标路径）
    let install_path = s:plugins_dir . '/' . name

    " 检查插件是否已安装
    if !isdirectory(install_path)
      " 构建并执行Git命令
      let cmd = git_cmd . ' ' . shellescape(install_path)
      let result = system(cmd)

      " 检查命令执行结果
      if v:shell_error != 0
        echoerr 'Failed to install plugin: ' . name
        echoerr 'Executed command: ' . cmd
        echoerr 'Error output: ' . result
      else
        echomsg 'Plugin installed successfully: ' . name
      endif
    else
      echomsg 'Plugin already installed: ' . name
    endif
  endfor
endfunction

" 添加判断是否有同名的插件存在，存在再加载对应配置文件
function! LoadPluginConfig()
  for f in glob(g:custom_packpath . '/plugins-config/*.vim', 1, 1)
    " 从配置文件名提取插件名
    let plugin_name = fnamemodify(f, ':t:r')
    " 检查 s:plugins_dir 下是否存在同名插件目录
    if isdirectory(expand(s:plugins_dir . '/' . plugin_name))
      execute 'source' f
      echomsg 'Loaded config for: ' . plugin_name
    else
      echomsg 'Skipped missing plugin: ' . plugin_name
    endif
  endfor
endfunction

" 调试时可以去掉silent，来查看echomsg的输出
silent call InstallPlugin([
\ ['catppuccin', 'git clone https://github.com/catppuccin/vim.git'],
\ ['coc.nvim', 'git clone --branch release https://github.com/neoclide/coc.nvim.git --depth=1'],
\ ['vim-airline', 'git clone https://github.com/vim-airline/vim-airline.git'],
\ ['vim-fugitive', 'git clone https://github.com/tpope/vim-fugitive.git'],
\ ['indentLine', 'git clone https://github.com/Yggdroot/indentLine.git'],
\ ['fzf', 'git clone https://github.com/junegunn/fzf'],
\ ['fzf.vim', 'git clone https://github.com/junegunn/fzf.vim'],
\ ['vim-startify', 'git clone https://github.com/mhinz/vim-startify'],
\ ['vim-surround', 'git clone https://github.com/tpope/vim-surround'],
\ ['vim-sandwich', 'git clone https://github.com/machakann/vim-sandwich'],
\ ])

silent call LoadPluginConfig()
