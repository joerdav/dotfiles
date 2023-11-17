local M = {
	"vim-test/vim-test",
	config = function()
		vim.g['test#strategy'] = 'vimux'
		vim.cmd([[
			let test#go#gotest#options = {
			  \ 'all':   '-cover --coverprofile=coverage.out',
			\}
			]])

		require('coverage').setup {
			commands = true, -- create commands
			signs = {
				-- use your own highlight groups or text markers
				covered = { hl = 'String', text = '▎' },
				uncovered = { hl = 'Constant', text = '▎' },
			},
		}
		vim.g['gotests_template'] = ''
	end
}
return M
