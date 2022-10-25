map = require("map")

map("n", "t<C-n>", "<cmd>TestNearest<cr>", { silent = true, noremap = true })
map("n", "t<C-f>", "<cmd>TestFile<cr>", { silent = true, noremap = true })
map("n", "t<C-s>", "<cmd>TestSuite<cr>", { silent = true, noremap = true })
map("n", "t<C-l>", "<cmd>TestLast<cr>", { silent = true, noremap = true })
map("n", "t<C-g>", "<cmd>TestVisit<cr>", { silent = true, noremap = true })

-- https://github.com/rafaelsq/nvim-goc.lua
vim.opt.switchbuf = 'useopen'
local goc = require'nvim-goc'
goc.setup({ verticalSplit = false })

vim.api.nvim_set_keymap('n', '<Leader>gcr', ':lua require("nvim-goc").Coverage()<CR>', {silent=true})
vim.api.nvim_set_keymap('n', '<Leader>gcc', ':lua require("nvim-goc").ClearCoverage()<CR>', {silent=true})
vim.api.nvim_set_keymap('n', '<Leader>gct', ':lua require("nvim-goc").CoverageFunc()<CR>', {silent=true})
vim.api.nvim_set_keymap('n', '<Leader>gca', ':lua cf(false)<CR><CR>', {silent=true})
vim.api.nvim_set_keymap('n', '<Leader>gcb', ':lua cf(true)<CR><CR>', {silent=true})
