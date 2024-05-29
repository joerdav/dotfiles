return {
	"folke/trouble.nvim",
	config = function()
		vim.keymap.set(
			"n",
			"<leader>tt",
			"<cmd>TroubleToggle<cr>",
			{ silent = true, noremap = true, desc = "[T]rouble [T]oggle" }
		)
	end,
}
