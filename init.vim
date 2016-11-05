" Fabian Neuschmidt

" KEYBINDINGS {{{1

" key used for leader commands
let mapleader = "\<Space>"

" follow tags
nnoremap <leader>t <C-]>

" copy to system clipboard
nnoremap <leader>y "+y
" paste from system clipboard
nnoremap <leader>p "+p

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

" leave insert mode with jj
inoremap jj <Esc>

" leave terminal mode with Esc
" nvim instances in :terminal can exit inset mode with jj 
tnoremap <Esc> <C-\><C-n>

" adjust for german keyboard layout:
noremap ö [
noremap ä ]
noremap Ö {
noremap Ä }
noremap ß /

" Use <C-l> to clear the highlighting of :hlsearch
nnoremap <silent> <C-l>
    \ :nohlsearch<C-r>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-l>

" Make Y mode like D and C to end of line
noremap Y y$
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
" open fzf and search files
nnoremap <leader>f :Files<CR>
nnoremap <leader>b :Buffers<CR>

Plug 'junegunn/vim-easy-align'
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

Plug 'davidhalter/jedi-vim'
" don't use these commands:
let g:jedi#goto_assignments_command = ""
let g:jedi#goto_definitions_command = ""
let g:jedi#completions_command = ""
" use python 3 only:
let g:jedi#force_py_version = 3
" leave completeopt and <C-c> as they are
let g:jedi#auto_vim_configuration = 0

" goto definition or assignments in python files
let g:jedi#goto_command = "<leader>g"
" show docstring of word under cursor in python files
let g:jedi#documentation_command = "<leader>d"
" circle usages of python variables
let g:jedi#usages_command = "<leader>u"
" rename python variables
let g:jedi#rename_command = "<leader>r"

Plug 'tpope/vim-fugitive'

Plug 'justinmk/vim-sneak'

Plug 'justinmk/molokai'

" strip trailing whitespace from edited lines
Plug 'thirtythreeforty/lessspace.vim'
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

" Allow changed buffers in the background
set hidden

" show line numbers:
set number

" show relative numbers in active window only
augroup RelativeNumberOnlyInActiveWindow
    autocmd!
    autocmd VimEnter,WinEnter,BufWinEnter * setlocal relativenumber
    autocmd WinLeave * setlocal norelativenumber
augroup END

" show cursorline in active window only
augroup CursorLineOnlyInActiveWindow
    autocmd!
    autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    autocmd WinLeave * setlocal nocursorline
augroup END

" show true colors in terminal
set termguicolors

" colorscheme
set background=dark
colorscheme molokai

" color characters after the 79th column red
augroup overlength
    autocmd!
    autocmd BufEnter * highlight OverLength ctermfg=red guifg=#FF0000
    autocmd BufEnter * match OverLength /\%80v.\+/
augroup END

" make cursor a pipe when in insert mode:
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

" set statusline
" switching the colors around looks better (inactive <-> active)
hi StatusLineNC guibg=#080808 guifg=#455354
hi StatusLine guibg=#080808 guifg=#808080

set statusline=                                     " empty statusline
set statusline+=%f                                  " add full file path
set statusline+=%=                                  " spacer
set statusline +=%m                                 " modified flag [+]
set statusline+=%(\ [%{fugitive#head()}%Y%R%W]%)    " git, filetype, RO, PRV
set statusline+=\ [%(%l,%2.c%)]                     " line no. and column

" vim:foldmethod=marker:foldlevel=0:foldenable
