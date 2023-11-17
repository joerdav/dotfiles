local M = {
	"junegunn/fzf.vim",
	dependencies = {
		"junegunn/fzf",
		"preservim/vimux",
	},
	config = function()

		vim.keymap.set("n", "<C-g>", "<cmd>GFiles<cr>", { silent = true, noremap = true })
		vim.keymap.set("n", "<C-p>", "<cmd>Files<cr>", { silent = true, noremap = true })
		vim.keymap.set("n", "<C-b>", "<cmd>Buffers<cr>", { silent = true, noremap = true })
		vim.keymap.set("n", "<C-x>", "<cmd>Commands<cr>", { silent = true, noremap = true })
		vim.keymap.set(
			"n",
			"<leader>x",
			"<cmd>call fzf#run({'source':'xc -short', 'options': '--prompt \"xc> \" --preview \"xc -d {} | glow --style dark\"', 'sink': 'VimuxRunCommand \"xc\"', 'window': {'width': 0.9, 'height': 0.6}})<cr>",
			{ silent = false, noremap = true }
		)
	end
}

return M
