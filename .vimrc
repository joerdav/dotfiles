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
cmd[[set background=dark]]
cmd[[hi clear]]
cmd[[hi! ColorColumn     cterm=NONE            ctermfg=NONE  ctermbg=233]]
cmd[[hi! Comment         cterm=NONE            ctermfg=white   ctermbg=NONE]]
cmd[[hi! CursorColumn    cterm=NONE            ctermfg=NONE  ctermbg=234]]
cmd[[hi! CursorLine      cterm=NONE            ctermfg=NONE  ctermbg=234]]
cmd[[hi! CursorLineNr    cterm=NONE            ctermfg=15    ctermbg=NONE]]
cmd[[hi! DiffAdd         cterm=NONE            ctermfg=2     ctermbg=NONE]]
cmd[[hi! DiffChange      cterm=NONE            ctermfg=15    ctermbg=NONE]]
cmd[[hi! DiffDelete      cterm=NONE            ctermfg=9     ctermbg=NONE]]
cmd[[hi! DiffText        cterm=NONE            ctermfg=6     ctermbg=NONE]]
cmd[[hi! FoldColumn      cterm=NONE            ctermfg=240   ctermbg=NONE]]
cmd[[hi! Folded          cterm=italic          ctermfg=245   ctermbg=NONE]]
cmd[[hi! IncSearch       cterm=NONE            ctermfg=240   ctermbg=11]]
cmd[[hi! LineNr          cterm=NONE            ctermfg=240   ctermbg=NONE]]
cmd[[hi! MatchParen      cterm=NONE            ctermfg=249   ctermbg=240]]
cmd[[hi! MoreMsg         cterm=bold            ctermfg=240   ctermbg=NONE]]
cmd[[hi! NonText         cterm=NONE            ctermfg=240   ctermbg=NONE]]
cmd[[hi! Normal          cterm=NONE            ctermfg=white   ctermbg=16]]
cmd[[hi! Pmenu           cterm=NONE            ctermfg=249   ctermbg=240]]
cmd[[hi! PmenuSel        cterm=NONE            ctermfg=249   ctermbg=236]]
cmd[[hi! Question        cterm=NONE            ctermfg=9     ctermbg=NONE]]
cmd[[hi! QuickFixLine    cterm=underline       ctermfg=NONE  ctermbg=NONE]]
cmd[[hi! Search          cterm=NONE            ctermfg=249   ctermbg=240]]
cmd[[hi! SignColumn      cterm=NONE            ctermfg=NONE  ctermbg=16]]
cmd[[hi! StatusLine      cterm=NONE            ctermfg=245   ctermbg=233]]
cmd[[hi! StatusLineNC    cterm=NONE            ctermfg=240   ctermbg=234]]
cmd[[hi! StatusLineTerm  cterm=NONE            ctermfg=0     ctermbg=121]]
cmd[[hi! TabLine         cterm=NONE            ctermfg=240   ctermbg=234]]
cmd[[hi! TabLineFill     cterm=NONE            ctermfg=249   ctermbg=234]]
cmd[[hi! TabLineSel      cterm=NONE            ctermfg=249   ctermbg=233]]
cmd[[hi! Title           cterm=bold            ctermfg=NONE  ctermbg=NONE]]
cmd[[hi! Todo            cterm=bold,underline  ctermfg=15    ctermbg=NONE]]
cmd[[hi! Underlined      cterm=underline       ctermfg=249   ctermbg=NONE]]
cmd[[hi! VertSplit       cterm=NONE            ctermfg=234   ctermbg=234]]
cmd[[hi! Visual          cterm=NONE            ctermfg=NONE  ctermbg=236]]
cmd[[hi! WarningMsg      cterm=NONE            ctermfg=white    ctermbg=11]]
cmd[[hi! WildMenu        cterm=NONE            ctermfg=249   ctermbg=236]]
cmd[[hi! link Constant   Normal]]
cmd[[hi! link LspDiagnosticsDefault   Normal]]
cmd[[hi! link Identifier Normal]]
cmd[[hi! link Statement  Normal]]
cmd[[hi! link PreProc    Normal]]
cmd[[hi! link Type       Normal]]
cmd[[hi! link Special    Normal]]
cmd[[hi! link String    Normal]]
cmd[[hi! link ModeMsg    MoreMsg]]


-- nvim options
opt.splitbelow = true
opt.completeopt = {'menu', 'menuone', 'noselect'}
opt.fileencoding = "UTF-8"
opt.number = false
opt.showmode = false
opt.ruler = true
opt.showcmd = true
opt.laststatus = 0
opt.ttyfast = true
opt.autoread = true
opt.autoindent = true
opt.incsearch = true
opt.hlsearch = true
opt.swapfile = false
opt.backup = false
opt.hidden = true
opt.ignorecase = true
opt.smartcase = true
opt.cursorcolumn = false
opt.cursorline = false
opt.pumheight = 10
opt.lazyredraw = true

