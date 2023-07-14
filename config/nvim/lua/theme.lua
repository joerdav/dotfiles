local cmd = vim.cmd
local dark = true
require("nvim-treesitter.configs").setup({
	highlight = {
		enable = true,
	},
})
local colorscheme = "jellybeans"
if dark then
	cmd([[
	  let g:jellybeans_overrides = {
	  \    'background': { 'guibg': '000000' },
	  \    'SignColumn': { 'guibg': '000000' },
	  \}
	  colorscheme jellybeans
	]])
else
	cmd([[
		let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
		let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
		set termguicolors
		set background=light
		let g:gruvbox_contrast_light='hard'
		colorscheme gruvbox
	]])
	colorscheme = "gruvbox_light"
end

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
