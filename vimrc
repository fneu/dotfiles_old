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
set autoindent
set smartindent

if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source ~/.vimrc
endif

call plug#begin()

" Visuals
Plug 'chriskempson/base16-vim'

" Tools
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'               " fzf integration for vim
Plug 'tpope/vim-fugitive'             " git integration
Plug 'tpope/vim-commentary'           " comment stuff out with gcc / gc<motion>
Plug 'tpope/vim-surround'             " cs, ds, ys(s), v_S surroundings
Plug 'tpope/vim-repeat'               " make repeat and surround repeatable
Plug 'tpope/vim-vinegar'              " netrw improvements
Plug 'tpope/vim-unimpaired'           " various bindings
Plug 'jiangmiao/auto-pairs'           " brackets/ parens / quote pairs

" Languages
Plug 'hynek/vim-python-pep8-indent'        " PEP8 conform indenting
Plug 'HerringtonDarkholme/yats.vim'        " TypeScript Syntax
Plug 'othree/html5.vim' " Html5 Syntax
Plug 'othree/yajs.vim'  " JavaScript Syntax

" Linting
Plug 'w0rp/ale'                       " run async linters while editing

" Tags
Plug 'ludovicchabant/vim-gutentags'   " automatic tag management

call plug#end()

" colors/appearance     
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif
set wildmenu

nmap <space>f :Files<CR>
nnoremap <leader>g :Gstatus<CR>
nnoremap <leader><S-f> :Files ~<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>t <C-]>
nnoremap <leader><S-t> <C-w>}
" Use <C-l> to clear the highlighting of :hlsearch
nnoremap <silent> <C-l>
\ :nohlsearch<C-r>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-l>
"run fzf in current window
let g:fzf_layout = { 'window': 'enew' }

" quit fzf with <esc>
augroup fzf
    autocmd!
    autocmd FileType fzf tnoremap <nowait><buffer> <esc> <c-g>
augroup END

set mouse=a
