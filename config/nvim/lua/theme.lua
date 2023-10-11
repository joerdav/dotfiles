local cmd = vim.cmd
local dark = true
local parser_install_dir = vim.fn.expand("~/treesitters")
vim.fn.mkdir(parser_install_dir, "p")
vim.opt.runtimepath:append(parser_install_dir)
local treesitter_parser_config = require("nvim-treesitter.parsers").get_parser_configs()
treesitter_parser_config.templ = {
	install_info = {
		url = "https://github.com/vrischmann/tree-sitter-templ.git",
		files = { "src/parser.c", "src/scanner.c" },
		branch = "master",
	},
}

vim.treesitter.language.register("templ", "templ")

cmd[[
	au BufRead,BufNewFile *.templ		setfiletype templ
]]

require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"templ", "go"
	},
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	parser_install_dir = parser_install_dir,
})

require("themer").setup({
	colorscheme = "jellybeans",
	transparent = true,
	styles = {
		["function"] = { style = "italic" },
		functionbuiltin = { style = "italic" },
		variable = { style = "italic" },
		variableBuiltIn = { style = "italic" },
		parameter = { style = "italic" },
	},
})

require("lualine").setup({
	options = {
		component_separators = { left = "|", right = "|" },
		section_separators = { left = "", right = "" },
		theme = colorscheme,
	},
	extensions = { "man", "fugitive" },
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = { { "filename", path = 1 } },
		lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { { "filename", path = 1 } },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
})
