local prettierd = function()
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
		javascript = { prettierd },
		javascriptreact = { prettierd },
		typescriptreact = { prettierd },
		typescript = { prettierd },
		html = { prettierd },
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
					exe = "gofumpt",
					stdin = true,
				}
			end,
			function()
				return {
					exe = "goimports",
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
		c = {
			function()
				return {
					exe = "clang-format",
					stdin = true,
					try_node_modules = true,
				}
			end,
		},
	},
})
