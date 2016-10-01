" PLUGINS {{{1

" Install vim-plug if missing:
let pluginstall=system("[ -e ~/.config/nvim/autoload/plug.vim ] ; echo $?")
if pluginstall != 0
    call system("curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim")
    so ~/.config/nvim/autoload/plug.vim
endif

call plug#begin()

" install fzf fuzzy searcher system wide
" shell commands:
"     Ctrl-T: paste file to cli
"     Ctrl-R: paste command from history to cli
"     Alt-C:  cd into selected directory
"     '**':   extends to file
" vim commands:
"     :FZF <dir>
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" fzf-based commands and mappings
" vim commands:
"     :Files    -> Files
"     :GFiles   -> Git Files
"     :Buffers  -> Open buffers
"     :Helptags -> Help tags
"     ...       -> ...
" select with
"     <C-s> to open below
"     <C-v> to open right
"     <C-t> to open in tab
Plug 'junegunn/fzf.vim'

" automated alignment
" 1. `ga` key in visual mode or `ga` followed by motion/object
" 2. (optional) Enter key to cycle alignment mode (left, right, center)
" 3.  N-th delimiter (default = 1)
"     1, 2, -1, -2, ...
"     * means all
"     ** means left-right alternating alignment around all
Plug 'junegunn/vim-easy-align'

" colorscheme
Plug 'justinmk/molokai'

call plug#end()

" MISC {{{1

" always keep n lines visible under the cursor
set scrolloff=1

"show trailing whitespace, tabs
set list

" split windows in a way so that existing text doesn't move.
set splitbelow
set splitright

" stay in terminal mode by default
augroup terminal
    autocmd!
    autocmd BufWinEnter,WinEnter term://* startinsert
    autocmd BufLeave term://* stopinsert
augroup END

" LOOK {{{1

" enable true colors
set termguicolors

set background=dark
colorscheme molokai

" KEYBINDINGS {{{1

" navigate splits with <A-hjkl>
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l
vnoremap <A-h> <C-w>h
vnoremap <A-j> <C-w>j
vnoremap <A-k> <C-w>k
vnoremap <A-l> <C-w>l
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l

" leave terminal mode with jj and Esc
tnoremap <Esc> <C-\><C-n>
tnoremap jj <C-\><C-n>

" leave insert mode with jj (and Esc...)
inoremap jj <Esc>

" adjust for german keyboard layout:
noremap ö [
noremap ä ]
noremap Ö {
noremap Ä }
noremap	ß /

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Use <C-l> to clear the highlighting of :hlsearch
nnoremap <silent> <C-l> :nohlsearch<C-r>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-l>

" LEADER BINDINGS {{{1

let mapleader = "\<Space>"
let maplocalleader = "-"

nnoremap <leader>g <C-]>
nnoremap <leader>f :Files<CR>

" vim:foldmethod=marker:foldlevel=0:foldenable
