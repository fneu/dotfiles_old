
" Plugins {{{
"
" needs vim-plug: https://github.com/junegunn/vim-plug
"
" vim install: curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"              https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"
" nvim install: curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
"               https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

call plug#begin('~/.vim/plugged')

Plug 'ap/vim-css-color'

Plug 'crusoexia/vim-monokai'

Plug 'freeo/vim-kalisi'

Plug 'justinmk/molokai'

Plug 'altercation/vim-colors-solarized'

Plug 'https://github.com/romainl/flattened'

Plug 'jonathanfilip/vim-lucius'

Plug 'https://github.com/nanotech/jellybeans.vim'

Plug 'w0ng/vim-hybrid'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
" Fuzzy Finder vor bash, zsh, and vim
"
" completion in zsh: **<tab>
"
" VIM
" Find Files under current directory:
" :FZF
"
" Find Files under home dir:
" :FZF ~
"
" CTRL-J / CTRL-K to select,
" ESC to exit
" CTRL-T to open in new tab
" CTRL-V to open in vertical split
" CTRL-X to open in horizontal split
"
" syntax:
" search term separated by spaces
" ^ and $ for start and end
" ' match exactly
" ! don't match
"
Plug 'junegunn/fzf.vim'

call plug#end()

let g:monokai_term_italic=1
let g:monokai_gui_italic=1

filetype plugin indent on

" enable true colors or 256 colors
if has('nvim')
	" needed in 0.1.5 I think
	"set termguicolors
	let $NVIM_TUI_ENABLE_TRUE_COLOR=1
elseif !has('gui_running')
	set t_Co=256
	let &t_AB="\e[48;5;%dm"
	let &t_AF="\e[38;5;%dm"
endif

syntax on
set background=dark
colorscheme lucius


" make terminal usable
"
:tnoremap <Esc> <C-\><C-n>
:tnoremap jj <C-\><C-n>
autocmd BufWinEnter,WinEnter term://* startinsert
autocmd BufLeave term://* stopinsert
:tnoremap <C-h> <C-\><C-n><C-w>h
:tnoremap <C-j> <C-\><C-n><C-w>j
:tnoremap <C-k> <C-\><C-n><C-w>k
:tnoremap <C-l> <C-\><C-n><C-w>l
:nnoremap <C-h> <C-w>h
:nnoremap <C-j> <C-w>j
:nnoremap <C-k> <C-w>k
:nnoremap <C-l> <C-w>l

" split windows in a way so that existing text doesn't move.
set splitbelow
set splitright

" exit insert mode with jj
inoremap jj <Esc>
