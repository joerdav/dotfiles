local g = vim.g
local opt = vim.opt

local parser_install_dir = vim.fn.expand("~/treesitters")
vim.fn.mkdir(parser_install_dir, "p")
vim.opt.runtimepath:append(parser_install_dir)

g.NERDCreateDefaultMappings = 0
--- netrw settings
g.netrw_banner = 0
g.netrw_liststyle = 1

--- generate neovim settings
opt.splitbelow = true
opt.splitright = true
--opt.clipboard = "unnamedplus" -- always default to system clipboard
opt.completeopt = { "menu", "menuone", "noselect" }
opt.timeout = true -- turn on timeout
opt.timeoutlen = 1000 -- set timeout to 1000
opt.inccommand = "nosplit" -- turn on incremental substitution
opt.switchbuf = { "useopen" }
opt.fileencoding = "UTF-8"
opt.number = true
opt.showmode = false
opt.ruler = true
opt.showcmd = true
opt.laststatus = 2 -- always display file name
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
opt.mouse = ""

opt.wildmode = "longest,list,full"
opt.wildmenu = true
--- testing
g.coverage_json_report_path = "coverage/coverage-final.json"
g.coverage_sign_covered = "⦿"
g.coverage_interval = 5000
g.coverage_show_covered = 1
g.coverage_show_uncovered = 1
