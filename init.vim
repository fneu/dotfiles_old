" Fabian Neuschmidt

" PLUGINS {{{1

" Install vim-plug if missing:
let pluginstall=system("[ -e ~/.config/nvim/autoload/plug.vim ] ; echo $?")
if pluginstall != 0
    call system("curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim")
    so ~/.config/nvim/autoload/plug.vim
endif

call plug#begin()

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

Plug 'junegunn/fzf.vim'

Plug 'junegunn/vim-easy-align'
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

Plug 'heavenshell/vim-pydocstring'

Plug 'davidhalter/jedi-vim'
" don't use these commands:
let g:jedi#goto_assignments_command = ""
let g:jedi#goto_definitions_command = ""
let g:jedi#completions_command = ""
" use python 3 only:
let g:jedi#force_py_version = 3
" leave completeopt and <C-c> as they are
let g:jedi#auto_vim_configuration = 0

Plug 'tpope/vim-fugitive'

Plug 'justinmk/vim-sneak'

Plug 'justinmk/molokai'

call plug#end()

" INDENTATION {{{1

set tabstop=8 " number of visual spaces per tab
set softtabstop=4 " number of spaces inserted by tab
set shiftwidth=4 " indent size (<< and >>)
set expandtab " <Tab> inserts spaces

" UI-Config {{{1

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

" hides buffers instead of closing them - allows to keep unwritten changes
set hidden

" show relative line numbers as well as the current one
set relativenumber
set number

" show true colors in terminal
set termguicolors

" colorscheme
set background=dark
colorscheme molokai

" colorcolumn after 72 and 79 chars
set colorcolumn=73,80

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
noremap ß /

" Use <C-l> to clear the highlighting of :hlsearch
nnoremap <silent> <C-l> :nohlsearch<C-r>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-l>

" LEADER BINDINGS {{{1

let mapleader = "\<Space>"
let maplocalleader = "-"

" follow links
nnoremap <leader>g <C-]>
" open fzf and search files
nnoremap <leader>f :Files<CR>
" goto definition or assignments in python files
let g:jedi#goto_command = "<localleader>g"
" show docstring of word under cursor in python files
let g:jedi#documentation_command = "<localleader>K"
" circle usages of python variables
let g:jedi#usages_command = "<localleader>u"
" rename python variables
let g:jedi#rename_command = "<localleader>r"

" vim:foldmethod=marker:foldlevel=0:foldenable
