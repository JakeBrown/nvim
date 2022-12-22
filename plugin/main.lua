require("packer").startup(function(use)
	use("wbthomason/packer.nvim")
	use("overcache/NeoSolarized")
	use("ryanoasis/vim-devicons")
	use("ap/vim-buftabline")
	use("Chiel92/vim-autoformat")
	use("preservim/nerdtree")
	use("othree/html5.vim")
	use("pangloss/vim-javascript")
	use("neovim/nvim-lspconfig")
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-cmdline")
	use("hrsh7th/nvim-cmp")
	use("kyazdani42/nvim-web-devicons")
	use("folke/trouble.nvim")
	use("onsails/lspkind.nvim")
	use("folke/lsp-colors.nvim")
	use("evanleck/vim-svelte")
	use({
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
	})
	use({ "zbirenbaum/copilot.lua" })
	use({ "mhartington/formatter.nvim" })
	use({
		"zbirenbaum/copilot-cmp",
		after = { "copilot.lua" },
		method = "getCompletionsCycling",
		config = function()
			require("copilot_cmp").setup()
		end,
	})
end)