-- globals
--- instant
g.instant_username = "joerdav"
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
-- Mappings
--- multi
map("n", "<M-Down>", [[<cmd>call vm#commands#add_cursor_down(0, v:count1)<cr>]], {silent = false, noremap = true})
map("n", "<M-Up>", [[<cmd>call vm#commands#add_cursor_up(0, v:count1)<cr>]], {silent = false, noremap = true})
--- fzf
map("n", "<C-g>", "<cmd>GFiles<cr>", {silent = true, noremap = true})
map("n", "<C-p>", "<cmd>Files<cr>", {silent = true, noremap = true})
map("n", "<C-b>", "<cmd>Buffers<cr>", {silent = true, noremap = true})
map("n", "<C-x>", "<cmd>Commands<cr>", {silent = true, noremap = true})
map("n", "<leader>x", "<cmd>call fzf#run({'source':'xc -short', 'options': '--prompt \"xc> \" --preview \"xc -md {}\"', 'sink': 'RunInInteractiveShell xc', 'window': {'width': 0.9, 'height': 0.6}})<cr>", {silent = false, noremap = true})

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
---map("n", "<leader>s", "<cmd>SymbolsOutline<cr>", {noremap = true})
---g.symbols_outline = {
---symbol_blacklist = {
    ---"Field"
  ---}
---}
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

lsp_signature_cfg = {
  debug = false, -- set to true to enable debug logging
  log_path = "debug_log_file_path", -- debug log path
  verbose = false, -- show debug line number

  bind = true, -- This is mandatory, otherwise border config won't get registered.
               -- If you want to hook lspsaga or other signature handler, pls set to false
  doc_lines = 10, -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
                 -- set to 0 if you DO NOT want any API comments be shown
                 -- This setting only take effect in insert mode, it does not affect signature help in normal
                 -- mode, 10 by default

  floating_window = true, -- show hint in a floating window, set to false for virtual text only mode

  floating_window_above_cur_line = true, -- try to place the floating above the current line when possible Note:
  -- will set to true when fully tested, set to false will use whichever side has more space
  -- this setting will be helpful if you do not want the PUM and floating win overlap
  fix_pos = false,  -- set to true, the floating window will not auto-close until finish all parameters
  hint_enable = false, -- virtual hint enable
  hint_prefix = "🐼 ",  -- Panda for parameter
  hint_scheme = "String",
  hi_parameter = "LspSignatureActiveParameter", -- how your parameter will be highlight
  max_height = 12, -- max height of signature floating_window, if content is more than max_height, you can scroll down
                   -- to view the hiding contents
  max_width = 120, -- max_width of signature floating_window, line will be wrapped if exceed max_width
  handler_opts = {
    border = "none"   -- double, rounded, single, shadow, none
  },

  always_trigger = false, -- sometime show signature on new line or in middle of parameter can be confusing, set it to false for #58

  auto_close_after = nil, -- autoclose signature float win after x sec, disabled if nil.
  extra_trigger_chars = {"(", ","}, -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
  zindex = 200, -- by default it will be on top of all floating windows, set to <= 50 send it to bottom

  padding = ' ', -- character to pad on left and right of signature can be ' ', or '|'  etc

  transparency = nil, -- disabled by default, allow floating win transparent value 1~100
  shadow_blend = 36, -- if you using shadow as border use this set the opacity
  shadow_guibg = 'Black', -- if you using shadow as border use this set the color e.g. 'Green' or '#121315'
  timer_interval = 200, -- default timer check interval set to lower value if you want to reduce latency
  toggle_key = nil -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'
}
require'lsp_signature'.setup(lsp_signature_cfg) -- no need to specify bufnr if you don't use toggle_key

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
      require('luasnip').lsp_expand(args.body)
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
    tools = {
      autoSetHints = false
      },
    server = {
        on_attach = on_attach,
    },
})
local servers = { 'templ', 'ccls', 'cmake', 'tsserver' }
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
vim.api.nvim_exec([[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.templ,*.js,*.ts,*.go,*.rs,*.lua FormatWrite
augroup END
]], true)

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

vim.api.nvim_set_keymap('n', '<Leader>gcr', ':lua require("nvim-goc").Coverage()<CR>', {silent=true})
vim.api.nvim_set_keymap('n', '<Leader>gcc', ':lua require("nvim-goc").ClearCoverage()<CR>', {silent=true})
vim.api.nvim_set_keymap('n', '<Leader>gct', ':lua require("nvim-goc").CoverageFunc()<CR>', {silent=true})
vim.api.nvim_set_keymap('n', '<Leader>gca', ':lua cf(false)<CR><CR>', {silent=true})
vim.api.nvim_set_keymap('n', '<Leader>gcb', ':lua cf(true)<CR><CR>', {silent=true})

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

-- alternate between test file and normal file
vim.api.nvim_set_keymap('n', ']a', ':lua require("nvim-goc").Alternate()<CR>', {silent=true})

-- alternate in a new split
vim.api.nvim_set_keymap('n', '[a', ':lua require("nvim-goc").Alternate(true)<CR>', {silent=true})

EOF

