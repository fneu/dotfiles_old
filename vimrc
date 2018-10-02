" vim configuration by Fabian Neuschmidt

filetype plugin indent on
syntax enable

" VIM-PLUG
" automatic install on first use
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source ~/.vimrc
    let g:first_use = "yes"
endif

" PLUGINS

call plug#begin()

" colorscheme
Plug 'fneu/adapted'

" tools / editing
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'             " fzf integration for vim
Plug 'tpope/vim-fugitive'           " git integration
Plug 'tpope/vim-commentary'         " comment stuff out with gcc / gc<motion>
Plug 'tpope/vim-surround'           " cs, ds, ys(s), v_S surroundings
Plug 'tpope/vim-repeat'             " make repeat and surround repeatable
Plug 'tpope/vim-vinegar'            " netrw improvements
Plug 'tpope/vim-unimpaired'         " various ]/[ bindings
Plug 'tpope/vim-eunuch'             " :SudoWrite, :Unlink, :Rename, ...
Plug 'wincent/terminus'             " FocusGained and cursor shape in Konsole
Plug 'vimwiki/vimwiki'
Plug 'mattn/emmet-vim'              " html magic with <C-y>
Plug 'ap/vim-css-color'             " highlight colors in various file types
Plug 'Yggdroot/indentLine'

" languages
Plug 'hynek/vim-python-pep8-indent' " PEP8 conform indenting
Plug 'raimon49/requirements.txt.vim', {'for': 'requirements'}
Plug 'HerringtonDarkholme/yats.vim' " TypeScript Syntax
Plug 'othree/html5.vim'             " Html5 Syntax
Plug 'othree/yajs.vim'              " JavaScript Syntax
" linting
Plug 'w0rp/ale'                     " better configuration than LSP
" completion / LSP
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-file.vim'
Plug 'prabirshrestha/asyncomplete-buffer.vim'
Plug 'yami-beta/asyncomplete-omni.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'Shougo/echodoc.vim'             " function signatures for completed items

call plug#end()

packadd! matchit

" BASIC SETUP

set autoindent                      " carry over indent to next line
set backspace=indent,eol,start      " backspace over everything
set complete-=i                     " no included files in keyword completion
set smarttab                        " use shiftwidth for tab/space indentation

set tabstop=8                       " size of actual tab chars
set softtabstop=4                   " 'width' of a tab inserting operation
set shiftwidth=4                    " 'width' of an indenting operation
set expandtab                       " indent using spaces instead of tabs

set incsearch                       " preview position of first search match
set hlsearch                        " highlight search matches
set ignorecase                      " case insensitive search ...
set smartcase                       " ... unless pattern contains capitals

set nrformats-=octal                " prevent <C-A> from skipping 8 and 9

set ttimeout                        " don't wait forever on key codes like esc
set ttimeoutlen=100

set shortmess+=c                    " suppress ins-complete-menu messages
set noshowmode                      " suppress mode messages -> use for echodoc
set wildmenu                        " command line completion
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
set ruler                           " show current position in statusline

set scrolloff=3                     " always show n lines above/below cursor
set sidescrolloff=5
set display+=lastline               " show part of long last line (and marker)

set encoding=utf-8
set showbreak=↪\ "
set listchars=tab:→\ ,nbsp:␣,trail:·,extends:›,precedes:‹
set list                            " highlight above chars respectively
set formatoptions+=j                " delete comment char when joining lines

set autoread                        " auto load file changes, needs terminus

set history=1000                    " command-line history
set nobackup
set noswapfile

if !isdirectory($HOME."/.vim/undo-dir")
    call mkdir($HOME."/.vim/undo-dir", "", 0700)
endif
set undodir=~/.vim/undo-dir
set undofile                        " keep undo history (forever)

set mouse=a                         " use mouse in all modes
if has('unnamedplus')
  set clipboard=unnamed,unnamedplus " use system clipboard
endif

" VISUAL

" for vim 7
set t_Co=255

" for vim 8
if (has("termguicolors"))
  set termguicolors
endif

let g:adapted_terminal_bold = 1
let g:adapted_terminal_italic = 1
if !exists('g:first_use')
    " colorscheme adapted
    colorscheme github
endif

" MAPPINGS

let mapleader = " "

" follow tags, help, etc.
nnoremap <leader>t <C-]>

