local cmd = vim.cmd
local fn = vim.fn
local g = vim.g
local opt = vim.opt

--- leader
g.mapleader = " "
--- netrw settings
g.netrw_banner = 0
g.netrw_liststyle = 1

--- generate neovim settings
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

--- testing
g.coverage_json_report_path = "coverage/coverage-final.json"
g.coverage_sign_covered = "⦿"
g.coverage_interval = 5000
g.coverage_show_covered = 1
g.coverage_show_uncovered = 1
g["test#strategy"] = "dispatch"

-- mappings
local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

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

--- vim-test settings
map("n", "t<C-n>", "<cmd>TestNearest<cr>", {silent = true, noremap = true})
map("n", "t<C-f>", "<cmd>TestFile<cr>", {silent = true, noremap = true})
map("n", "t<C-s>", "<cmd>TestSuite<cr>", {silent = true, noremap = true})
map("n", "t<C-l>", "<cmd>TestLast<cr>", {silent = true, noremap = true})
map("n", "t<C-g>", "<cmd>TestVisit<cr>", {silent = true, noremap = true})

-- lsp
map('n', '<Leader>gcr', ':lua require("nvim-goc").Coverage()<CR>', {silent=true})
map('n', '<Leader>gcc', ':lua require("nvim-goc").ClearCoverage()<CR>', {silent=true})
map('n', '<Leader>gct', ':lua require("nvim-goc").CoverageFunc()<CR>', {silent=true})
map('n', '<Leader>gca', ':lua cf(false)<CR><CR>', {silent=true})
map('n', '<Leader>gcb', ':lua cf(true)<CR><CR>', {silent=true})
map('n', '<Leader>clr', '<cmd>lua vim.lsp.codelens.refresh()<CR>', {silent=true})
map('n', '<Leader>cln', '<cmd>lua vim.lsp.codelens.run()<CR>', {silent=true})

-- alternate between test file and normal file
map('n', ']a', ':lua require("nvim-goc").Alternate()<CR>', {silent=true})

-- alternate in a new split
map('n', '[a', ':lua require("nvim-goc").Alternate(true)<CR>', {silent=true})

