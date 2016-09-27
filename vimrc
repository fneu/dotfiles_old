
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

Plug 'justinmk/molokai'

Plug 'rakr/vim-two-firewatch'

Plug 'reedes/vim-pencil'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

Plug 'junegunn/fzf.vim'

Plug 'davidhalter/jedi-vim'

function! DoRemote(arg)
  UpdateRemotePlugins
endfunction
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }

Plug 'Shougo/neocomplete.vim'

Plug 'Shougo/neosnippet.vim'

Plug 'Shougo/neosnippet-snippets'

Plug 'justinmk/vim-sneak'

Plug 'zchee/deoplete-jedi'

Plug 'ervandew/supertab'

Plug 'lervag/vimtex'

Plug 'junegunn/goyo.vim'

call plug#end()

filetype plugin indent on

" enable true colors or 256 colors
if has('nvim')
	set termguicolors
elseif !has('gui_running')
	set t_Co=256
	let &t_AB="\e[48;5;%dm"
	let &t_AF="\e[38;5;%dm"
endif

syntax on
set background=dark
colorscheme molokai

" make terminal usable
"
if has('nvim')
	tnoremap <Esc> <C-\><C-n>
	autocmd BufWinEnter,WinEnter term://* startinsert
	autocmd BufLeave term://* stopinsert
	tnoremap <A-h> <C-\><C-n><C-w>h
	tnoremap <A-j> <C-\><C-n><C-w>j
	tnoremap <A-k> <C-\><C-n><C-w>k
	tnoremap <A-l> <C-\><C-n><C-w>l
	tnoremap jj <C-\><C-n>
endif
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l
vnoremap <A-h> <C-w>h
vnoremap <A-j> <C-w>j
vnoremap <A-k> <C-w>k
vnoremap <A-l> <C-w>l

" split windows in a way so that existing text doesn't move.
set splitbelow
set splitright

" exit insert mode with jj
inoremap jj <Esc>

" adjust for german keyboard layout:
noremap ö [
noremap ä ]
noremap Ö {
noremap Ä }
noremap ß /

let mapleader = "\<Space>"
let maplocalleader = "-"

nnoremap <leader>g <C-]>
nnoremap <leader>f :Files<CR>
nnoremap <leader>p :PencilToggle<CR>
nnoremap <leader>b :Goyo<CR>



let g:jedi#goto_command = "<leader>d"
let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#goto_definitions_command = ""
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>n"
let g:jedi#rename_command = "<leader>r"
let g:jedi#completions_enabled = 0

if has('nvim')
	let deoplete#enable_at_startup = 1
	"let g:deoplete#disable_auto_complete = 1
	let g:deoplete#enable_smart_case = 1
else
	let g:neocomplete#enable_at_startup = 1

	autocmd FileType python setlocal omnifunc=jedi#completions
	let g:jedi#completions_enabled = 0
	let g:jedi#auto_vim_configuration = 0

	if !exists('g:neocomplete#force_omni_input_patterns')
		let g:neocomplete#force_omni_input_patterns = {}
	endif
endif
autocmd FileType python nnoremap <leader>y :0,$!yapf<Cr>
autocmd CompleteDone * pclose " To close preview window of deoplete automagically


let g:SuperTabDefaultCompletionType = "<c-n>"

let g:vimtex_view_general_viewer = 'okular'
let g:vimtex_view_general_options = '--unique @pdf\#src:@line@tex'
let g:vimtex_view_general_options_latexmk = '--unique'

if has('nvim')
	if !exists('g:deoplete#omni#input_patterns')
		let g:deoplete#omni#input_patterns = {}
	endif
	let g:deoplete#omni#input_patterns.tex = '\\(?:'
		\ .  '\w*cite\w*(?:\s*\[[^]]*\]){0,2}\s*{[^}]*'
		\ . '|\w*ref(?:\s*\{[^}]*|range\s*\{[^,}]*(?:}{)?)'
		\ . '|hyperref\s*\[[^]]*'
		\ . '|includegraphics\*?(?:\s*\[[^]]*\]){0,2}\s*\{[^}]*'
		\ . '|(?:include(?:only)?|input)\s*\{[^}]*'
		\ . '|\w*(gls|Gls|GLS)(pl)?\w*(\s*\[[^]]*\]){0,2}\s*\{[^}]*'
		\ . '|includepdf(\s*\[[^]]*\])?\s*\{[^}]*'
		\ . '|includestandalone(\s*\[[^]]*\])?\s*\{[^}]*'
		\ .')'
else
	if !exists('g:neocomplete#sources#omni#input_patterns')
		let g:neocomplete#sources#omni#input_patterns = {}
	endif
	let g:neocomplete#sources#omni#input_patterns.tex =
		\ '\v\\%('
		\ . '\a*cite\a*%(\s*\[[^]]*\]){0,2}\s*\{[^}]*'
		\ . '|\a*ref%(\s*\{[^}]*|range\s*\{[^,}]*%(}\{)?)'
		\ . '|hyperref\s*\[[^]]*'
		\ . '|includegraphics\*?%(\s*\[[^]]*\]){0,2}\s*\{[^}]*'
		\ . '|%(include%(only)?|input)\s*\{[^}]*'
		\ . '|\a*(gls|Gls|GLS)(pl)?\a*%(\s*\[[^]]*\]){0,2}\s*\{[^}]*'
		\ . '|includepdf%(\s*\[[^]]*\])?\s*\{[^}]*'
		\ . '|includestandalone%(\s*\[[^]]*\])?\s*\{[^}]*'
		\ . ')'
endif

let g:vimtex_latexmk_progname = "nvr" 

set statusline=%<%f\ %h%m%r%w\ \ %{PencilMode()}\ %=\ col\ %c%V\ \ line\%l\,%L\ %P 
set rulerformat=%-12.(%l,%c%V%)%{PencilMode()}\ %P
let g:pencil#mode_indicators = {'hard': 'H', 'auto': 'A', 'soft': 'S', 'off': '',}

set tabstop=8
set expandtab
set shiftwidth=4
set softtabstop=4

" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB>
 \ pumvisible() ? "\<C-n>" :
 \ neosnippet#expandable_or_jumpable() ?
 \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
"smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
"\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif
