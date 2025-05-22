" ===============================================================================
" Author: Kenneth <kennisdsg@outlook.com>
" Create Date: 2023-10-23
" Desc:  (Neo)Vim 配置文件❤(vimrc for Unix/Linux/Windows/Mac, GUI/Console)
" ===============================================================================


" ===============================================================================
" 本配置文件使用自动命令组实现Vim代码折叠功能(手动折叠标记)，使配置文件更简洁。
" 使用说明：切换至普通模式，将光标移动到这些文字中的任意一行，然后敲击 za 进行
" 代码折叠。Vim 会折叠从包含 {{{ 的行到包含 }}} 的行之间的所有行，再敲击 za 会
" 展开所有这些行
" 折叠命令：
"     za         打开或关闭当前折叠(open a closed fold, close an open fold)
"     zc         折叠(close a fold)
"     zo         展开折叠(close a fold)
"     zM         关闭所有折叠(set 'foldlevel' to zero)
"     zR         打开所有折叠(set 'foldlevel' to zero)
" ===============================================================================

" 自动代码折叠函数 (Vimscript File Settings) {{{
" 自动命令组实现 Vim 代码折叠函数，使用 Vim 默认 标志折叠（marker）来折叠代码
augroup filetype_vim
    " 开头增加 autocmd! 命令，以确保没有重复的自动命令存在
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

" }}}

" Appearance Configuration {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nu                            " 显示当前行号
set rnu                           " 显示相对行号
" set cuc cul                       " 高亮显示当前列和行
" colorscheme deserti             " 主题配置 $VIM\colors里有可以选择的项

" }}}

" Base Configuration {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax on                         " 语法高亮
filetype plugin indent on         " 文件类型检测
set et ts=2                       " 使用两个空格代替Tab进行缩进
set autowrite                     " 自动保存文件
set shiftwidth=2                  " >> 或 << 键时缩进或反缩进的空格数
set path+=$pwd/**                 " 需要搜索的路径,添加递归查找当前目录的子文件
set splitbelow                    " 终端始终在底部显示 分割窗口时新窗口在当前窗口之下
set autochdir                     " 当打开一个文件时，自动切换到该文件所在的目录
" set nocompatible                  " 关闭vi兼容模式(vim需要，nvim不需要)
" set noswapfile                    " 禁止生成临时文件
set backspace=indent,eol,start    " 解决Backspace键不能用的问题
set showcmd                       " 始终显示按键命令
set clipboard=unnamed,unnamedplus " 默认使用系统剪贴板
set termguicolors                 " 启用True Color 模式
" hi Normal guibg=NONE              " 设置活动窗口编辑区域背景透明          
" hi NormalNC guibg=NONE            " 设置非活动窗口编辑区域背景透明
" }}}

" Netrw Configuration {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 使用流程（两种情况）
" 1. 如果打开目录先用<P>打开第一次要打开的文件，后续切回netrw后用<CR>打开文件，就能保证netrw时刻在左边
" 2. 如果打开了文件，那么使用:Vex打开netrw，后续切回netrw后用<CR>打开文件，就能保证netrw时刻在左边
let g:netrw_banner = 0            " 隐藏顶部的Banner
let g:netrw_preview = 1           " 按<p>进行预览或<P>前次窗口的时候纵向分割窗口·
let g:netrw_altv = 1              " 纵向分割时总是在右边
let g:netrw_browse_split = 4      " 按<cr>的时候跟<P>一样在前次窗口打开
let g:netrw_winsize = 25          " 配置Netrw的宽度为窗口的25%
let g:netrw_liststyle = 3         " 配置Netrw显示样式: 3-树形

augroup ProjectDrawer
  autocmd!
  " 自动打开 Netrw，并根据参数判断是否切换回主窗口
  autocmd VimEnter * 
    \ :Vexplore | 
    \ if argc() > 0 && filereadable(argv(0)) | wincmd p | endif
  
augroup END
  

" }}}

" vimrc 配置文件按键映射 {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let $MY_VIMRC_PATH = '~/.config/vim/my-base.vim'

nnoremap <Leader>tv :tabe $MY_VIMRC_PATH<CR>           " 新标签页编辑配置文件
nnoremap <Leader>ev :e $MY_VIMRC_PATH<CR>              " 当前窗口编辑配置文件
nnoremap <Leader>vv :vsp $MY_VIMRC_PATH<CR>            " 纵向分屏编辑配置文件
nnoremap <Leader>sv :so $MYVIMRC<CR>                   " 重新加载 vimrc 文件

" 监听 以vimrc结尾和.vim的文件 变更立即生效
augroup AutoSourceVimrc
  autocmd!
  autocmd BufWritePost *vimrc,*.vim :so $MYVIMRC
augroup END

" }}}

" 设置括号自动补齐 {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
inoremap ( ()<LEFT>
inoremap [ []<LEFT>
inoremap { {}<LEFT>
inoremap " ""<LEFT>
inoremap ' ''<LEFT>
inoremap < <><LEFT>

" }}}
