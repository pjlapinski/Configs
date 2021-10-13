"--- PLUGINS ---



let g:polyglot_disabled =['cpp', 'c++', 'c']
let g:syntastic_mode_map = {
            \ 'mode': 'active',
            \ 'passive_filetypes': ['cpp', 'c++', 'c']
            \}
" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin('~/.vim/plugged')
Plug 'morhetz/gruvbox' "Theme
Plug 'mhinz/vim-startify' "Startup menu
" Language packs & Code autocompletion
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'scrooloose/syntastic'
Plug 'sheerun/vim-polyglot'
Plug 'pappasam/coc-jedi', { 'do': 'npm ci && npm run build', 'branch': 'main' }
Plug 'rhysd/vim-clang-format'
" Plug 'omnisharp/omnisharp-vim'

Plug 'chrisbra/colorizer' " Color the colornames and codes
Plug 'nathanaelkane/vim-indent-guides' " Show indentation guide lines
" Status line style
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Commenting selected lines
Plug 'scrooloose/nerdcommenter'
" File explorer
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
" Debugging
Plug 'puremourning/vimspector'

call plug#end()

colorscheme gruvbox
set background=dark
let g:airline_theme='gruvbox'
let g:airline#extensions#tabline#enabled = 1

let g:indent_guides_enable_on_vim_startup = 1

let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCreateDefaultMappings = 0

let g:colorizer_auto_color = 1
let g:coc_global_extensions = [
    \ 'coc-git',
    \ 'coc-json',
    \ 'coc-snippets',
    \ 'coc-tsserver',
    \ 'coc-eslint',
    \ 'coc-prettier',
    \ 'coc-pairs',
    \ 'coc-emmet',
    \ 'coc-flutter',
    \ 'coc-fsharp',
    \ 'coc-clangd',
    \ 'coc-css',
    \ 'coc-html',
    \ 'coc-htmldjango',
    \ 'coc-html-css-support',
    \ 'coc-java',
    \ 'coc-jedi',
    \ 'coc-omnisharp',
    \ 'coc-rome',
    \ 'coc-sh',
    \ 'coc-sql',
    \ 'coc-vetur',
    \ 'coc-xml',
    \ 'coc-yaml',
    \ ]


" --- KEYBINDINGS & COMMANDS ---



" Come on Vim, be consistent
nnoremap Y y$
" Keep cursor at the same position with J
nnoremap J mzJ`z
" Keep the search centered
nnoremap n nzzzv
nnoremap N Nzzzv
" Additional undo break points
inoremap , ,<C-g>u
inoremap . .<C-g>u
inoremap ! !<C-g>u
inoremap ? ?<C-g>u
" Moving text around
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv
inoremap <C-j> <esc>:m .+1<CR>==
inoremap <C-k> <esc>:m .-2<CR>==
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==

let mapleader = " "

nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gr <Plug>(coc-references)

"Kill the current buffer
nmap <leader>q :bd!<CR>

"- Navigation between buffers
nmap <leader>wn <C-w>n:Explore .<CR>
nmap <leader>wv <C-w>v:Explore .<CR>
nmap <leader>h <C-w>h
nmap <leader>j <C-w>j
nmap <leader>k <C-w>k
nmap <leader>l <C-w>l

"- Tabs

" Open a new tab with File Explorer
nmap <leader>tn :tabnew<CR>:Explore<CR>
" Cycle tabs
nmap <S-Tab> gt
" Comment selected lines
nmap <C-_> :call nerdcommenter#Comment('n', 'Toggle')<CR>
vmap <C-_> :call nerdcommenter#Comment('x', 'Toggle')<CR>
" Open terminal split
nmap <leader>tt :terminal<CR>

" Open NERDTree
nmap <C-n> :NERDTreeToggle<CR>
" Show git diff
nmap gs <Plug>(coc-git-chunkinfo)

let NERDTreeCustomOpenArgs = {'file':{'where': 't'}}
let NERDTreeShowHidden = 1

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

"-Debugging
nmap <leader>dd :call vimspector#Launch()<CR>
nmap <leader>de :call vimspector#Reset()<CR>
nmap <leader>di <Plug>VimspectorStepInto
nmap <leader>do <Plug>VimspectorStepOver
nmap <leader>dO <Plug>VimspectorStepOut
nmap <leader>db <Plug>VimspectorToggleBreakpoint
nnoremap <leader>d<space> :call vimspector#Continue()<CR>

" Set the clang-format style
let g:clang_format#style_options = {
            \ 'BasedOnStyle': 'WebKit',
            \ 'IndentWidth': 4,
            \ 'FixNamespaceComments': 'false',
            \ 'NamespaceIndentation': 'All',
            \ 'BreakBeforeBraces': 'Attach'
            \}

" Autoformat C/C++ code on buffer save
autocmd BufWritePre *.cpp ClangFormat
autocmd BufWritePre *.hpp ClangFormat
autocmd BufWritePre *.c ClangFormat
autocmd BufWritePre *.h ClangFormat

" Open file explorer on the right
let g:NERDTreeWinPos = 'right'

" Use <c-space> to trigger completion.
inoremap <c-@> coc#refresh()

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

augroup TRIM_WHITESPACE_ON_SAVE
    autocmd!
    autocmd BufWritePre * :call TrimWhitespace()
augroup END



" --- VIM SETTINGS ---


syntax on
filetype plugin indent on

set noerrorbells
set noswapfile
set autoindent

" Tabs
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent

" Use project specific .vimrc files
set exrc

" Show line numbers and relative line numbers
set nu rnu

" Clear highlights after the search is done
set nohlsearch

" Search is case insensitive if all input is lowercase,
" or case sensitive otherwise
set ignorecase
set smartcase

" Incrementally search while input is being typed
set incsearch

" Start scrolling when the cursor is 8 lines from the bottom of the editor
set scrolloff=8

" Display the current mode
set showmode

" Extra column on the left for extra information, i.e. git integrations
set signcolumn=yes

" Color the 80th column
set colorcolumn=80

" Enable mouse input
set mouse=a

" Display a status line at the bottom
set laststatus=2

" Use the system's clipboard as a buffer
set clipboard=unnamedplus

" Display the current position of the cursor on the status line
set ruler

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

set encoding=UTF-8

" Fix for the Kitty terminal not showing the correct cursor and
" overriding the background
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"
let &t_ut=''
:autocmd VimEnter * normal! :startinsert :stopinsert
