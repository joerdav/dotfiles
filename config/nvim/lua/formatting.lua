local prett = function()
	return {
		exe = "prettierd",
		args = { vim.api.nvim_buf_get_name(0) },
		stdin = true,
	}
end

local util = require("formatter.util")
require("formatter").setup({
	logging = false,
	filetype = {
		javascript = { prett },
		javascriptreact = { prett },
		typescriptreact = { prett },
		typescript = { prett },
		html = { prett },
		nix = {
			function()
				return {
					exe = "nixpkgs-fmt",
					stdin = true,
				}
			end,
		},
		rust = {
			function()
				return {
					exe = "rustfmt",
					stdin = true,
				}
			end,
		},
		go = {
			function()
				return {
					exe = "gofmt",
					stdin = true,
				}
			end,
		},
		lua = {
			function()
				return {
					exe = "stylua",
					args = {
						"--search-parent-directories",
						"--",
						"-",
					},
					stdin = true,
				}
			end,
		},
		templ = {
			function()
				return {
					exe = "templ fmt",
					stdin = true,
				}
			end,
		},
	},
})
