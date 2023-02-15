local prettierd = function()
	return {
		exe = "prettierd",
		args = {"--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)), '--single-quote'},
		stdin = true,
	}
end
local util = require("formatter.util")
require("formatter").setup({
	log_level = vim.log.levels.INFO,
	filetype = {
		javascript = { prettierd },
		javascriptreact = { prettierd },
		typescriptreact = { prettierd },
		typescript = { prettierd },
		html = { prettierd },
		json = {
			function()
				return {
					exe = "jq",
					args = {"."},
					stdin = true,
				}
			end,
		},
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
		cpp = {
			function()
				return {
					exe = "clang-format",
					stdin = true,
					try_node_modules = true,
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
		["*"] = {
			function()
				return {
					exe = "sed",
					stdin = true,
					args = { "[ \t]*$" },
				}
			end,
		},
	},
})
