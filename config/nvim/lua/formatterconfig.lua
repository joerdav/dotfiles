local M = {
	"mhartington/formatter.nvim",
	config = function()
		local js = {
			require("formatter.filetypes.javascript").prettierd,
			require("formatter.filetypes.javascript").eslint_d,
		}
		require("formatter").setup({
			logging = false,
			filetype = {
				javascript = js,
				javascriptreact = js,
				typescript = js,
				typescriptreact = js,
				["*"] = {
					function()
						local formatters = require("formatter.util")
						    .get_available_formatters_for_ft(vim.bo.filetype)
						if #formatters > 0 then
							return
						end
						vim.lsp.buf.format {}
					end,
				},
			},
		})
	end
}

return M
