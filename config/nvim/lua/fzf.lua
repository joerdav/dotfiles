map = require("map")

map("n", "<C-g>", "<cmd>GFiles<cr>", { silent = true, noremap = true })
map("n", "<C-p>", "<cmd>Files<cr>", { silent = true, noremap = true })
map("n", "<C-b>", "<cmd>Buffers<cr>", { silent = true, noremap = true })
map("n", "<C-x>", "<cmd>Commands<cr>", { silent = true, noremap = true })
map(
	"n",
	"<leader>x",
	"<cmd>call fzf#run({'source':'xc -short', 'options': '--prompt \"xc> \" --preview \"xc -d {} | glow --style dark\"', 'sink': 'VimuxRunCommand \"xc\"', 'window': {'width': 0.9, 'height': 0.6}})<cr>",
	{ silent = false, noremap = true }
)
