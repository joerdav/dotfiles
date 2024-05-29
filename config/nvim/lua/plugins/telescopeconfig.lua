return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		{ "joerdav/telescope-xc.nvim", dir = "~/src/joerdav/telescope-xc.nvim" },
		"nvim-lua/plenary.nvim",
		"preservim/vimux",
	},
	config = function()
		local builtin = require("telescope.builtin")
		vim.keymap.set(
			"n",
			"<leader>sf",
			builtin.find_files,
			{ silent = true, noremap = true, desc = "[S]earch [F]iles" }
		)
		vim.keymap.set(
			"n",
			"<leader>sg",
			builtin.live_grep,
			{ silent = true, noremap = true, desc = "[S]earch [G]rep" }
		)
		vim.keymap.set(
			"n",
			"<leader>sb",
			builtin.buffers,
			{ silent = true, noremap = true, desc = "[S]earch [B]uffers" }
		)
		vim.keymap.set(
			"n",
			"<leader>sc",
			builtin.commands,
			{ silent = true, noremap = true, desc = "[S]earch [C]ommands" }
		)

		require("telescope").load_extension("xc")
		vim.keymap.set("n", "<leader>xc", require("telescope").extensions["xc"].run_task, { desc = "[X][C] Tasks" })
	end,
}
