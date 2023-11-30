local M = {
	"nvim-neorg/neorg",
	build = ":Neorg sync-parsers",
	dependencies = { { "nvim-lua/plenary.nvim" }, { "nvim-neorg/neorg-telescope" } },
	config = function()
		require("neorg").setup {
			load = {
				["core.defaults"] = {},
				["core.concealer"] = {},
				["core.integrations.telescope"] = {},
				["core.journal"] = {},
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
