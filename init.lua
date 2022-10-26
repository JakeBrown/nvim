
local vim = vim
vim.cmd [[set nocompatible]]
vim.cmd [[set clipboard=unnamed]]
vim.cmd [[set encoding=UTF-8]]


vim.cmd [[
set mouse=a
syntax enable
syntax on
set relativenumber
set rnu
set wildmenu
set wildmode=longest:list,full
colorscheme NeoSolarized

nnoremap <leader>% :MtaJumpToOtherTag<cr>
set tabstop=2 shiftwidth=2 expandtab
set laststatus=2
set wrap!
set number
set confirm
set hidden

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
vnoremap <C-c> "+y

set autoread

" My mappings
" Folding
nnoremap <Space>o zR<CR>
nnoremap <Space>c zM<CR>
nnoremap <Space>c zM<CR>
" Buffer commands
nnoremap gl :buffers<CR>:buffer<Space>
nnoremap <Up> :ter ++curwin<CR>
tnoremap <Up> <C-w>:ter ++curwin<CR>
nnoremap <Down> :bd<CR>
tnoremap <Down> <C-w>:bd!<CR>
nnoremap <Right> :bnext<CR>
nnoremap <Left> :bprevious<CR>
tnoremap <Right> <C-w>:bnext<CR>
tnoremap <Left> <C-w>:bprevious<CR>

set signcolumn=yes

set foldenable
filetype indent on
filetype plugin on

set noswapfile
set hlsearch
set ignorecase
set incsearch
let g:miniBufExplBRSplit = 0


hi link MBEVisible Error
set noeb vb t_vb=

nnoremap <leader>f :Autoformat<CR>
nnoremap <leader>e :NERDTreeToggle<CR>
set completeopt=menuone
inoremap <S-TAB> <C-X><C-O>
]]


vim.opt.guifont = { "Fira Code Retina", ":h15" }


-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
end

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}
require('lspconfig')['pyright'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
}
require('lspconfig')['tsserver'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
}
require('lspconfig')['svelte'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
}
