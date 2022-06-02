syntax on
filetype plugin indent on

set noerrorbells
set noswapfile

" Tabs
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent

" Show line numbers and relative line numbers
set nu rnu

" Clear highlights after the search is done
set nohlsearch

" Search is case insensitive if all input is lowercase,
" or case sensitive otherwise
set ignorecase
set smartcase

" Start scrolling when the cursor is 8 lines from the bottom of the editor
set scrolloff=8

" Extra column on the left for extra information, i.e. git integrations
set signcolumn=yes

" Enable mouse input
set mouse=a

" Use the system's clipboard as a buffer
set clipboard=unnamedplus

" Highlight the line where the cursor is
set cursorline

" If the terminal emulator supports it, display true colors
set termguicolors

" Change the way splits open, to be more natural
set splitbelow
set splitright

" Make folding be based on the language
set foldmethod=syntax
set foldlevelstart=30

" Fix for the Kitty terminal not showing the correct cursor and
" overriding the background
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"
let &t_ut=''
":autocmd VimEnter * normal! :startinsert :stopinsert

" GUI
set guifont=JetBrains\ Mono:h11
let g:neovide_transparency=0.85
