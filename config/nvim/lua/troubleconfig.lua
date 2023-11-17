local M = {
	"folke/trouble.nvim",
	config = function()
		vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>", { silent = true, noremap = true })
		vim.keymap.set("n", "<leader>xw", "<cmd>Trouble lsp_workspace_diagnostics<cr>",
			{ silent = true, noremap = true })
		vim.keymap.set("n", "<leader>xd", "<cmd>Trouble lsp_document_diagnostics<cr>",
			{ silent = true, noremap = true })
		vim.keymap.set("n", "<leader>xl", "<cmd>Trouble loclist<cr>", { silent = true, noremap = true })
		vim.keymap.set("n", "<leader>xq", "<cmd>Trouble quickfix<cr>", { silent = true, noremap = true })
	end
}
return M
