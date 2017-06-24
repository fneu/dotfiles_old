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
Plug 'fneu/breezy'                   " colorscheme

" Tools
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'               " fzf integration for vim
Plug 'tpope/vim-fugitive'             " git integration
Plug 'tpope/vim-commentary'           " comment stuff out with gcc / gc<motion>
Plug 'tpope/vim-surround'             " cs, ds, ys(s), v_S surroundings
Plug 'tpope/vim-repeat'               " make repeat and surround repeatable
Plug 'tpope/vim-vinegar'              " netrw improvements
Plug 'thirtythreeforty/lessspace.vim' " remove new trailing whitespace
Plug 'metakirby5/codi.vim'            " REPL integration with :Codi <filetype>
Plug 'jiangmiao/auto-pairs'           " brackets/ parens / quote pairs
Plug 'wincent/terminus'               " Terminal integration

" Languages
Plug 'hynek/vim-python-pep8-indent'        " PEP8 conform indenting
Plug 'HerringtonDarkholme/yats.vim'        " TypeScript Syntax
Plug 'https://github.com/othree/html5.vim' " Html5 Syntax
Plug 'https://github.com/othree/yajs.vim'  " JavaScript Syntax

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

set background=light " the background color brightness
set termguicolors   " use GUI colors for the terminal


let g:python_highlight_all = 1 "use all python highlighting options

colorscheme breezy

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

" move lines
" https://www.reddit.com/r/vim/comments/6ckkxu/slug/dhvjiio
nnoremap <silent> <leader>k :<C-u>move-2<CR>==
nnoremap <silent> <leader>j :<C-u>move+<CR>==
xnoremap <silent> <leader>k :move-2<CR>gv=gv
xnoremap <silent> <leader>j :move'>+<CR>gv=gv

" Search for selected text, forwards or backwards.
" http://vim.wikia.com/wiki/Search_for_visually_selected_text
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>

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
xmap ö [
xmap ä ]
xmap Ö {
xmap Ä }
xmap ß /
omap ö [
omap ä ]
omap Ö {
omap Ä }
omap ß /

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

" ALE ------------------------------------------------------------------------

let g:ale_sign_error = '✘'
let g:ale_sign_warning = '!'
hi link ALEErrorSign NeomakeErrorSign
hi link ALEWarningSign NeomakeWarningSign

" CODI -----------------------------------------------------------------------

" use Python3
let g:codi#interpreters = {
    \ 'python': {
        \ 'bin': 'python3',
        \ 'prompt': '^\(>>>\|\.\.\.\) ',
        \ },
    \ }

" FZF ------------------------------------------------------------------------
"run fzf in current window
let g:fzf_layout = { 'window': 'enew' }

" quit fzf with <esc>
augroup fzf
    autocmd!
    autocmd FileType fzf tnoremap <nowait><buffer> <esc> <c-g>
augroup END

