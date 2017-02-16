scriptencoding utf-8
" Neovim configuration by Fabian Neuschmidt

" -----------------------------------------------------------------------------
" PLUGINS
" -----------------------------------------------------------------------------

" install vim-plug if missing:
let g:pluginstall=system('[ -e ~/.config/nvim/autoload/plug.vim ] ; echo $?')
if g:pluginstall != 0
    call system('curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')
    so ~/.config/nvim/autoload/plug.vim
endif

call plug#begin()

" Visuals
Plug 'justinmk/molokai'               " colorscheme
Plug 'mhartington/oceanic-next'       " colorscheme
"Plug 'fneu/breezy'                   " colorscheme
Plug 'vim-airline/vim-airline'        " statusline plugin

" Tools
Plug 'junegunn/fzf',                  " fuzzy file search
    \ { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'               " fzf integration for vim
Plug 'tpope/vim-fugitive'             " git integration
Plug 'tpope/vim-commentary'           " comment stuff out with gcc / gc<motion>
Plug 'justinmk/vim-sneak'             " precision movement with s<char><char>
Plug 'junegunn/vim-easy-align'        " horizontal alignment of lines
Plug 'thirtythreeforty/lessspace.vim' " remove new trailing whitespace
Plug 'metakirby5/codi.vim'            " REPL integration with :Codi <filetype>
Plug 'jiangmiao/auto-pairs'           " brackets/ parens / quote pairs

" Languages
Plug 'hynek/vim-python-pep8-indent'        " PEP8 conform indenting
Plug 'lervag/vimtex'                       " LaTeX tools
Plug 'HerringtonDarkholme/yats.vim'        " TypeScript Syntax
Plug 'https://github.com/othree/html5.vim' " Html5 Syntax
Plug 'https://github.com/othree/yajs.vim'  " JavaScript Syntax

" Completion
Plug 'ervandew/supertab'              " Use Tab for completion
Plug 'Shougo/deoplete.nvim',          " Async completion framework
    \ { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-jedi'            " Python completions for deoplete

" Snippets
Plug 'SirVer/ultisnips'               " Snippet engine
Plug 'honza/vim-snippets'             " Default snippets

" Linting
Plug 'w0rp/ale'                       " run async linters while editing

" Tags
Plug 'ludovicchabant/vim-gutentags'   " automatic tag management

call plug#end()

" -----------------------------------------------------------------------------
" MOVING AROUND, SEARCHING AND PATTERNS
" -----------------------------------------------------------------------------

set ignorecase " ignore case when using a search pattern
set smartcase  " override 'ignorecase' when pattern has upper case characters

" -----------------------------------------------------------------------------
" DISPLAYING TEXT
" -----------------------------------------------------------------------------

set scrolloff=3        " number of screen lines to show around the cursor
set fillchars=vert:\│  " show a continuous line for vsplits
set list               " show tabs and trailing whitespace
set number             " show the line number (for the current line)
set relativenumber     " show relative line numbers for each line
set inccommand=nosplit " show live preview of substitutions

" -----------------------------------------------------------------------------
" SYNTAX, HIGHLIGHTING AND SPELLING
" -----------------------------------------------------------------------------

set background=dark " the background color brightness
set termguicolors   " use GUI colors for the terminal


let g:python_highlight_all = 1 "use all python highlighting options

colorscheme OceanicNext

" show cursorline in active window only
augroup CursorLineOnlyInActiveWindow
    autocmd!
    autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    autocmd WinLeave * setlocal nocursorline
augroup END

" " color characters after the 79th column red
" augroup overlength
"     autocmd!
"     autocmd BufEnter *.md,*.py,*.vim
"                 \ highlight OverLength ctermfg=red guifg=#FF0000
"                 \ | match OverLength /\%80v.\+/
" augroup END

" enable spelling for certain file types
augroup spelling
    autocmd!
    autocmd BufNewFile,BufRead,BufEnter *.tex setlocal spell spelllang=de_de
    autocmd BufNewFile,BufRead,BufEnter README* setlocal spell spelllang=en_us
    autocmd BufNewFile,BufRead,BufEnter COMMIT* setlocal spell spelllang=en_us
augroup END

" -----------------------------------------------------------------------------
" MULTIPLE WINDOWS
" -----------------------------------------------------------------------------

set hidden     " don't unload a buffer when no longer shown in a window
set splitbelow " a new window is put below the current one
set splitright " a new window is put right of the current one

" -----------------------------------------------------------------------------
" MESSAGES AND INFO
" -----------------------------------------------------------------------------

set showcmd    " show (partial) command keys in the status line
set noshowmode " don't display the current mode in the status line
set confirm    " start a dialog when a command fails

" -----------------------------------------------------------------------------
" EDITING TEXT
" -----------------------------------------------------------------------------

set completeopt=menu
set nojoinspaces " don't use two spaces after '.' when joining a line

" -----------------------------------------------------------------------------
" TABS AND INDENTING
" -----------------------------------------------------------------------------

set tabstop=8     " number of spaces a <Tab> in the text stands for
set shiftwidth=4  " number of spaces used for each step of (auto)indent
set softtabstop=4 " if non-zero, number of spaces to insert for a <Tab>
set shiftround    " round to 'shiftwidth' for "<<" and ">>"
set expandtab     " expand <Tab> to spaces in Insert mode

augroup IndentExceptions
    autocmd!
    autocmd filetype typescript,html,css setlocal shiftwidth=2
    autocmd filetype typescript,html,css setlocal softtabstop=2
augroup END
" -----------------------------------------------------------------------------
" DIFF MODE
" -----------------------------------------------------------------------------

set diffopt+=vertical " start diff mode with vertical splits by default

" -----------------------------------------------------------------------------
" READING AND WRITING FILES
" -----------------------------------------------------------------------------

set autoread " automatically read a file when it was modified outside of Vim

" -----------------------------------------------------------------------------
" COMMAND LINE EDITING
" -----------------------------------------------------------------------------

" list of patterns to ignore files for file name completion
set wildignore+=.git                     " Version control
set wildignore+=*.aux,*.out,*.toc        " LaTeX intermediate files
set wildignore+=*.jpg,*.jpeg,*.png,*.svg " binary images
set wildignore+=*.pyc                    " Python bytecode

" -----------------------------------------------------------------------------
" VARIOUS
" -----------------------------------------------------------------------------

let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1 " make cursor a pipe when in insert mode

" stay in terminal mode by default
augroup terminal
    autocmd!
    autocmd BufWinEnter,WinEnter term://* startinsert
    autocmd BufLeave term://* stopinsert
augroup END

" -----------------------------------------------------------------------------
" KEYMAPS
" -----------------------------------------------------------------------------

" leave insert mode with jj
inoremap jj <Esc>

" leave terminal mode with Esic
" nvim instances in :terminal can exit insert mode with jj
tnoremap <Esc> <C-\><C-n>

" key used for leader commands
let g:mapleader = "\<Space>"

" follow tags
nnoremap <leader>t <C-]>
nnoremap <leader>d <C-w>}

