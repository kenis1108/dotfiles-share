" ================
" options
" ================
filetype plugin indent on
syntax enable

set nocompatible
set encoding=utf-8
set relativenumber
set termguicolors
set clipboard=unnamed,unnamedplus
set completeopt=menu,menuone,noselect
set backspace=indent,eol,start
set breakindent
set linebreak
set updatetime=300

set list
set listchars=tab:>-,eol:\ ,nbsp:%,trail:-

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

set undofile
set undolevels=10000

" set spell
" set spelllang=en,zh

" ================
" autocmd
" ================
" 定义高亮组和自动命令
" 1. 确保定义高亮组（黄色背景）
highlight YankHighlight ctermbg=Yellow guibg=#ff966c

" 2. 自动命令组
augroup HighlightYank
  autocmd!
  autocmd TextYankPost * call s:HighlightYank(visualmode())
augroup END

" 3. 核心高亮函数
function! s:HighlightYank(mode)
  " 清除旧高亮和定时器
  silent! call matchdelete(get(w:, 'yank_highlight_id', -1))
  silent! call timer_stop(get(w:, 'yank_timer_id', -1))

  " 获取选区边界（兼容所有模式）
  let [start_lnum, start_col] = [line("'["), col("'[") - 1]  " 列号转0-based
  let [end_lnum, end_col] = [line("']"), col("']") - 1]

  " 构建匹配模式
  let pattern = ''
  if a:mode ==# 'V' || (a:mode == '' && start_lnum != end_lnum)
    " 行模式或yy整行操作
    let pattern = printf('\%%>%dl\%%<%dl', start_lnum - 1, end_lnum + 1)
  elseif a:mode ==# "\<C-v>"
    " 块模式（矩形选区）
    let pattern = printf('\%%>%dl\%%<%dl\%%>%dc\%%<%dc',
          \ start_lnum - 1, end_lnum + 1,
          \ min([start_col, end_col]),
          \ max([start_col, end_col]) + 1)
  else
    " 字符模式（处理跨行选择）
    if start_lnum == end_lnum
      " 单行选择
      let pattern = printf('\%%%dl\%%>%dc\%%<%dc',
            \ start_lnum, min([start_col, end_col]),
            \ max([start_col, end_col]) + 1)
    else
      " 跨行选择（三段式匹配）
      let pattern = printf('\(\%%%dl\%%>%dc\)\|\(\%%>%dl\%%<%dl\)\|\(\%%%dl\%%<%dc\)',
            \ start_lnum, min([start_col, end_col]),
            \ start_lnum, end_lnum,
            \ end_lnum, max([start_col, end_col]) + 1)
    endif
  endif

  " 安全应用高亮
  if !empty(pattern)
    let w:yank_highlight_id = matchadd('YankHighlight', pattern)
    let w:yank_timer_id = timer_start(300, {-> execute('silent! call matchdelete('.w:yank_highlight_id.')')})
  endif
endfunction

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

" ================
" plugins
" ================
let g:custom_packpath = expand('~/Desktop/vim_scratch')
if !isdirectory(g:custom_packpath)
  call mkdir(g:custom_packpath, 'p')
endif

let &packpath = g:custom_packpath . ',' . &packpath " 添加到 packpath 的开头

colorscheme catppuccin_mocha

" TODO: 添加判断是否有同名的插件存在，存在再加载对应配置文件
for f in glob('./plugins-config/*.vim', 1, 1)
  execute 'source' f
endfor
