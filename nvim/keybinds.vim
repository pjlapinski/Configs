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

" Kill the current buffer
nmap <leader>q :bd!<CR>

" Navigation between buffers
nmap <leader>wn <C-w>n:Explore .<CR>
nmap <leader>wv <C-w>v:Explore .<CR>
nmap <leader>h <C-w>h
nmap <leader>j <C-w>j
nmap <leader>k <C-w>k
nmap <leader>l <C-w>l

" Cycle tabs
nmap <S-Tab> gt

"- Plugin binds

" Comment selected lines
nmap <C-_> :call nerdcommenter#Comment('n', 'Toggle')<CR>
vmap <C-_> :call nerdcommenter#Comment('x', 'Toggle')<CR>
" For neovide
nmap <C-/> :call nerdcommenter#Comment('n', 'Toggle')<CR>
vmap <C-/> :call nerdcommenter#Comment('x', 'Toggle')<CR>

" Open a new tab with file explorer
nmap <leader>tn :tabnew<CR>:Explore<CR>

" Open NERDTree
nmap <C-n> :NERDTreeToggle<CR>

" LSP
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <C-s> <cmd>lua vim.lsp.buf.signature_help()<CR>

inoremap <silent><expr> <C-space> compe#complete()
inoremap <silent><expr> <c-@> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')

