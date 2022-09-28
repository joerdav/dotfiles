map = require("map")

map("n", "<S-l>", [[<cmd>call vm#commands#add_cursor_down(0, v:count1)<cr>]], { silent = false, noremap = true })
map("n", "<S-h>", [[<cmd>call vm#commands#add_cursor_up(0, v:count1)<cr>]], { silent = false, noremap = true })
