local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	"ThePrimeagen/harpoon",
	"ThemerCorp/themer.lua",
	"morhetz/gruvbox",
	"junegunn/fzf",
	"junegunn/fzf.vim",
	"preservim/nerdcommenter",

	"nvim-treesitter/nvim-treesitter",

	"folke/trouble.nvim",

	"tpope/vim-abolish",
	"tpope/vim-eunuch",
	"tpope/vim-dispatch",
	"tpope/vim-fugitive",
	"rhysd/vim-grammarous",
	"farmergreg/vim-lastplace",
	"tpope/vim-surround",
	"tpope/vim-vinegar",
	"mg979/vim-visual-multi",
	"vim-test/vim-test",

	"vrischmann/tree-sitter-templ",

	"mbbill/undotree",

	"nvim-lualine/lualine.nvim",
	"ray-x/lsp_signature.nvim",
	"dkprice/vim-easygrep",
	"joerdav/templ.vim",
	"jakewvincent/mkdnflow.nvim",
	"neovim/nvim-lspconfig",
	"preservim/vimux",
	"mhartington/formatter.nvim",
	"nvim-lua/plenary.nvim",
	"ThePrimeagen/harpoon",
	"andythigpen/nvim-coverage",
	"DingDean/wgsl.vim",
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	"github/copilot.vim",
	"VonHeikemen/lsp-zero.nvim",
	{
		'neovim/nvim-lspconfig',
		dependencies = {
			'hrsh7th/cmp-nvim-lsp',
			'williamboman/mason.nvim',
			'williamboman/mason-lspconfig.nvim',
		}
	},
	{
		'hrsh7th/nvim-cmp',
		dependencies = {
			'hrsh7th/cmp-buffer',
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-nvim-lua',
			'hrsh7th/cmp-path',
			'saadparwaiz1/cmp_luasnip',
			'L3MON4D3/LuaSnip',
		}
	},
}, {
	install = {
		colorscheme = { "jellybeans" },
	}
})