" fzf.vim mappings to fuzzy search files or buffers
nnoremap <leader>f :Files <CR>
nnoremap <leader><S-f> :Files ~<CR>
nnoremap <leader>b :Buffers<CR>

" Show highlighting group for current word
nmap <leader>h :call <SID>SynStack()<CR>
function! <SID>SynStack()
    if !exists('*synstack')
        return
    endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, ''name'')')
endfunc

" fugitive mappings
nnoremap <leader>g :Gstatus<CR>

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" highlight last inserted text
nnoremap gV `[v`]

" Make Y move like D and C to end of line
noremap Y y$

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

" adjust for german keyboard layout:
nmap ö [
nmap ä ]
nmap Ö {
nmap Ä }
nmap ß /

" Use <C-l> to clear the highlighting of :hlsearch
nnoremap <silent> <C-l>
            \ :nohlsearch<C-r>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-l>

" Cycle location and quickfix list with F1-F4
fun! CycleList(nextcom, firstcom)
    try
        try
            execute a:nextcom
        catch /^Vim\%((\a\+)\)\=:E553/
            execute a:firstcom
        catch /^Vim\%((\a\+)\)\=:E776/
        endtry
    catch /^Vim\%((\a\+)\)\=:E42/
    endtry
endfun

nnoremap <silent> <F1> :call CycleList("cnext", "cfirst")<CR>
nnoremap <silent> <F2> :call CycleList("cprev", "clast")<CR>
nnoremap <silent> <F3> :call CycleList("lnext", "lfirst")<CR>
nnoremap <silent> <F4> :call CycleList("lprev", "llast")<CR>

