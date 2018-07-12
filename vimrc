" vim configuration by Fabian Neuschmidt

syntax on
filetype plugin indent on

" search
set incsearch
set hlsearch
set ignorecase
set smartcase

" backspace over everything
set backspace=indent,eol,start

" indents
set tabstop=8
set expandtab
set shiftwidth=4
set softtabstop=4
set autoindent
set smartindent


set laststatus=2

if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source ~/.vimrc
endif

:let mapleader = " "

call plug#begin()

" Visuals
Plug 'fneu/adapted'

" Tools
Plug 'vimwiki/vimwiki'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'               " fzf integration for vim
Plug 'tpope/vim-fugitive'             " git integration
Plug 'tpope/vim-commentary'           " comment stuff out with gcc / gc<motion>
Plug 'tpope/vim-surround'             " cs, ds, ys(s), v_S surroundings
Plug 'tpope/vim-repeat'               " make repeat and surround repeatable
Plug 'tpope/vim-vinegar'              " netrw improvements
Plug 'tpope/vim-unimpaired'           " various bindings
Plug 'tpope/vim-eunuch'               " :SudoWrite, :Unlink, :Rename, ...

" Completion and lint (LSP)
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'

Plug 'prabirshrestha/asyncomplete-buffer.vim'
au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
    \ 'name': 'buffer',
    \ 'whitelist': ['*'],
    \ 'blacklist': ['go'],
    \ 'completor': function('asyncomplete#sources#buffer#completor'),
    \ }))
Plug 'prabirshrestha/asyncomplete-file.vim'
au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
    \ 'name': 'file',
    \ 'whitelist': ['*'],
    \ 'priority': 10,
    \ 'completor': function('asyncomplete#sources#file#completor')
    \ }))
Plug 'yami-beta/asyncomplete-omni.vim'
au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#omni#get_source_options({
\ 'name': 'omni',
\ 'whitelist': ['*'],
\ 'blacklist': ['c', 'cpp', 'html'],
\ 'completor': function('asyncomplete#sources#omni#completor')
\  }))
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'

" Languages
Plug 'hynek/vim-python-pep8-indent'        " PEP8 conform indenting
Plug 'HerringtonDarkholme/yats.vim'        " TypeScript Syntax
Plug 'othree/html5.vim' " Html5 Syntax
Plug 'othree/yajs.vim'  " JavaScript Syntax

" Linting

call plug#end()

" colors/appearance     

" for vim 7
set t_Co=255

" for vim 8
if (has("termguicolors"))
  set termguicolors
endif

let g:adapted_terminal_bold = 1
let g:adapted_terminal_italic = 1
colorscheme adapted

set wildmenu

nmap <space>f :Files<CR>
nnoremap <space>g :Gstatus<CR>
nnoremap <space><S-f> :Files ~<CR>
nnoremap <space>b :Buffers<CR>
nnoremap <space>t <C-]>
nnoremap <space><S-t> <C-w>}
" Use <C-l> to clear the highlighting of :hlsearch
nnoremap <silent> <C-l>
\ :nohlsearch<C-r>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-l>

" compensate German keyboard layout
nmap ö [
nmap ä ]
omap ö [
omap ä ]
xmap ö [
xmap ä ]


"run fzf in current window
let g:fzf_layout = { 'window': 'enew' }

" quit fzf with <esc>
augroup fzf
    autocmd!
    autocmd FileType fzf tnoremap <nowait><buffer> <esc> <c-g>
augroup END

" abbreviations
inoremap <lt>/ </<C-x><C-o><Esc>==gi

set mouse=a

packadd! matchit

"vim-lsp
if executable('/home/fabian/.venv/vim/bin/pyls')
    " SET UP VIRTUALENV
    " pip install python-language-server[all]
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['/home/fabian/.venv/vim/bin/pyls']},
        \ 'whitelist': ['python'],
        \ })
endif

if executable('css-languageserver')
    " npm install -g vscode-css-languageserver-bin
    au User lsp_setup call lsp#register_server({
        \ 'name': 'css-languageserver',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'css-languageserver --stdio']},
        \ 'whitelist': ['css', 'less', 'sass'],
        \ })
endif

if executable('typescript-language-server')
    " npm install -g typescript typescript-language-server
    au User lsp_setup call lsp#register_server({
      \ 'name': 'typescript-language-server',
      \ 'cmd': { server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
      \ 'root_uri': { server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_directory(lsp#utils#get_buffer_path(), '.git/..'))},
      \ 'whitelist': ['typescript', 'javascript', 'javascript.jsx']
      \ })
endif

let g:lsp_signs_enabled = 1         " enable signs
let g:lsp_diagnostics_echo_cursor = 1 " enable echo under cursor when in normal mode
let g:lsp_signs_error = {'text': '✗'}
let g:lsp_signs_warning = {'text': '✗'}
let g:lsp_signs_hint = {'text': '✗'}
hi LspErrorText guifg=#F44336
hi LspWarningText guifg=#FFEB3B
hi link LspHintText Normal
" let g:lsp_log_verbose = 1
" let g:lsp_log_file = expand('~/vim-lsp.log')

" asyncomplete
" tab completion
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<cr>"
" force refresh
imap <c-space> <Plug>(asyncomplete_force_refresh)
let g:asyncomplete_remove_duplicates = 1
" auto-close preview window after completion
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" VIMWIKI
let g:vimwiki_list = [{'path': '/mnt/daten/GDrive/vimwiki/wiki/',
  \ 'path_html': '/mnt/daten/GDrive/vimwiki/html/',
  \ 'syntax': 'markdown',
  \ 'ext': '.md',
  \ 'custom_wiki2html': '/home/fabian/devel/dotfiles/bin/wiki2html.sh'}]
