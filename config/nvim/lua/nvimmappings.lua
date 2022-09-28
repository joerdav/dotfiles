map = require("map")

--- move lines
map("n", "<A-j>", "<cmd>m .+1<cr>==", { noremap = true })
map("n", "<A-k>", "<cmd>m.-2<cr>==", { noremap = true })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { noremap = true })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { noremap = true })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { noremap = true })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { noremap = true })

--- quick escape insert
map("i", "jk", "<esc>", { silent = true, noremap = true })

--- fix strange issue with keyboard
map("i", "<A-3>", "#", { silent = true, noremap = true })
