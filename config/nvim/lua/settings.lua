local cmd = vim.cmd
local fn = vim.fn
local g = vim.g
local opt = vim.opt
map = require("map")

--- leader
g.mapleader = " "
--- netrw settings
g.netrw_banner = 0
g.netrw_liststyle = 1

--- generate neovim settings
opt.splitbelow = true
opt.completeopt = { "menu", "menuone", "noselect" }
opt.switchbuf = { "useopen" }
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
opt.mouse = ""

--- testing
g.coverage_json_report_path = "coverage/coverage-final.json"
g.coverage_sign_covered = "⦿"
g.coverage_interval = 5000
g.coverage_show_covered = 1
g.coverage_show_uncovered = 1
g["test#strategy"] = "dispatch"
