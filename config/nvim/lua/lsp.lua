local mason_lsp_config = require("mason-lspconfig")
local lspconfig = require("lspconfig")
local configs = require("lspconfig.configs")
local cmp = require("cmp")

require("mason").setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})
require("mason-tool-installer").setup({

	-- a list of all tools you want to ensure are installed upon
	-- start; they should be the names Mason uses for each tool
	ensure_installed = {
		-- templ
		"templ",
		-- go
		"golangci-lint",
		"gopls",
		"shellcheck",
		"gofumpt",
		"golines",
		"gomodifytags",
		"gotests",
		"json-to-struct",
		"staticcheck",
		"misspell",
		"revive",
		"impl",
		"delve",
		-- bash
		"bash-language-server",
		"shellcheck",
		"shfmt",
		-- python
		"jedi-language-server",
		"flake8",
		"black",
		"isort",
		"mypy",
		"pylint",
		-- terraform
		"tflint",
		--"terraform-ls",
		-- javascript
		"eslint-lsp",
		"prettier",
		"eslint_d",
		-- lua
		"lua-language-server",
		"stylua",
		-- "proto",
		"buf",
		-- misc
		"editorconfig-checker",
		"codespell",
		"css-lsp",
		"gitlint",
		"json-lsp",
		"sqlls",
		"yaml-language-server",
	},

	-- if set to true this will check each tool for updates. If updates
	-- are available the tool will be updated. This setting does not
	-- affect :MasonToolsUpdate or :MasonToolsInstall.
	-- Default: false
	auto_update = true,

	-- automatically install / update on startup. If set to false nothing
	-- will happen on startup. You can use :MasonToolsInstall or
	-- :MasonToolsUpdate to install tools and check for updates.
	-- Default: true
	run_on_start = true,

	-- set a delay (in ms) before the installation starts. This is only
	-- effective if run_on_start is set to true.
	-- e.g.: 5000 = 5 second delay, 10000 = 10 second delay, etc...
	-- Default: 0
	start_delay = 3000, -- 3 second delay
})
configs.lua_ls = {
	default_config = {
		cmd = { "lua-language-server" },
		filetypes = { "lua" },
		single_file_support = true,
		log_level = vim.lsp.protocol.MessageType.Warning,
		settings = { Lua = { telemetry = { enable = false } } },
	},
}

local on_attach = function(client, bufnr)
	local opts = { buffer = bufnr, remap = false }

	vim.keymap.set("n", "gd", function()
		vim.lsp.buf.definition()
	end, opts)
	vim.keymap.set("n", "K", function()
		vim.lsp.buf.hover()
	end, opts)
	vim.keymap.set("n", "<leader>vws", function()
		vim.lsp.buf.workspace_symbol()
	end, opts)
	vim.keymap.set("n", "<leader>vd", function()
		vim.diagnostic.open_float()
	end, opts)
	vim.keymap.set("n", "[d", function()
		vim.diagnostic.goto_next()
	end, opts)
	vim.keymap.set("n", "]d", function()
		vim.diagnostic.goto_prev()
	end, opts)
	vim.keymap.set("n", "<leader>vca", function()
		vim.lsp.buf.code_action()
	end, opts)
	vim.keymap.set("n", "<leader>vrr", function()
		vim.lsp.buf.references()
	end, opts)
	vim.keymap.set("n", "<leader>vrn", function()
		vim.lsp.buf.rename()
	end, opts)
	vim.keymap.set("i", "<C-h>", function()
		vim.lsp.buf.signature_help()
	end, opts)
end

mason_lsp_config.setup()
mason_lsp_config.setup_handlers({
	function(server_name) -- default handler (optional)
		lspconfig[server_name].setup({
			on_attach = on_attach,
		})
	end,
	["gopls"] = function()
		lspconfig.gopls.setup({
			on_attach = on_attach,
			settings = {
				gopls = {
					env = { GOFLAGS = "-tags=integration" },
					codelenses = {
						generate = true, -- show the `go generate` lens.
						gc_details = true, -- show a code lens toggling the display of gc's choices.
						test = true,
						upgrade_dependency = true,
						tidy = true,
					},
				},
			},
		})
	end,
})
require("luasnip.loaders.from_snipmate").lazy_load({ paths = "~/.config/nvim/snippets" })

local cmp_select = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
	snippet = {
		-- REQUIRED - you must specify a snippet engine
		expand = function(args)
			require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = {
		["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
		["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
		["<C-y>"] = cmp.mapping.confirm({ select = true }),
		["<C-Enter>"] = cmp.mapping.complete(),
	},
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
	}),
})
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline("/", {
	sources = {
		{ name = "buffer" },
	},
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})

local format_group = vim.api.nvim_create_augroup("FormatGroup", { clear = true })
vim.api.nvim_create_autocmd(
	{ "BufRead", "BufNewFile" },
	{ pattern = "*.md", command = "setlocal textwidth=120", group = format_group }
)
vim.api.nvim_create_autocmd("BufWritePost", { pattern = "*", command = "FormatWrite", group = format_group })
vim.api.nvim_create_autocmd(
	{ "BufReadPost", "FileReadPost" },
	{ pattern = "*", command = "normal zR", group = format_group }
)
---- diagnostic
local signs = { Error = " ", Warning = " ", Hint = " ", Information = " " }

for type, icon in pairs(signs) do
	local hl = "LspDiagnosticsSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	virtual_text = {
		signs = true,
	},
})
vim.lsp.set_log_level("debug")
vim.diagnostic.config({
	virtual_text = true,
})

require("cmake-tools").setup({})
-- Copilot setup.
vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
