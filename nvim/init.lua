dofile('/home/beton/.config/nvim/settings.lua')
dofile('/home/beton/.config/nvim/keybinds.lua')

-- Make sure to install vim-plug and run :PlugInstall
local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugged')
    Plug 'lewis6991/impatient.nvim' --Startup time improvements

    Plug 'morhetz/gruvbox' --Theme
    Plug 'mhinz/vim-startify' --Startup menu
    Plug 'chrisbra/colorizer' --Color the colornames and codes
    Plug 'nathanaelkane/vim-indent-guides' --Show indentation guide lines

    -- Status line style
    Plug 'bling/vim-airline' --Powerline
    Plug 'vim-airline/vim-airline-themes' --Powerline theme

    -- Commenting selected lines
    Plug 'preservim/nerdcommenter' --Ctrl+/ to toggle comment

    -- File explorer
    Plug 'preservim/nerdtree'
    Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

    -- LSP
    Plug 'neovim/nvim-lspconfig'
    Plug 'tmsvg/pear-tree' --Auto insert bracket pairs
    Plug ('nvim-treesitter/nvim-treesitter', {['do'] = ':TSUpdate'})
    Plug 'tell-k/vim-autopep8'
    Plug 'ray-x/lsp_signature.nvim'

    -- nvim-cmp
    Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/cmp-vsnip'
    Plug 'hrsh7th/vim-vsnip'
    Plug 'hrsh7th/cmp-nvim-lsp'

    -- Git
    Plug 'airblade/vim-gitgutter'
    Plug 'kdheepak/lazygit.nvim'

    -- Misc
    Plug 'machakann/vim-highlightedyank'
    Plug 'ahmedkhalf/lsp-rooter.nvim'
vim.call('plug#end')

require'impatient'

--- Theme
vim.o.bg = 'dark'
vim.cmd('colorscheme gruvbox')
vim.g.colorizer_auto_color = 1

-- Airline
vim.g.airline_powerline_fonts = 1
vim.g.airline_theme = 'wombat'
vim.g['airline#extensions#tabline#enabled'] = 1

-- Indent guides
vim.g.indent_guides_enable_on_vim_startup = 1

-- Colorizing color names
vim.g.colorizer_auto_color = 1

-- NERDCommenter settings
vim.NERDSpaceDelims = 1
vim.g.NERDDefaultAlign = 'left'
vim.g.NERDCreateDefaultMappings = 0

-- NERDTree
vim.g.NERDTreeCustomOpenArgs = {['file'] = {['where'] = 't'}}
vim.g.NERDTreeShowHidden = 1
vim.g.NERDTreeDirArrowExpandable = '▶'
vim.g.NERDTreeDirArrowCollapsible = '▼'
vim.g.NERDTreeShowLineNumbers=1
vim.g.NERDTreeMinimalUI = 1
vim.g.NERDTreeWinPos = 'right'
vim.g.NERDTreeWinSize = 38

-- Enable smart pairing in pear-tree
vim.g.pear_tree_smart_openers = 0
vim.g.pear_tree_smart_closers = 0
vim.g.pear_tree_smart_backspace = 0

vim.g.pear_tree_map_special_keys = 0

vim.api.nvim_create_autocmd('BufWritePre', {
    pattern = '*',
    desc = 'Autoformat code on buffer save',
    callback = function()
        vim.lsp.buf.formatting_sync(nul, 100)
    end
})

vim.g.autopep8_disable_show_diff = 1
vim.api.nvim_create_autocmd('FileType', {
    pattern = 'python',
    callback = function()
        vim.api.nvim_create_autocmd('BufWritePre', {
            pattern = '<buffer>',
            command = "Autopep8"
        })
    end
})

-- Setup LSP servers
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
local nvim_lsp = require'lspconfig'
local servers = { 'clangd', 'jedi_language_server', 'rust_analyzer' }

for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
        capabilities = capabilities
    }
end

-- Setup treesitter highlighting
require'nvim-treesitter.configs'.setup {
    ensure_installed = {
	'bash',
	'c',
	'c_sharp',
	'clojure',
	'cmake',
	'comment',
	'cpp',
	'css',
	'dart',
	'dockerfile',
	'dot',
	'elixir',
	'elm',
	'fish',
	'go',
	'haskell',
	'hjson',
	'help',
	'html',
	'http',
	'java',
	'javascript',
	'jsdoc',
	'json',
	'json5',
	'jsonc',
	'kotlin',
	'llvm',
	'lua',
	'make',
	'markdown',
	'ninja',
	'pug',
	'python',
	'regex',
	'rust',
	'scala',
	'scss',
	'todotxt',
	'toml',
	'tsx',
	'typescript',
	'v',
	'vue',
	'vim',
	'yaml'
    },
    sync_install = true,
    highlight = {
        enable = true
    }
}

-- Setup lsp_signature
require'lsp_signature'.setup {
    bind = true
}

dofile('/home/beton/.config/nvim/cmp.lua')
