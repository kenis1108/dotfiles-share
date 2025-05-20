" ================
" options
" ================
set packpath+=~/Desktop/vim_scratch

set nocompatible

filetype plugin indent on
syntax enable

set cursorline
set cursorlineopt=both
set relativenumber
set termguicolors
set clipboard=unnamed,unnamedplus
set completeopt=menu,menuone,noselect
set backspace=indent,eol,start
set scrolloff=4
set sidescrolloff=8
set breakindent
set linebreak
set wildmenu
set wildmode=longest:full,full
set signcolumn
" set fillchars=foldopen:,foldclose:,fold:\ ,foldsep:\ ,diff:╱,eob:\ 

set confirm
set autowrite

set splitright
set splitbelow

set shiftwidth=2
set tabstop=2
set expandtab
set shiftround

set foldmethod=indent
set foldlevel=99



colorscheme catppuccin_mocha

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
