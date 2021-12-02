lua <<EOF
local cmd = vim.cmd
local fn = vim.fn
local g = vim.g
local opt = vim.opt

local function map(mode, lhs, rhs, opts)
local options = {noremap = true}
if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- scheme
cmd[[hi Normal ctermfg=white ctermbg=black]]
cmd[[hi LineNr ctermfg=white]]
cmd[[hi Comment ctermfg=green]]
cmd[[hi Statement ctermfg=yellow]]
cmd[[hi Constant ctermfg=white]]
cmd[[hi String ctermfg=Magenta]]
cmd[[hi PMenu ctermfg=white ctermbg=darkgrey]]
cmd[[hi PMenuSel ctermfg=white ctermbg=magenta ]]
cmd[[hi Label ctermfg=yellow]]
cmd[[hi StatusLine ctermbg=white ctermfg=darkgray]]
cmd[[hi Todo ctermbg=magenta ctermfg=black]]
cmd[[hi MatchParen ctermbg=red]]
cmd[[hi Type ctermfg=lightblue]]
cmd[[hi Identifier ctermfg=lightblue]]

-- nvim options
opt.splitbelow = true
opt.fileencoding = "UTF-8"
-- TODO: syntax on
opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"

-- globals
--- instant
g.instant_username = "joe-davidson1802"
--- set leader
g.mapleader = " "
--- netrw settings
g.netrw_banner = 0
g.netrw_liststyle = 1
--- coverage settings
g.coverage_json_report_path = "coverage/coverage-final.json"
g.coverage_sign_covered = "⦿"
g.coverage_interval = 5000
g.coverage_show_covered = 1
g.coverage_show_uncovered = 1
--- vimwiki
g.vimwiki_list = {
            {
                path = '~/wiki',
                syntax = 'markdown',
                ext = '.md',
            }
}
-- Mappings
--- multi
map("n", "<M-Down>", [[<cmd>call vm#commands#add_cursor_down(0, v:count1)<cr>]], {silent = false, noremap = true})
map("n", "<M-Up>", [[<cmd>call vm#commands#add_cursor_up(0, v:count1)<cr>]], {silent = false, noremap = true})
--- fzf
map("n", "<C-g>", "<cmd>GFiles<cr>", {silent = true, noremap = true})
map("n", "<C-p>", "<cmd>Files<cr>", {silent = true, noremap = true})
map("n", "<C-b>", "<cmd>Buffers<cr>", {silent = true, noremap = true})
map("n", "<C-x>", "<cmd>Commands<cr>", {silent = true, noremap = true})

--- quick escape insert
map("i", "jk", "<esc>", {silent = true, noremap = true})

--- fix strange issue with keyboard
map("i", "<A-3>", "#", {silent = true, noremap = true})

--- formatting
map("n", "<leader>f", "<cmd>Format<cr>", {noremap = true})

--- prev buffer
map("n", "<leader>jk", "<C-\\><C-n><cmd>buffer #<cr>", {noremap = true})
map("t", "<leader>jk", "<C-\\><C-n><cmd>buffer #<cr>", {noremap = true})

--- move line
map("n", "<A-j>", "<cmd>m .+1<cr>==", {noremap = true})
map("n", "<A-k>", "<cmd>m.-2<cr>==", {noremap = true})
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", {noremap = true})
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", {noremap = true})
map("v", "<A-j>", ":m '>+1<cr>gv=gv", {noremap = true})
map("v", "<A-k>", ":m '<-2<cr>gv=gv", {noremap = true})

--- symbols
map("n", "<leader>s", "<cmd>SymbolsOutline<cr>", {noremap = true})
--- vim-test settings
g["test#strategy"] = "dispatch"
map("n", "t<C-n>", "<cmd>TestNearest<cr>", {silent = true, noremap = true})
map("n", "t<C-f>", "<cmd>TestFile<cr>", {silent = true, noremap = true})
map("n", "t<C-s>", "<cmd>TestSuite<cr>", {silent = true, noremap = true})
map("n", "t<C-l>", "<cmd>TestLast<cr>", {silent = true, noremap = true})
map("n", "t<C-g>", "<cmd>TestVisit<cr>", {silent = true, noremap = true})

-- org_imports
function org_imports(wait_ms)
  local params = vim.lsp.util.make_range_params()
  params.context = {only = {"source.organizeImports"}}
  local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
  for _, res in pairs(result or {}) do
    for _, r in pairs(res.result or {}) do
      if r.edit then
        vim.lsp.util.apply_workspace_edit(r.edit)
      else
        vim.lsp.buf.execute_command(r.command)
      end
    end
  end
end

-- cmp
local check_back_space = function()
local col = vim.fn.col '.' - 1
return col == 0 or vim.fn.getline('.'):sub(col, col):match '%s' ~= nil
end
local t = function(str)
return vim.api.nvim_replace_termcodes(str, true, true, true)
end
local cmp = require'cmp'

cmp.setup({
snippet = {
  expand = function(args)
  vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` user.
end,
},
    mapping = {
      ['<C-p>'] = cmp.mapping.select_prev_item(),
      ['<C-n>'] = cmp.mapping.select_next_item(),
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Insert,
        select = true,
      })
    },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'buffer' },
  }
})

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
local configs = require'lspconfig/configs'
if not nvim_lsp.templ then
  configs.templ = {
    default_config = {
      cmd = {'templ', 'lsp'};
      filetypes = {'templ'};
      root_dir = nvim_lsp.util.root_pattern("go.mod", ".git"),
      settings = {};
      };
    }
end
-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
vim.api.nvim_exec([[
augroup GO_LSP
  autocmd!
  autocmd BufWritePre *.go :silent! lua vim.lsp.buf.formatting_sync()
  autocmd BufWritePre *.go :silent! lua org_imports(3000)
augroup END
]], true)
require('rust-tools').setup({
    tools = { -- rust-tools options
        autoSetHints = true,
        hover_with_actions = true,
        inlay_hints = {
            show_parameter_hints = false,
            parameter_hints_prefix = "",
            other_hints_prefix = "",
        },
    },

    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
    server = {
        -- on_attach is a callback called when the language server attachs to the buffer
        -- on_attach = on_attach,
        settings = {
            -- to enable rust-analyzer settings visit:
            -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
            ["rust-analyzer"] = {
                -- enable clippy on save
                checkOnSave = {
                    command = "clippy"
                },
            }
        }
    },
})
local servers = { 'templ', 'gopls', 'ccls', 'cmake', 'tsserver' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
      },
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
    }
end

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
  }
})
vim.api.nvim_exec([[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.js,*.ts,*.go,*.rs,*.lua FormatWrite
augroup END
]], true)

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
        use_lsp_diagnostic_signs = true
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

      require'nvim-treesitter.configs'.setup {
      ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
      highlight = {
      enable = true,              -- false will disable the whole extension
      additional_vim_regex_highlighting = false,
      },
    }
EOF
