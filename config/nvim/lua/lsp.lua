map = require("map")
local luasnip = require("luasnip")
local cmp = require("cmp")
local nvim_lsp = require("lspconfig")
local configs = require("lspconfig.configs")

require("luasnip.loaders.from_snipmate").lazy_load({ paths = "~/.config/nvim/snippets" })

require("lsp_signature").setup({
	bind = true,
	floating_window = true,
	floating_window_above_cur_line = true,
	fix_pos = false,
	hint_enable = false,
	hint_prefix = "🐼 ",
	hint_scheme = "String",
	hi_parameter = "LspSignatureActiveParameter",
	max_height = 12,
	max_width = 120,
	handler_opts = {
		border = "none",
	},
	always_trigger = false,
	auto_close_after = nil,
	extra_trigger_chars = { "(", "," },
	zindex = 200,
	padding = " ",
	transparency = nil,
	shadow_blend = 36,
	shadow_guibg = "Black",
	timer_interval = 200,
	toggle_key = nil,
})

-- cmp
local check_back_space = function()
	local col = vim.fn.col(".") - 1
	return col == 0 or vim.fn.getline("."):sub(col, col):match("%s") ~= nil
end
local t = function(str)
	return vim.api.nvim_replace_termcodes(str, true, true, true)
end

-- nvim-cmp setup
cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = {
		["<tab>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
		["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
		["<Down>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
		["<Up>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.close(),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
		["<C-d>"] = cmp.mapping(function(fallback)
			if luasnip.jumpable(1) then
				luasnip.jump(1)
			else
				fallback()
			end
		end, { "i", "s" }),
		["<C-b>"] = cmp.mapping(function(fallback)
			if luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	},
	preselect = cmp.PreselectMode.None,
	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
	},
})

-- lsp-setup
local on_attach = function(client, bufnr)
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end
	local function buf_set_option(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end

	--Enable completion triggered by <c-x><c-o>
	buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	local opts = { noremap = true, silent = true }

	-- See `:help vim.lsp.*` for documentation on any of the below functions
	buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	buf_set_keymap("n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
	buf_set_keymap("n", "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
	buf_set_keymap("n", "<leader>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
	buf_set_keymap("n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	buf_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	buf_set_keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	buf_set_keymap("n", "<leader>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
	buf_set_keymap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
	buf_set_keymap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
	buf_set_keymap("n", "<leader>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
	buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.format { async = true} <CR>", opts)
	buf_set_keymap("n", "<leader>clr", "<cmd>lua <CR>", opts)
	buf_set_keymap("n", "<leader>cln", "<cmd>lua vim.lsp.codelens.run()<CR>", opts)
	vim.lsp.codelens.refresh()
	print("LSP Attached!")
end
configs.templ = {
	default_config = {
		cmd = { "templ", "lsp" },
		filetypes = { "templ" },
		root_dir = nvim_lsp.util.root_pattern("go.mod", ".git"),
		settings = {},
	},
}

vim.cmd([[
augroup FormatAutogroup
	autocmd!
	autocmd BufWritePost * FormatWrite
augroup END
]])
local server_settings = {
	gopls = {
		gopls = {
			codelenses = {
				generate = true, -- show the `go generate` lens.
				gc_details = true, -- show a code lens toggling the display of gc's choices.
				test = true,
				upgrade_dependency = true,
				tidy = true,
			},
			buildFlags = { "-tags=integration" },
		},
	},
	tsserver = {
		format = { enable = false },
	},
	eslint = {
		enable = true,
		format = { enable = true }, -- this will enable formatting
		packageManager = "npm",
		autoFixOnSave = true,
		codeActionsOnSave = {
			mode = "all",
			rules = { "!debugger", "!no-only-tests/*" },
		},
		lintTask = {
			enable = true,
		},
	},
}

local servers = {
	"templ",
	"ccls",
	"cmake",
	"tsserver",
	"rust_analyzer",
	"gopls",
	"eslint",
}
for _, lsp in ipairs(servers) do
	local opts = {
		on_attach = on_attach,
		capabilities = capabilities,
		flags = {
			debounce_text_changes = 150,
		},
	}
	if server_settings[lsp] then
		opts.settings = server_settings[lsp]
	end
	nvim_lsp[lsp].setup(opts)
end

function TypescriptOrganizeImports()
	vim.lsp.buf.execute_command({ command = "_typescript.organizeImports", arguments = { vim.fn.expand("%:p") } })
end

-- diagnostic
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