" -----------------------------------------------------------------------------
" PLUGIN OPTIONS
" -----------------------------------------------------------------------------

" SUPERTAB -------------------------------------------------------------------

let g:SuperTabDefaultCompletionType = '<c-n>'

" DEOPLETE -------------------------------------------------------------------

let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#jedi#python_path = 'python3'

" Use vimtexs omni completion for tex files
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

" ULTISNIPS ------------------------------------------------------------------

let g:UltiSnipsExpandTrigger='<C-j>'
let g:UltiSnipsJumpForwardTrigger='<c-j>'
let g:UltiSnipsJumpBackwardTrigger='<c-k>'
let g:ultisnips_python_style='sphinx'

" LIGHTLINE ------------------------------------------------------------------

" let g:lightline = {
"     \ 'colorscheme': 'breezy',
"     \ 'active': {
"     \   'left': [ [ 'mode', 'paste' ],
"     \             [ 'fugitive', 'readonly', 'filename', 'modified' ] ]
"     \ },
"     \ 'component': {
"     \   'readonly': '%{&filetype=="help"?"":&readonly?"":""}',
"     \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
"     \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
"     \ },
"     \ 'component_visible_condition': {
"     \   'readonly': '(&filetype!="help"&& &readonly)',
"     \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
"     \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
"     \ },
"     \ 'separator': { 'left': '', 'right': '' },
"     \ 'subseparator': { 'left': '', 'right': '' }
"     \ }


" AIRLINE --------------------------------------------------------------------

let g:airline_theme='oceanicnext'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#tab_min_count = 2
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#show_tab_nr = 0
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline_skip_empty_sections = 1
" powerline symbols
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

" VIMTEX ---------------------------------------------------------------------

let g:tex_flavor = 'latex' " don't detect files with .tex suffix as plaintex
let g:vimtex_latexmk_progname = 'nvr'

" use <leader> instead of <localleader> for mappings.
nmap <leader>li <plug>(vimtex-info)
nmap <leader>lI <plug>(vimtex-info-full)
nmap <leader>lt <plug>(vimtex-toc-open)
nmap <leader>lT <plug>(vimtex-toc-toggle)
nmap <leader>ly <plug>(vimtex-labels-open)
nmap <leader>lY <plug>(vimtex-labels-toggle)
nmap <leader>lv <plug>(vimtex-view)
nmap <leader>lr <plug>(vimtex-reverse-search)
nmap <leader>ll <plug>(vimtex-compile-toggle)
nmap <leader>lL <plug>(vimtex-compile-selected)
vmap <leader>lL <plug>(vimtex-compile-selected)
nmap <leader>lk <plug>(vimtex-stop)
nmap <leader>lK <plug>(vimtex-stop-all)
nmap <leader>le <plug>(vimtex-errors)
nmap <leader>lo <plug>(vimtex-compile-output)
nmap <leader>lg <plug>(vimtex-status)
nmap <leader>lG <plug>(vimtex-status-all)
nmap <leader>lc <plug>(vimtex-clean)
nmap <leader>lC <plug>(vimtex-clean-full)
nmap <leader>lm <plug>(vimtex-imaps-list)
nmap <leader>lx <plug>(vimtex-reload)
nmap <leader>ls <plug>(vimtex-toggle-main)

" Use Okular as a viewer, supports forward search:
let g:vimtex_view_general_viewer = 'okular'
let g:vimtex_view_general_options = '--unique @pdf\#src:@line@tex'
let g:vimtex_view_general_options_latexmk = '--unique'

" Set the following in Okular for backward search:
" Settings > Editor > Custom Text Editor: nvr --remote-silent %f -c %l

" ALE ------------------------------------------------------------------------

nmap <silent> ]l <Plug>(ale_next_wrap)
nmap <silent> [l <Plug>(ale_previous_wrap)
let g:ale_sign_error = ''
let g:ale_sign_warning = ''
hi ALEErrorSign guifg=#ec5f67 guibg=#343d46
hi ALEWarningSign guifg=#fac863 guibg=#343d46

" CODI -----------------------------------------------------------------------

" use Python3
let g:codi#interpreters = {
    \ 'python': {
        \ 'bin': 'python3',
        \ 'prompt': '^\(>>>\|\.\.\.\) ',
        \ },
    \ }
