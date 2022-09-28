map = require("map")

map("n", "t<C-n>", "<cmd>TestNearest<cr>", { silent = true, noremap = true })
map("n", "t<C-f>", "<cmd>TestFile<cr>", { silent = true, noremap = true })
map("n", "t<C-s>", "<cmd>TestSuite<cr>", { silent = true, noremap = true })
map("n", "t<C-l>", "<cmd>TestLast<cr>", { silent = true, noremap = true })
map("n", "t<C-g>", "<cmd>TestVisit<cr>", { silent = true, noremap = true })
