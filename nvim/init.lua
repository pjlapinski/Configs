require'settings'
require'keybinds'

-- Make sure to install vim-plug and run :PlugInstall
local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugged')
    Plug 'lewis6991/impatient.nvim' --Startup time improvements

    -- Themes
    Plug 'Shatur/neovim-ayu' --Theme
    Plug 'briones-gabriel/darcula-solid.nvim' --Theme
    Plug 'rktjmp/lush.nvim' --Darcula requirement
    Plug 'ellisonleao/gruvbox.nvim' --Theme
    Plug 'Mofiqul/dracula.nvim' --Theme
    Plug 'chrisbra/colorizer' --Color the colornames and codes

    -- Status line style
    Plug 'bling/vim-airline' --Powerline
    Plug 'vim-airline/vim-airline-themes' --Powerline theme

    -- Commenting selected lines
    Plug 'preservim/nerdcommenter' --Ctrl+/ to toggle comment

    -- File explorer
    Plug 'preservim/nerdtree'
    Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'francoiscabrol/ranger.vim'
    Plug 'rbgrouleff/bclose.vim'

    -- LSP
    Plug 'williamboman/mason.nvim'
    Plug 'neovim/nvim-lspconfig'
    Plug 'tmsvg/pear-tree' --Auto insert bracket pairs
    Plug ('nvim-treesitter/nvim-treesitter', {['do'] = ':TSUpdate'})
    Plug 'tell-k/vim-autopep8'
    Plug 'ray-x/lsp_signature.nvim'

    -- cmp
    Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'saadparwaiz1/cmp_luasnip'
    Plug 'L3MON4D3/LuaSnip'

    -- Git
    Plug 'airblade/vim-gitgutter'
    Plug 'kdheepak/lazygit.nvim'

    -- Misc
    Plug 'machakann/vim-highlightedyank' --Highlights yanked text
    Plug 'ahmedkhalf/lsp-rooter.nvim' --Changes the rootdir automagically
    Plug 'folke/which-key.nvim' --Displays possible key cords
    Plug 'preservim/vim-indent-guides' --Highlights indents
vim.call('plug#end')

require'impatient'

--- Theme
require"gruvbox".setup({
    contrast = "soft"
})

vim.o.bg = 'dark'
vim.cmd 'colorscheme gruvbox'
vim.cmd 'set termguicolors'
vim.g.colorizer_auto_color = 1

-- Airline
vim.g.airline_powerline_fonts = 1
vim.g.airline_theme = 'wombat'
vim.g['airline#extensions#tabline#enabled'] = 1

-- Indent guides
vim.g.indent_guides_enable_on_vim_startup = 1
vim.g.indent_guides_default_mapping = 0
vim.g.indent_guides_guide_size = 1

-- Colorizing color names
vim.g.colorizer_auto_color = 1

-- NERDCommenter settings
vim.NERDSpaceDelims = 1
vim.g.NERDDefaultAlign = 'left'
vim.g.NERDCreateDefaultMappings = 0

-- NERDTree
vim.g.NERDTreeCustomOpenArgs = {['file'] = {['where'] = 't'}}
vim.g.NERDTreeShowHidden = true
vim.g.NERDTreeShowLineNumbers = true
vim.g.NERDTreeWinPos = 'right'
vim.g.NERDTreeHijackNetrw = false
vim.g.NERDTreeWinSize = 38

-- Run ranger instead of netrw or NERDTree
vim.g.ranger_replace_netrw = true

-- Disable ranger plugin mapping to map this manually later
vim.g.ranger_map_keys = 0

-- Disable gitgutter mappings
vim.g.gitgutter_map_keys = 0

-- Enable smart pairing in pear-tree
vim.g.pear_tree_smart_openers = 0
vim.g.pear_tree_smart_closers = 0
vim.g.pear_tree_smart_backspace = 0

vim.g.pear_tree_map_special_keys = 0

vim.api.nvim_create_autocmd('BufWritePre', {
    pattern = '!.exs',
    desc = 'Autoformat code on buffer save',
    callback = function()
        vim.lsp.buf.format({
            async=true
        })
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

-- Setup LSP servers, cmp and mason
local capabilities = require'cmp_nvim_lsp'.default_capabilities()

local nvim_lsp = require'lspconfig'

local servers = {
    clangd = {capabilities = capabilities},
    jedi_language_server = {capabilities = capabilities},
    rust_analyzer = {capabilities = capabilities},
    ols = {capabilities = capabilities},
    elixirls = {capabilities = capabilities, cmd = { 'elixir-ls' }},
}

for lsp, options in pairs(servers) do
    nvim_lsp[lsp].setup(options)
end

local luasnip = require'luasnip'

local cmp = require'cmp'
cmp.setup {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true
        }
    }),
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' }
    }
}

require"mason".setup()

-- Change diagnostics behaviour - don't show 'virtual text', but show a floating window on hover
vim.diagnostic.config({ 
    update_in_insert = true,
    virtual_text = false
})
vim.o.updatetime = 250 vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]


-- Setup treesitter highlighting
require'nvim-treesitter.configs'.setup {
   ensure_installed = {
   'bash',
   'c',
   'c_sharp',
   'cmake',
   'comment',
   'cpp',
   'css',
   'dockerfile',
   'dot',
   'elixir',
   'fish',
   'go',
   'haskell',
   'hjson',
   'html',
   'http',
   'javascript',
   'jsdoc',
   'json',
   'json5',
   'jsonc',
   'llvm',
   'lua',
   'make',
   'markdown',
   'odin',
   'pug',
   'python',
   'regex',
   'rust',
   'scss',
   'todotxt',
   'toml',
   'tsx',
   'typescript',
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

require'which-key'.setup { }

vim.g.ranger_command_override = 'ranger --cmd "set show_hidden=true"'
