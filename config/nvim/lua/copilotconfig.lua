local M = {
	"github/copilot.vim",
	config = function()
		-- Copilot setup.
		vim.g.copilot_no_tab_map = true
		vim.g.copilot_assume_mapped = true
		vim.keymap.set(
			"i",
			"<C-]>",
			'copilot#Accept("<CR>")',
			{ noremap = true, silent = true, expr = true, replace_keycodes = false }
		)
	end
}

return M
