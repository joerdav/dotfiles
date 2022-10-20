map = require("map")
local wikiloc = "~/log"

vim.api.nvim_create_user_command("Wk", ":E " .. wikiloc, {})
vim.api.nvim_create_user_command("Wf", ":Files " .. wikiloc, {})
vim.api.nvim_create_user_command("Da", function()
	vim.cmd(":e "..wikiloc..'/daily/'..os.date('%Y-%m-%d.md'))
end, {})

require('mkdnflow').setup({
    links = {
        transform_explicit = function(input)
		return(string.upper(os.date('%Y%m%d%H%M%S ')..input))
        end,
	transform_implicit = function(input)
		if input:match('%d%d%d%d%-%d%d%-%d%d') then
			return(wikiloc..'/daily/'..input)
		elseif input:match('%d%d%d%d%d%d%d%d%d%d%d%d') then
			return(wikiloc..'/loose/'..input)
		else
			return(wikiloc..'/'..input)
		end
	end
    }
})
