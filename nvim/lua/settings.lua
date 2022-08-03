vim.o.syntax = 'on'
vim.o.errorbells = false
vim.o.swapfile = false

-- Tabs
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.smartindent = true

-- Show line numbers and relative line numbers
vim.o.number = true
vim.o.relativenumber = true

-- No highlights when searching
vim.o.hlsearch = false

-- Search is case insensitive if all input is lowercase
-- or case sensitive otherwise
vim.o.ignorecase = true
vim.o.smartcase = true

-- Start scrolling when the cursor is 8 lines from the bottom of the editor
vim.o.scrolloff = 8

-- Extra column on the left for extra information, i.e. git integrations
vim.o.signcolumn = 'yes'

-- Enable mouse input
vim.o.mouse = 'a'

-- Use the system's clipboard as a buffer
vim.o.clipboard = 'unnamedplus'

-- Highlight the line where the cursor is
vim.o.cursorline = true

-- If the terminal emulator supports it, display true colors
vim.o.termguicolors = true

-- Change the way splits open, to be more natural
vim.o.splitbelow = true
vim.o.splitright = true

-- Make folding be based on the language
vim.o.foldmethod = 'syntax'
vim.o.foldlevelstart = 30

-- GUI
vim.o.guifont = 'JetBrains Mono:h11'
vim.g.neovide_transparency = 0.85
