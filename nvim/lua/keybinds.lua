-- Come on Vim, be consistent
vim.api.nvim_set_keymap('n', 'Y', 'y$', { noremap = true })
vim.api.nvim_set_keymap('n', 'S', 'c$', { noremap = true })

-- Keep cursor at the same position with J
vim.api.nvim_set_keymap('n', 'J', 'mzJ`z', { noremap = true })

-- Keep the search centered
vim.api.nvim_set_keymap('n', 'n', 'nzzzv', { noremap = true })
vim.api.nvim_set_keymap('n', 'N', 'Nzzzv', { noremap = true })

-- Additional undo break points
vim.api.nvim_set_keymap('i', ',', ',<C-g>u', { noremap = true })
vim.api.nvim_set_keymap('i', '.', '.<C-g>u', { noremap = true })
vim.api.nvim_set_keymap('i', '!', '!<C-g>u', { noremap = true })
vim.api.nvim_set_keymap('i', '?', '?<C-g>u', { noremap = true })

-- Moving text around
vim.api.nvim_set_keymap('v', '<C-j>', ":m '>+1<CR>gv=gv", { noremap = true })
vim.api.nvim_set_keymap('v', '<C-k>', ":m '<-2<CR>gv=gv", { noremap = true })
vim.api.nvim_set_keymap('i', '<C-j>', "<esc>:m .+1<CR>==", { noremap = true })
vim.api.nvim_set_keymap('i', '<C-k>', "<esc>:m .-2<CR>==", { noremap = true })
vim.api.nvim_set_keymap('n', '<C-j>', ":m .+1<CR>==", { noremap = true })
vim.api.nvim_set_keymap('n', '<C-k>', ":m .-2<CR>==", { noremap = true })

vim.g.mapleader = ' '

-- Navigation between buffers
vim.api.nvim_set_keymap('n', '<leader>wn', "<C-w>n:Ranger<CR>", {})
vim.api.nvim_set_keymap('n', '<leader>wv', "<C-w>v:Ranger<CR>", {})
vim.api.nvim_set_keymap('n', '<leader>h', "<C-w>h", {})
vim.api.nvim_set_keymap('n', '<leader>j', "<C-w>j", {})
vim.api.nvim_set_keymap('n', '<leader>k', "<C-w>k", {})
vim.api.nvim_set_keymap('n', '<leader>l', "<C-w>l", {})

-- Close current tab
vim.api.nvim_set_keymap('n', '<leader>q', ':tab bd<CR>', {})

-- Cycle tabs
vim.api.nvim_set_keymap('n', '<S-Tab>', 'gt', {})

--- Plugin binds

-- Open ranger
vim.api.nvim_set_keymap('n', '<leader>f', ':RangerNewTab<CR>', { noremap = true });

-- Open up LazyGit
vim.api.nvim_set_keymap('n', '<leader>gg', ':LazyGit<CR>', { noremap = true, silent = true })

-- Comment selected lines
vim.api.nvim_set_keymap('n', '<C-/>', ":call nerdcommenter#Comment('n', 'Toggle')<CR>", {})
vim.api.nvim_set_keymap('v', '<C-/>', ":call nerdcommenter#Comment('x', 'Toggle')<CR>", {})

-- Open a new tab with file explorer
vim.api.nvim_set_keymap('n', '<leader>tn', ":tabnew<CR><leader>f", {})

 --Open NERDTree
vim.api.nvim_set_keymap('n', '<C-n>', ':NERDTreeToggle<CR>:NERDTreeRefreshRoot<CR>', {})

-- LSP
vim.api.nvim_set_keymap('n', 'gd', ':lua vim.lsp.buf.definition()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gD', ':lua vim.lsp.buf.declaration()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gr', ':lua vim.lsp.buf.references()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gi', ':lua vim.lsp.buf.implementation()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gc', ':lua vim.lsp.buf.code_action()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'K', ':lua vim.lsp.buf.hover()<CR>', { noremap = true, silent = true })