" goto Definition
nnoremap <leader>d :LspDefinition<CR>

" center after search
nnoremap n nzz
nnoremap N Nzz

" use <C-l> to clear the highlighting of :hlsearch
nnoremap <silent> <C-l>
\ :nohlsearch<C-r>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-l>

" move selected lines
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" compensate for German keyboard layout
nmap ö [
nmap ä ]
omap ö [
omap ä ]
xmap ö [
xmap ä ]

" git
nnoremap <Leader>ga :Gwrite<CR>
nnoremap <Leader>gc :Gcommit<CR>
nnoremap <Leader>gsh :Gpush<CR>
nnoremap <Leader>gll :Gpull<CR>
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gb :Gblame<CR>
nnoremap <Leader>gd :Gvdiff<CR>
nnoremap <Leader>gr :Gremove<CR>
nnoremap <Leader>o :.Gbrowse<CR>

" completion:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>\<cr>" : "\<cr>"

" search
nnoremap <silent> <leader>f :Files<CR>
nnoremap <silent> <leader>b :Buffers<CR>
if executable('rg')
    command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
    nnoremap <silent> <leader><S-f> :Find<CR>
endif

" PLUGIN SETTINGS

" fzf
"run fzf in current window -> DISABLED BECAUSE IT BREAKS ARROW KEYS
" let g:fzf_layout = { 'window': 'enew' }
" quit fzf with <esc>
augroup fzf
    autocmd!
    autocmd FileType fzf tnoremap <nowait><buffer> <esc> <c-g>
augroup END
" ignore some potentially large folders
let $FZF_DEFAULT_COMMAND =  "find * -path '*/\.*' -prune -o -path 'node_modules/**' -prune -o -path 'target/**' -prune -o -path 'dist/**' -prune -o  -type f -print -o -type l -print 2> /dev/null"
" use ripgrep if available
if executable('rg')
  let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
  set grepprg=rg\ --vimgrep
endif

" vim-lsp
augroup lsp
    autocmd!
    " python
    if executable('pyls')
        " pip install python-language-server
        autocmd User lsp_setup call lsp#register_server({
            \ 'name': 'pyls',
            \ 'cmd': {server_info->['pyls']},
            \ 'whitelist': ['python'],
            \ })
    endif
    " typescript
    if executable('typescript-language-server')
        " npm install -g typescript typescript-language-server
        au User lsp_setup call lsp#register_server({
            \ 'name': 'typescript-language-server',
            \ 'cmd': {server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
            \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'tsconfig.json'))},
            \ 'whitelist': ['typescript'],
            \ })
endif
augroup END

" asyncomplete
let g:asyncomplete_remove_duplicates = 1
augroup asyncomplete
    autocmd!
    " filepath completion
    autocmd User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
        \ 'name': 'file',
        \ 'whitelist': ['*'],
        \ 'priority': 10,
        \ 'completor': function('asyncomplete#sources#file#completor')
        \ }))
    " buffer completion
    autocmd User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
        \ 'name': 'buffer',
        \ 'whitelist': ['*'],
        \ 'completor': function('asyncomplete#sources#buffer#completor'),
        \ }))
    " omni completion
    autocmd User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#omni#get_source_options({
        \ 'name': 'omni',
        \ 'whitelist': ['*'],
        \ 'blacklist': ['python'],
        \ 'completor': function('asyncomplete#sources#omni#completor')
        \  }))
augroup END

" echodoc
let g:echodoc_enable_at_startup = 1

" ALE
let g:ale_linters = {
        \ 'python': ['flake8'],
        \ 'html': ['htmlhint'],
        \}
let g:ale_fixers = {
        \ 'python': ['isort', 'yapf'],
        \}
let g:ale_echo_msg_format = '[%linter%] %s'
let g:ale_sign_error = '❌'
let g:ale_sign_warning = '❗'

highlight ALEErrorSign guifg=#EF5350
highlight ALEWarningSign guifg=#FFEE58
highlight ALEError guibg=#3E2723
highlight ALEWarning guibg=#3E2723

nmap <silent> [c <Plug>(ale_previous_wrap)
nmap <silent> ]c <Plug>(ale_next_wrap)

