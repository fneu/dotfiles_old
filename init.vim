" PLUGINS {{{1
"
" Install vim-plug if missing:
let pluginstall=system("[ -e ~/.config/nvim/autoload/plug.vim ] ; echo $?")
if pluginstall != 0
    call system("curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim")
    so ~/.config/nvim/autoload/plug.vim
endif

call plug#begin()

call plug#end()

" KEYBINDINGS {{{1
"
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

" LEADER BINDINGS {{{1
"
let mapleader = "\<Space>"
let maplocalleader = "-"

nnoremap <leader>g <C-]>

" vim:foldmethod=marker:foldlevel=0:foldenable
