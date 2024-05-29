return {
	{
		"rebelot/kanagawa.nvim",
		config = function()
			require("kanagawa").setup({
				colors = {
					theme = {
						all = {
							ui = {
								bg = "#000000",
								bg_gutter = "#000000",
							},
						},
					},
				},
			})
			vim.cmd("colorscheme kanagawa-wave")
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "rebelot/kanagawa.nvim" },
		config = function()
			require("lualine").setup({
				options = {
					component_separators = { left = "|", right = "|" },
					section_separators = { left = "", right = "" },
					theme = "kanagawa",
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
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		config = function()
			local parser_install_dir = vim.fn.expand("~/treesitters")
			vim.fn.mkdir(parser_install_dir, "p")
			vim.opt.runtimepath:prepend(parser_install_dir)

			--local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
			--parser_config.templ = {
			--install_info = {
			--url = "~/src/joerdav/tree-sitter-templ", -- local path or git repo
			--files = { "src/parser.c", "src/scanner.c" }, -- note that some parsers also require src/scanner.c or src/scanner.cc
			---- optional entries:
			--branch = "master", -- default branch in case of git repo if different from master
			--},
			--}

			require("nvim-treesitter.configs").setup({
				-- A list of parser names, or "all"
				ensure_installed = { "vimdoc", "javascript", "typescript", "c", "lua", "rust" },

				ignore_install = { "norg" },
				modules = {},

				-- Install parsers synchronously (only applied to `ensure_installed`)
				sync_install = false,

				-- Automatically install missing parsers when entering buffer
				-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
				auto_install = true,
				parser_install_dir = parser_install_dir,

				highlight = {
					-- `false` will disable the whole extension
					enable = true,

					-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
					-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
					-- Using this option may slow down your editor, and you may see some duplicate highlights.
					-- Instead of true it can also be a list of languages
					additional_vim_regex_highlighting = false,
				},
			})
		end,
	},
}
