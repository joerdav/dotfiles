map = require("map")

local goc = require("nvim-goc")
goc.setup({ verticalSplit = false })

_G.cf = function(testCurrentFunction)
	local cb = function(path)
		if path then
			vim.cmd(':silent exec "!xdg-open ' .. path .. '"')
		end
	end

	if testCurrentFunction then
		goc.CoverageFunc(nil, cb, 0)
	else
		goc.Coverage(nil, cb)
	end
end

-- alternate between test file and normal file
map("n", "]a", ':lua require("nvim-goc").Alternate()<CR>', { silent = true })
-- alternate in a new split
map("n", "[a", ':lua require("nvim-goc").Alternate(true)<CR>', { silent = true })
map("n", "<Leader>gcr", ':lua require("nvim-goc").Coverage()<CR>', { silent = true })
