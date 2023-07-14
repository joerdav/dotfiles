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

local opts = { noremap = true, silent = true }
---- lsp
map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
map("n", "gK", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
map("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
map("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
map("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
map("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
map("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
map("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
map("n", "<space>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
map("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
map("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
map("n", "<space>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
map("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
