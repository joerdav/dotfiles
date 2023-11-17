local M = {
	"nvim-neorg/neorg",
	build = ":Neorg sync-parsers",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("neorg").setup {
			load = {
				["core.defaults"] = {},
				["core.concealer"] = {},
				["core.presenter"] = {
					config = {
						zen_mode = "zen-mode",
					},
				},
				["core.dirman"] = {
					config = {
						workspaces = {
							notes = "~/src/joerdav/notes",
						},
						default_workspace = "notes",
					},
				},
			},
		}

		vim.wo.foldlevel = 99
		vim.wo.conceallevel = 2
	end,
}

return M
