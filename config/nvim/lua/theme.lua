local cmd = vim.cmd
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
  },
}
cmd([[colorscheme dracula]])
cmd([[hi Normal ctermbg=16 guibg=#000000]])
cmd([[hi LineNr ctermbg=16 guibg=#000000]])
cmd([[hi EndOfBuffer ctermbg=16 guibg=#000000]])
cmd([[hi EndOfBuffer ctermbg=16 guibg=#000000]])
cmd[[hi Pmenu guibg=NONE]]
