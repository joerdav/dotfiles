--- netrw settings
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 1

--- generate neovim settings
vim.opt.splitbelow = true
vim.opt.splitright = true
--vim.opt.clipboard = "unnamedplus" -- always default to system clipboard
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.timeout = true         -- turn on timeout
vim.opt.timeoutlen = 1000      -- set timeout to 1000
vim.opt.inccommand = "nosplit" -- turn on incremental substitution
vim.opt.switchbuf = { "useopen" }
vim.opt.fileencoding = "UTF-8"
vim.opt.number = true
vim.opt.showmode = false
vim.opt.ruler = true
vim.opt.showcmd = true
vim.opt.laststatus = 2 -- always display file name
vim.opt.ttyfast = true
vim.opt.autoread = true
vim.opt.autoindent = true
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.hidden = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.cursorcolumn = false
vim.opt.cursorline = false
vim.opt.pumheight = 10
vim.opt.lazyredraw = true
vim.opt.mouse = ""
vim.opt.termguicolors = true
vim.opt.wildmode = "longest,list,full"
vim.opt.wildmenu = true

--- testing
vim.g.coverage_json_report_path = "coverage/coverage-final.json"
vim.g.coverage_sign_covered = "⦿"
vim.g.coverage_interval = 5000
vim.g.coverage_show_covered = 1
vim.g.coverage_show_uncovered = 1

--- mappings

vim.g.mapleader = " "

--- move lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

--- quick escape insert
vim.keymap.set("i", "jk", "<esc>", { silent = true, noremap = true })

--- useful movement
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

--- past without overwriting
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

--- fix strange issue with keyboard
vim.keymap.set("i", "<A-3>", "#", { silent = true, noremap = true })

--- stop recording every time I press Q
vim.keymap.set("n", "Q", "<nop>")

--- sessionizer
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>f", ':Format<cr>')

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
	"preservim/nerdcommenter",


	"tpope/vim-abolish",
	"tpope/vim-eunuch",
	"tpope/vim-dispatch",
	"tpope/vim-fugitive",
	"rhysd/vim-grammarous",
	"farmergreg/vim-lastplace",
	"tpope/vim-surround",
	"tpope/vim-vinegar",
	"mg979/vim-visual-multi",

	"andythigpen/nvim-coverage",

	"folke/zen-mode.nvim",

	"jghauser/mkdir.nvim",

	"dkprice/vim-easygrep",

	"joerdav/templ.vim",

	require("undotreeconfig"),

	require("harpoonconfig"),

	require("vimtestconfig"),

	require("neorgconfig"),

	require("theme").theme,
	require("theme").lualine,
	require("theme").treesitter,

	require("formatterconfig"),

	require("fzfconfig"),

	require("lsp"),

	require("copilotconfig"),

	require("troubleconfig"),

})
