set nocompatible
set clipboard=unnamed
call plug#begin('~/.vim/plugged')
Plug 'overcache/NeoSolarized'
Plug 'ap/vim-buftabline'
Plug 'Chiel92/vim-autoformat'
Plug 'preservim/nerdtree'

Plug 'othree/html5.vim'
Plug 'pangloss/vim-javascript'
Plug 'evanleck/vim-svelte', {'branch': 'main'}

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'folke/trouble.nvim'
Plug 'folke/lsp-colors.nvim'
Plug 'ryanoasis/vim-devicons'
call plug#end()

set encoding=UTF-8

syntax enable
syntax on

set relativenumber
set rnu

nnoremap <leader>% :MtaJumpToOtherTag<cr>
set tabstop=2 shiftwidth=2 expandtab
set laststatus=2
set wrap!
set number
set confirm
set hidden

colorscheme NeoSolarized
let g:neovide_cursor_animation_length=0.03


set wildmenu
set wildmode=longest:list,full

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
