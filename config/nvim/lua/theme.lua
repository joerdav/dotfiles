local cmd = vim.cmd
require("nvim-treesitter.configs").setup({
	highlight = {
		enable = true,
	},
})
cmd([[colorscheme dracula]])
cmd([[hi Normal ctermbg=16 guibg=#000000]])
cmd([[hi LineNr ctermbg=16 guibg=#000000]])
cmd([[hi EndOfBuffer ctermbg=16 guibg=#000000]])
cmd([[hi EndOfBuffer ctermbg=16 guibg=#000000]])
cmd([[hi Pmenu guibg=NONE]])

require("lualine").setup({
	options = {
		theme = "dracula-nvim",
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
