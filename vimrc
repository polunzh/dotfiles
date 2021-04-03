"---------------------------------------------
" File: $HOME/.vimrc
" 参考:https://github.com/s3rvac/dotfiles/blob/master/vim/.vimrc
"
"---------------------------------------------

"---------------------------------------------
" 插件-Vundle ---------------------------------------------
set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=/usr/local/opt/fzf

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
" call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/syntastic'
Plugin 'vim-airline/vim-airline'
Plugin 'junegunn/fzf.vim'
Plugin 'dracula/vim'
Plugin 'fatih/vim-go'
Plugin 'jiangmiao/auto-pairs'
"Plugin 'pangloss/vim-javascript'
"Plugin 'ternjs/tern_for_vim'
"Plugin 'leafgarland/typescript-vim'
"Plugin 'heavenshell/vim-jsdoc'
"Plugin 'prettier/vim-prettier'
"Plugin 'vim-airline/vim-airline-themes'
"Plugin 'editorconfig/editorconfig-vim'
"Plugin 'MattesGroeger/vim-bookmarks'
"Plugin 'tpope/vim-fugitive'
"Plugin 'junegunn/yo.vim'
"Plugin 'mattn/emmet-vim'
"Plugin 'NLKNguyen/papercolor-theme'
"Plugin 'rizzatti/dash.vim'

call vundle#end()            " required
filetype plugin indent on    " required

"---------------------------------------------
" 通用
"---------------------------------------------
set number relativenumber       " Show "hybrid" line numbers, include "relative line number" and "absolute line number".
set nocompatible                " Disable vi compatibility.
set undolevels=200              " Number of undo levels.
set scrolloff=10                " Keep a context (rows) when scrolling vertically.
set sidescroll=5                " Keep a context (columns) when scrolling horizontally.
set tabpagemax=1000             " Maximum number of tabs to open by the -p argument.
" set esckeys                     " Cursor keys in insert mode, disable in nvim.
set ttyfast                     " Improves redrawing for newer computers.
set lazyredraw                  " Don't redraw during complex operations (e.g. macros).
set autowrite                   " Automatically save before :next, :make etc.
set confirm                     " Ask to save file before operations like :q or :e fail.

set backspace=indent,eol,start " Allow backspacing over everything in insert mode.
inoremap <expr> <CR> pumvisible() ? "\<C-Y>" : "\<CR>" "使用enter选择suggest
" hlsearch
set hlsearch
set incsearch
" Press Space to turn off highlighting and clear any message already displayed.
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" Backup and swap files.
set nobackup            " Disable backup files.
set noswapfile          " Disable swap files.
set nowritebackup       " Disable auto backup before overwriting a file.

" highlight
set cursorline
set cursorcolumn

" History
set history=1000        " Number of lines of command line history.
set viminfo='100,\"500,r/mnt,r~/mnt,r/media " Read/write a .viminfo file.
set viminfo+=h          " Do not store searches.

" Splitting.
set splitright          " Open new vertical panes in the right rather than left.
set splitbelow          " Open new horizontal panes in the bottom rather than top.

" Security.
set secure              " Forbid loading of .vimrc under $PWD.
set nomodeline          " Modelines have been a source of vulnerabilities.
set autoread
syntax on

" Color: {{{
  set background=dark
  " colorscheme delek
  colorscheme dracula
" }}}

filetype indent on      " Turn off indention by filetype.
" Override the previous settings for all file types (some filetype plugins set
" these options to different values, which is really annoying).
au FileType * set autoindent nosmartindent nocindent fo+=q fo-=r fo-=o fo+=j
set laststatus=2

" Whitespace.  set tabstop=4           " Number of spaces a tab counts for.
set tabstop=2
set shiftwidth=2        " Number of spaces to use for each step of indent.
set shiftround          " Round indent to multiple of shiftwidth.
set expandtab         " Do not expand tab with spaces.

" Wrapping.
set wrap                " Enable text wrapping.
set linebreak           " Break after words only.
set display+=lastline   " Show as much as possible from the last shown line.
set textwidth=0         " Don't automatically wrap lines.
" Disable automatic wrapping for all files (some filetype plugins set this to
" a different value, which is really annoying).
au FileType * set textwidth=0
" set clipboard=unnamed

"------------------------------------------------------------------------------
" Typos correction.
"------------------------------------------------------------------------------

if has("multi_byte")
    " UTF-8 编码
    set encoding=utf-8
    set termencoding=utf-8
    set formatoptions+=mM
    set fencs=utf-8,gbk
    if v:lang =~? '^/(zh/)/|/(ja/)/|/(ko/)'
        set ambiwidth=double
    endif
    if has("win32")
        source $VIMRUNTIME/delmenu.vim
        source $VIMRUNTIME/menu.vim
        language messages zh_CN.utf-8
    endif
else
    echoerr "Sorry, this version of (g)vim was not compiled with +multi_byte"
endif

let mapleader = "\<Space>"

"---------------------------------------------
" Plugins
"---------------------------------------------

" NERDTree

" 打开vim时自动打开NERDTree
" autocmd vimenter * NERDTree

" 打开编辑器时鼠标默认在编辑区域
autocmd vimenter * wincmd p
" 如果打开vim的时候没有指定文件，则自动打开NERDTree
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" 如果只剩下一个NERDTree窗口，则关闭vim
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let NERDTreeQuitOnOpen=0

let NERDTreeIgnore=['\.pyc$', '\.git', '\.DS_Store', '\.svn', 'coverage', '__pycache', '\.vscode']
" 快捷键设置
map <C-e> :NERDTreeToggle<CR>
" end NERDTree


" FZF
" prevent fzf buffers in nerdtree
let g:fzf_layout = { 'window': 'let g:launching_fzf = 1 | keepalt topleft 100split enew' }
autocmd FileType nerdtree let t:nerdtree_winnr = bufwinnr('%')
autocmd BufWinEnter * call PreventBuffersInNERDTree()

function! PreventBuffersInNERDTree()
  if bufname('#') =~ 'NERD_tree' && bufname('%') !~ 'NERD_tree'
    \ && exists('t:nerdtree_winnr') && bufwinnr('%') == t:nerdtree_winnr
    \ && &buftype == '' && !exists('g:launching_fzf')
    let bufnum = bufnr('%')
    close
    exe 'b ' . bufnum
  endif
  if exists('g:launching_fzf') | unlet g:launching_fzf | endif
endfunction

nmap <C-p> :Files<CR>

" end FZF
"
"" Powerline configuration
"set t_Co=256
"let g:Powerline_symbols = 'fancy'
"let Powerline_symbols = 'compatible'
"
"" syntastic
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
"let g:syntastic_javsacript_checkers = ['eslint']
"
" Prettier
"nmap <Leader>f <Plug>(Prettier)

" noremap
noremap gh <C-W>h
noremap gk <C-W>k
noremap gl <C-W>l
noremap gj <C-W>j

" save
noremap <Leader>s :update<CR>

inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"
inoremap <expr> <Esc> pumvisible() ? "\<C-e>" : "\<Esc>"
inoremap <expr> <TAB> pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <TAB> pumvisible() ? "\<C-p>" : "\<Up>"
