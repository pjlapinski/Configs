" Install vim-plug if not found
let autoload_plug_path = stdpath('data') . '/site/autoload/plug.vim'
if !filereadable(autoload_plug_path)
  silent execute '!curl -fLo ' . autoload_plug_path . '  --create-dirs
      \ "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
unlet autoload_plug_path

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin('~/.config/nvim/plugged')

    Plug 'morhetz/gruvbox' "Theme
    Plug 'mhinz/vim-startify' "Startup menu
    Plug 'chrisbra/colorizer' " Color the colornames and codes
    Plug 'nathanaelkane/vim-indent-guides' " Show indentation guide lines

    " Status line style
    Plug 'bling/vim-airline'
    Plug 'vim-airline/vim-airline-themes'

    " Commenting selected lines
    Plug 'preservim/nerdcommenter'

    " File explorer
    Plug 'preservim/nerdtree'
    Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

    " LSP
    Plug 'neovim/nvim-lspconfig'
    Plug 'hrsh7th/nvim-compe'
    Plug 'tmsvg/pear-tree' " Auto insert bracket pairs
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'tell-k/vim-autopep8'
    Plug 'ray-x/lsp_signature.nvim'

    " Git
    Plug 'airblade/vim-gitgutter'
    
    " Misc
    Plug 'machakann/vim-highlightedyank'

call plug#end()

" Run PlugInstall if there are missing plugins
autocmd! VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
            \| PlugInstall --sync
            \| q
            \| endif

"- Theme
set bg=dark
colorscheme gruvbox
let g:colorizer_auto_color = 1

" Airline
let g:airline_powerline_fonts=1
let g:airline_theme='wombat'
let g:airline#extensions#tabline#enabled = 1

" Indent guides
let g:indent_guides_enable_on_vim_startup = 1

" Colorizing color names
let g:colorizer_auto_color = 1

" NERDCommenter settings
let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCreateDefaultMappings = 0

" NERDTree
let NERDTreeCustomOpenArgs = {'file':{'where': 't'}}
let NERDTreeShowHidden = 1
let g:NERDTreeDirArrowExpandable = '▶'
let g:NERDTreeDirArrowCollapsible = '▼'
let NERDTreeShowLineNumbers=1
let NERDTreeMinimalUI = 1
let g:NERDTreeWinPos = 'right'
let g:NERDTreeWinSize=38

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Enable smart pairing in pear-tree
let g:pear_tree_smart_openers = 0
let g:pear_tree_smart_closers = 0
let g:pear_tree_smart_backspace = 0

let g:pear_tree_map_special_keys = 0

" Autoformat code on buffer save
autocmd BufWritePre * lua vim.lsp.buf.formatting_sync(nil, 100)

let g:autopep8_disable_show_diff=1
autocmd FileType python
    \ autocmd BufWritePre <buffer> Autopep8

luafile ~/.config/nvim/compe-config.lua

" Setup LSP servers
lua << EOF
local nvim_lsp = require'lspconfig'
local servers = { 'clangd', 'jedi_language_server' }

for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {}
end
EOF

" Setup treesitter highlighting
lua << EOF
require'nvim-treesitter.configs'.setup {
    ensure_installed = "all",
    sync_install = true,
    highlight = {
        enable = true
    }
}
EOF

" Setup lsp_signature
lua << EOF
require'lsp_signature'.setup {
    bind = true
}
EOF

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

augroup TRIM_WHITESPACE_ON_SAVE
    autocmd!
    autocmd BufWritePre * :call TrimWhitespace()
augroup END

source ~/.config/nvim/keybinds.vim
source ~/.config/nvim/vim_settings.vim
