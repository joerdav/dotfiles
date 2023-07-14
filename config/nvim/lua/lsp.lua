local vim = vim
local api = vim.api
local mason = require("mason")
local mason_lsp_config = require("mason-lspconfig")
local lspconfig = require("lspconfig")
local configs = require("lspconfig.configs")
local cmp = require("cmp")
local luasnip = require("luasnip")

mason.setup({
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
		-- javascript
		"eslint-lsp",
		"prettierd",
		-- lua
		"stylua",
		--c
		"clangd",
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

configs.templ = {
	default_config = {
		cmd = { "templ", "lsp" },
		filetypes = { "templ" },
		root_dir = lspconfig.util.root_pattern("go.mod", ".git"),
		settings = {},
	},
}
configs.lua_ls = {
	default_config = {
		cmd = { "lua-language-server" },
		filetypes = { "lua" },
		single_file_support = true,
		log_level = vim.lsp.protocol.MessageType.Warning,
		settings = { Lua = { telemetry = { enable = false } } },
	},
}
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
	eslint = {
		enable = true,
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
mason_lsp_config.setup()

mason_lsp_config.setup_handlers({
	function(server_name)
		local opts = {}
		if server_settings[server_name] then
			opts.settings = server_settings[server_name]
		end
		lspconfig[server_name].setup(opts)
	end,
})

require("luasnip.loaders.from_snipmate").lazy_load({ paths = "~/.config/nvim/snippets" })

local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

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
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, { "i", "s" }),

		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
		-- ["<tab>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
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

local format_group = api.nvim_create_augroup("FormatGroup", { clear = true })
api.nvim_create_autocmd(
	{ "BufRead", "BufNewFile" },
	{ pattern = "*.md", command = "setlocal textwidth=120", group = format_group }
)
api.nvim_create_autocmd("BufWritePost", { pattern = "*", command = "FormatWrite", group = format_group })
api.nvim_create_autocmd(
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

require("cmake-tools").setup {}
