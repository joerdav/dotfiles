return {
	"preservim/nerdcommenter",

	"tpope/vim-abolish",
	"tpope/vim-eunuch",
	"tpope/vim-dispatch",
	"tpope/vim-fugitive",
	"rhysd/vim-grammarous",
	"farmergreg/vim-lastplace",
	"tpope/vim-surround",
	"jiangmiao/auto-pairs",
	"mg979/vim-visual-multi",
	{
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
	},
	"andythigpen/nvim-coverage",

	"jghauser/mkdir.nvim",

	"dkprice/vim-easygrep",

	"joerdav/templ.vim",
}
