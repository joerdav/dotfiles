return {
	"VonHeikemen/lsp-zero.nvim",
	dependencies = {
		"nvim-telescope/telescope.nvim",
		"hrsh7th/cmp-nvim-lsp",
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"neovim/nvim-lspconfig",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-nvim-lua",
		"hrsh7th/cmp-path",
		"hrsh7th/nvim-cmp",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
	},
	config = function()
		local lsp = require("lsp-zero")

		lsp.preset("recommended")

		local cmp = require("cmp")
		local luasnip = require("luasnip")
		local min_keyword_length = 5

		cmp.setup({
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-n>"] = cmp.mapping.select_next_item(),
				["<C-p>"] = cmp.mapping.select_prev_item(),
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-y>"] = cmp.mapping.confirm({ select = true }),
				["<C-Space>"] = cmp.mapping.complete({}),
				["<C-l>"] = cmp.mapping(function()
					if luasnip.expand_or_locally_jumpable() then
						luasnip.expand_or_jump()
					end
				end, { "i", "s" }),
				["<C-h>"] = cmp.mapping(function()
					if luasnip.locally_jumpable(-1) then
						luasnip.jump(-1)
					end
				end, { "i", "s" }),
			}),
			sources = {
				{ name = "luasnip" },
				{ name = "nvim_lua" },
				{ name = "nvim_lsp" },
				{ name = "buffer", keyword_length = min_keyword_length },
				{ name = "path", keyword_length = min_keyword_length },
			},
		})

		lsp.set_preferences({
			suggest_lsp_servers = false,
			sign_icons = {
				error = "E",
				warn = "W",
				hint = "H",
				info = "I",
			},
		})

		lsp.on_attach(function()
			local builtin = require("telescope.builtin")

			vim.keymap.set(
				"n",
				"<leader>lrr",
				builtin.lsp_references,
				{ silent = true, noremap = true, desc = "[L]SP [R]efe[R]ences" }
			)
			vim.keymap.set(
				"n",
				"<leader>lws",
				builtin.lsp_workspace_symbols,
				{ silent = true, noremap = true, desc = "[L]SP [W]orkspace [S]ymbols" }
			)
			vim.keymap.set(
				"n",
				"<leader>lds",
				builtin.lsp_document_symbols,
				{ silent = true, noremap = true, desc = "[L]SP [D]ocument [S]ymbols" }
			)
			vim.keymap.set(
				"n",
				"<leader>ldd",
				builtin.diagnostics,
				{ silent = true, noremap = true, desc = "[L]SP [D]iagnostics" }
			)
			vim.keymap.set("n", "<leader>lca", function()
				vim.lsp.buf.code_action()
			end, { silent = true, noremap = true, desc = "[L]SP [C]ode [A]ction" })
			vim.keymap.set("n", "<leader>lrn", function()
				vim.lsp.buf.rename()
			end, { silent = true, noremap = true, desc = "[L]SP [R]e[N]ame" })
			vim.keymap.set("n", "<leader>lcl", function()
				vim.lsp.codelens.refresh()
			end, { silent = true, noremap = true, desc = "[L]SP [C]ode[L]ens Refresh" })
			vim.keymap.set("n", "<leader>lcr", function()
				vim.lsp.codelens.run()
			end, { silent = true, noremap = true, desc = "[L]SP [C]odelens [R]un" })

			vim.keymap.set("n", "gd", function()
				vim.lsp.buf.definition()
			end, { silent = true, noremap = true, desc = "[G]oto [D]efinition" })
			vim.keymap.set("n", "K", function()
				vim.lsp.buf.hover()
			end, { silent = true, noremap = true, desc = "[K]eyword" })

			vim.keymap.set(
				"n",
				"<leader>lsr",
				"<cmd>LspRestart<cr>",
				{ silent = true, noremap = true, desc = "[L][S]P [R]estart" }
			)
		end)

		require("mason-tool-installer").setup({
			ensure_installed = {
				"htmx-lsp",
				-- nil
				"nil",
				-- templ
				"html",
				"tailwindcss",
				-- go
				"golangci-lint",
				"golangci_lint_ls",
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
				-- "proto",
				"buf",
				-- rust
				"rust-analyzer",
				-- misc
				"editorconfig-checker",
				"codespell",
				"css-lsp",
				"gitlint",
				"json-lsp",
				"sqlls",
				-- lua
				"lua_ls",
			},
			auto_update = false,
			run_on_start = true,
			start_delay = 3000, -- 3 second delay
			debounce_hours = 5,
		})

		require("mason").setup({})
		require("mason-lspconfig").setup({
			ensure_installed = {},
			handlers = {
				lsp.default_setup,
				["templ"] = function()
					require("lspconfig").templ.setup({
						cmd = { "templ", "lsp", "-http=localhost:7474", "-log=/Users/joe.davidson/templ.log" },
					})
				end,
				["html"] = function()
					require("lspconfig").html.setup({
						filetypes = { "html", "templ" },
					})
				end,
				["htmx"] = function()
					require("lspconfig").htmx.setup({
						filetypes = { "html", "templ" },
					})
				end,
				["tailwindcss"] = function()
					require("lspconfig").tailwindcss.setup({
						filetypes = { "html", "templ" },
						init_options = { userLanguages = { templ = "html" } },
					})
				end,
				["gopls"] = function()
					require("lspconfig").gopls.setup({
						on_init = function(client)
							client.config.flags = {
								allow_incremental_sync = false,
							}
						end,
						settings = {
							usePlaceholders = true,
							gofumpt = true,
							analyses = {
								nilness = true,
								unusedparams = true,
								unusedwrite = true,
								useany = true,
							},
							gopls = {
								buildFlags = { "-tags=integration" },
								codelenses = {
									gc_details = true,
									generate = true,
									regenerate_cgo = true,
									run_govulncheck = true,
									test = true,
									tidy = true,
									upgrade_dependency = true,
									vendor = true,
								},
							},
							experimentalPostfixCompletions = true,
							completeUnimported = true,
							staticcheck = true,
							directoryFilters = { "-.git", "-node_modules" },
							semanticTokens = true,
							hints = {
								assignVariableTypes = true,
								compositeLiteralFields = true,
								compositeLiteralTypes = true,
								constantValues = true,
								functionTypeParameters = true,
								parameterNames = true,
								rangeVariableTypes = true,
							},
						},
					})
				end,
				["lua_ls"] = function()
					require("lspconfig").lua_ls.setup({
						settings = {
							Lua = {
								runtime = {
									-- Tell the language server which version of Lua you're using
									-- (most likely LuaJIT in the case of Neovim)
									version = "LuaJIT",
								},
								diagnostics = {
									-- Get the language server to recognize the `vim` global
									globals = {
										"vim",
										"require",
									},
								},
								workspace = {
									-- Make the server aware of Neovim runtime files
									library = vim.api.nvim_get_runtime_file("", true),
								},
								-- Do not send telemetry data containing a randomized but unique identifier
								telemetry = {
									enable = false,
								},
							},
						},
					})
				end,
			},
		})
		require("lspconfig").templ.setup({
			cmd = {
				"templ",
				"lsp",
				"-http=localhost:7474",
				"-log=/Users/joe.davidson/templ.log",
				"-goplsLog=/Users/joe.davidson/tgo.log",
				"-goplsRPCTrace",
			},
		})
		require("lspconfig").gdscript.setup({})
		lsp.setup()

		vim.diagnostic.config({
			virtual_text = true,
		})
	end,
}
