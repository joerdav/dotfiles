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
		-- Format current buffer using LSP.
		vim.api.nvim_create_autocmd(
			{
				"BufEnter"
			},
			{
				callback = function(args)
					if args.file:find("aviva-verde", 1, true) then
						vim.b['copilot_enabled'] = 0
					end
				end,
			}
		)
	end
}

return M