" indentLine:
let g:indentLine_char = '│'
let g:indentLine_faster = 1
let g:indentLine_color_gui = '#ddddc5'
" let indentLine use current conceal options
" let g:indentLine_conceallevel  = &conceallevel -> disables conceal
let g:indentLine_concealcursor = &concealcursor

" vimwiki
let g:vimwiki_list = [{'path': '/mnt/daten/GDrive/vimwiki/wiki/',
  \ 'path_html': '/mnt/daten/GDrive/vimwiki/html/',
  \ 'syntax': 'markdown',
  \ 'ext': '.md',
  \ 'custom_wiki2html': '/home/fabian/devel/dotfiles/bin/wiki2html.sh'}]

" LANGUAGE SPECIFIC SETTINGS

let python_highlight_all = 1

augroup languages
    autocmd!
    autocmd FileType make setlocal noexpandtab
    autocmd Filetype html setlocal sts=2 sw=2 expandtab
    autocmd FileType python setlocal colorcolumn=79
    autocmd FileType json setlocal sts=2 sw=2 expandtab
    autocmd FileType typescript setlocal sts=2 sw=2
    autocmd FileType css setlocal sts=2 sw=2
augroup END

" STATUSLINE

" highlight StatusLineNC guifg=#546e7a guibg=#37474f
highlight StatusLineNC guifg=#37474f guibg=#607D8B

function! ActiveStatus()
  let statusline=""
  let statusline.="%1*"
  let statusline.="%(%{'help'!=&filetype?'\ \ '.bufnr('%'):''}\ %)"
  let statusline.="%5*"
  let statusline.=""
  let statusline.="%2*"
  let statusline.="%{fugitive#head()!=''?'\ \ '.fugitive#head().'\ ':''}"
  let statusline.="%3*"
  let statusline.=""
  let statusline.="%4*"
  let statusline.="\ %<"
  let statusline.="%f"
  let statusline.="%{&modified?'\ \ +':''}"
  let statusline.="%{&readonly?'\ \ ':''}"
  let statusline.="%="
  let statusline.="\ %{''!=#&filetype?&filetype:'none'}"
  let statusline.="%(\ %{(&bomb\|\|'^$\|utf-8'!~#&fileencoding?'\ '.&fileencoding.(&bomb?'-bom':''):'').('unix'!=#&fileformat?'\ '.&fileformat:'')}%)"
  let statusline.="%(\ \ %{&modifiable?(&expandtab?'et\ ':'noet\ ').&shiftwidth:''}%)"
  let statusline.="%3*"
  let statusline.="\ "
  let statusline.="%5*"
  let statusline.=""
  let statusline.="%1*"
  let statusline.="\ %2v"
  let statusline.="\ %3p%%\ "
  return statusline
endfunction

function! InactiveStatus()
  let statusline=""
  let statusline.="%(%{'help'!=&filetype?'\ \ '.bufnr('%').'\ \ ':'\ '}%)"
  let statusline.="%{fugitive#head()!=''?'\ \ '.fugitive#head().'\ ':'\ '}"
  let statusline.="\ %<"
  let statusline.="%f"
  let statusline.="%{&modified?'\ \ +':''}"
  let statusline.="%{&readonly?'\ \ ':''}"
  let statusline.="%="
  let statusline.="\ %{''!=#&filetype?&filetype:'none'}"
  let statusline.="%(\ %{(&bomb\|\|'^$\|utf-8'!~#&fileencoding?'\ '.&fileencoding.(&bomb?'-bom':''):'').('unix'!=#&fileformat?'\ '.&fileformat:'')}%)"
  let statusline.="%(\ \ %{&modifiable?(&expandtab?'et\ ':'noet\ ').&shiftwidth:''}%)"
  let statusline.="\ \ "
  let statusline.="\ %2v"
  let statusline.="\ %3p%%\ "
  return statusline
endfunction

set laststatus=2
set statusline=%!ActiveStatus()
hi User1 guibg=#4db6ac guifg=#37474f
hi User5 guibg=#607d8b guifg=#4db6ac
hi User2 guibg=#607d8b guifg=#cfd8dc
hi User3 guibg=#455a64 guifg=#607d8b
hi User4 guibg=#455a64 guifg=#b0bec5

augroup status
  autocmd!
  autocmd WinEnter * setlocal statusline=%!ActiveStatus()
  autocmd WinLeave * setlocal statusline=%!InactiveStatus()
augroup END
