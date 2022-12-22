local vim = vim

vim.cmd([[set nocompatible]])
vim.cmd([[set clipboard=unnamed]])
vim.cmd([[set encoding=UTF-8]])

vim.cmd([[
nnoremap <silent> <leader>f :Format<CR>
autocmd BufWritePre *.tsx,*.ts,*.jsx,*.js EslintFixAll

set termguicolors
set mouse=a
syntax enable
syntax on
set relativenumber
set rnu
set wildmenu
set wildmode=longest:list,full
colorscheme NeoSolarized

nnoremap <leader>% :MtaJumpToOtherTag<cr>
set tabstop=4 shiftwidth=4 expandtab
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

nnoremap <leader>e :Neotree toggle<CR>
set completeopt=menuone
inoremap <S-TAB> <C-X><C-O>

]])

-- Utilities for creating configurations
local util = require("formatter.util")

-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
require("formatter").setup({
	-- Enable or disable logging
	logging = true,
	-- Set the log level
	log_level = vim.log.levels.WARN,
	-- All formatter configurations are opt-in
	filetype = {
		-- Formatter configurations for filetype "lua" go here
		-- and will be executed in order
		lua = {
			require("formatter.filetypes.lua").stylua,
		},

		typescript = {
			require("formatter.filetypes.typescript").prettier,
		},

		javascript = {
			require("formatter.filetypes.javascript").prettier,
		},

		svelte = {
			require("formatter.filetypes.svelte").prettier,
		},

		json = {
			require("formatter.filetypes.json").prettier,
		},

		-- Use the special "*" filetype for defining formatter configurations on
		-- any filetype
		["*"] = {
			-- "formatter.filetypes.any" defines default configurations for any
			-- filetype
			require("formatter.filetypes.any").remove_trailing_whitespace,
		},
	},
})

vim.opt.guifont = { "Fira Code Retina", ":h15" }

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
	vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
	vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
	vim.keymap.set("n", "<space>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
	vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
	vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
end

local lsp_flags = {
	-- This is the default in Nvim 0.7+
	debounce_text_changes = 150,
}
require("lspconfig")["pyright"].setup({
	on_attach = on_attach,
	flags = lsp_flags,
})
require("lspconfig")["tsserver"].setup({
	on_attach = on_attach,
	flags = lsp_flags,
})
require("lspconfig")["svelte"].setup({
	on_attach = on_attach,
	flags = lsp_flags,
})


require("lspconfig").eslint.setup({ 
    root_dir = require("lspconfig").util.root_pattern("package.json")
})

-- Add additional capabilities supported by nvim-cmp
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local lspconfig = require("lspconfig")

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = { "clangd", "rust_analyzer", "pyright", "tsserver" }
for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		-- on_attach = my_custom_on_attach,
		capabilities = capabilities,
	})
end

local lspkind = require("lspkind")

-- nvim-cmp setup
local cmp = require("cmp")
cmp.setup({

	formatting = {
		format = lspkind.cmp_format({
			mode = "symbol_text",
			max_width = 50,
			symbol_map = { Copilot = "" },
		}),
	},
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	}),
	sources = cmp.config.sources({
		{ name = "copilot" },
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
	}, {
		{ name = "buffer" },
	}),
})

require("copilot").setup({
	filetypes = {
		yaml = false,
		markdown = false,
		help = false,
		gitcommit = false,
		gitrebase = false,
		hgcommit = false,
		svn = false,
		cvs = false,
		["."] = false,
	},
	copilot_node_command = "node", -- Node.js version must be > 16.x
	server_opts_overrides = {},
})

vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#AAFF00" })
vim.api.nvim_set_hl(0, "CmpItemKindVariable", { fg = "white" })
vim.api.nvim_set_hl(0, "CmpItemKindMethod", { fg = "#268bd2" })
vim.api.nvim_set_hl(0, "CmpItemKindFunction", { fg = "#268bd2" })
