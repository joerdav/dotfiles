local cmd = vim.cmd
local fn = vim.fn
local g = vim.g
local opt = vim.opt

require'lsp_signature'.setup({
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
    border = "none" 
  },
  always_trigger = false, 
  auto_close_after = nil, 
  extra_trigger_chars = {"(", ","}, 
  zindex = 200, 
  padding = ' ',
  transparency = nil, 
  shadow_blend = 36, 
  shadow_guibg = 'Black', 
  timer_interval = 200, 
  toggle_key = nil 
})

-- cmp
local check_back_space = function()
local col = vim.fn.col '.' - 1
return col == 0 or vim.fn.getline('.'):sub(col, col):match '%s' ~= nil
end
local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
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
      ['<tab>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
      ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
      ['<Down>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
      ['<Up>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
      }),
      ['<C-d>'] = cmp.mapping(function(fallback)
        if luasnip.jumpable(1) then
          luasnip.jump(1)
        else
          fallback()
        end
      end, {'i', 's'}),
      ['<C-b>'] = cmp.mapping(function(fallback)
        if luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, {'i', 's'}),
  },
  preselect = cmp.PreselectMode.None,
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer' },
  }),
}

-- lsp-setup
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<leader>lf', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end
local nvim_lsp = require('lspconfig')
local configs = require'lspconfig.configs'
configs.templ = {
  default_config = {
    cmd = {'templ', 'lsp'};
    filetypes = {'templ'};
    root_dir = nvim_lsp.util.root_pattern("go.mod", ".git"),
    settings = {};
  };
}
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.go" },
  callback = function()
	  vim.lsp.buf.formatting_sync(nil, 3000)
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.go" },
  callback = function()
    local params = vim.lsp.util.make_range_params(nil, vim.lsp.util._get_offset_encoding())
    params.context = {only = {"source.organizeImports"}}

    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
    for _, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          vim.lsp.util.apply_workspace_edit(r.edit, vim.lsp.util._get_offset_encoding())
        else
          vim.lsp.buf.execute_command(r.command)
        end
      end
    end
  end,
})

require('rust-tools').setup({
  tools = {
    autoSetHints = false
  },
  server = {
    on_attach = on_attach,
  },
})
local servers = { 
  'templ', 
  'ccls', 
  'cmake', 
  'tsserver',
}
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
      },
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
    }
end
nvim_lsp.gopls.setup{
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 150,
  },
  capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
  settings = { gopls =  {
    codelenses = {
      generate = true, -- show the `go generate` lens.
      gc_details = true, --  // Show a code lens toggling the display of gc's choices.
      test = true,
      tidy = true,
    },
    buildFlags =  {"-tags=storybook"}
  }},
}

-- formatting
local prett = function()
  return {
      exe = "prettierd",
      args = {vim.api.nvim_buf_get_name(0)},
      stdin = true
    }
end

require('formatter').setup({
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
          stdin = true
          }
      end
      },
    rust = {
      function()
        return {
          exe = "rustfmt",
          stdin = true
          }
      end
      },
    go = {
      function()
        return {
          exe = "gofmt",
          stdin = true
          }
      end
      },
    templ = {
      function()
        return {
          exe = "templ fmt",
          stdin = true
          }
      end
      },
    }
})

function TypescriptOrganizeImports()
  vim.lsp.buf.execute_command({command = "_typescript.organizeImports", arguments = {vim.fn.expand("%:p")}})
end

-- diagnostic
local signs = { Error = " ", Warning = " ", Hint = " ", Information = " " }

for type, icon in pairs(signs) do
  local hl = "LspDiagnosticsSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end
vim.lsp.handlers["textDocument/publishDiagnostics"] =
vim.lsp.with(
vim.lsp.diagnostic.on_publish_diagnostics,
{
  virtual_text = {
    signs = true
    },
      }
      )

      -- trouble
      require("trouble").setup {
        use_diagnostic_signs = true
        }

      vim.api.nvim_set_keymap("n", "<leader>xx", "<cmd>Trouble<cr>",
      {silent = true, noremap = true}
      )
      vim.api.nvim_set_keymap("n", "<leader>xw", "<cmd>Trouble lsp_workspace_diagnostics<cr>",
      {silent = true, noremap = true}
      )
      vim.api.nvim_set_keymap("n", "<leader>xd", "<cmd>Trouble lsp_document_diagnostics<cr>",
      {silent = true, noremap = true}
      )
      vim.api.nvim_set_keymap("n", "<leader>xl", "<cmd>Trouble loclist<cr>",
      {silent = true, noremap = true}
      )
      vim.api.nvim_set_keymap("n", "<leader>xq", "<cmd>Trouble quickfix<cr>",
      {silent = true, noremap = true}
      )
vim.opt.switchbuf = 'useopen'
local goc = require'nvim-goc'
goc.setup({ verticalSplit = false })

_G.cf = function(testCurrentFunction)
  local cb = function(path)
    if path then
      vim.cmd(":silent exec \"!xdg-open " .. path .. "\"")
    end
  end

  if testCurrentFunction then
    goc.CoverageFunc(nil, cb, 0)
  else
    goc.Coverage(nil, cb)
  end
end

