map = require("map")

--- move lines
vim.keymap.set("n", "<A-k>", "<cmd>m .-2<CR>==")
vim.keymap.set("n", "<A-j>", "<cmd>m .+1<CR>==")
vim.keymap.set("i", "<A-j>", "<Esc><cmd>m .+1<CR>==gi")
vim.keymap.set("i", "<A-k>", "<Esc><cmd>m .-2<CR>==gi")
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv")

--- quick escape insert
map("i", "jk", "<esc>", { silent = true, noremap = true })

--- fix strange issue with keyboard
map("i", "<A-3>", "#", { silent = true, noremap = true })
