map = require("map")
local wikiloc = "~/log"

vim.api.nvim_create_user_command("Wk", ":E " .. wikiloc, {})
vim.api.nvim_create_user_command("Wf", ":Files " .. wikiloc, {})
function file_exists(file)
	local f = io.open(file, "r")
	if f then
		f:close()
	end
	return f ~= nil
end
function openday(d)
	local file = wikiloc .. "/daily/" .. os.date("%Y-%m-%d.md", d)
	if not file_exists(file) then
		template = wikiloc .. "/templates/daily.md"
		os.execute("cp -n " .. template .. " " .. file)
	end
	vim.cmd(":e " .. file)
end
vim.api.nvim_create_user_command("Da", function()
	openday(os.time())
end, {})
vim.api.nvim_create_user_command("Dt", function()
	openday(os.time() + 24 * 60 * 60)
end, {})
vim.api.nvim_create_user_command("Dy", function()
	openday(os.time() - 24 * 60 * 60)
end, {})

vim.api.nvim_create_autocmd(
    { "BufRead", "BufNewFile" },
    { pattern = { "*.txt", "*.md", "*.tex" }, command = "setlocal spell" }
)

require("mkdnflow").setup({
	mappings = {
		MkdnDecreaseHeading = { "n", "=" },
	},
	links = {
		transform_explicit = function(input)
			return (string.upper(os.date("%Y%m%d%H%M%S ") .. input))
		end,
		transform_implicit = function(input)
			if input:match("%d%d%d%d%-%d%d%-%d%d") then
				return (wikiloc .. "/daily/" .. input)
			elseif input:match("%d%d%d%d%d%d%d%d%d%d%d%d") then
				return (wikiloc .. "/loose/" .. input)
			else
				return (wikiloc .. "/" .. input)
			end
		end,
	},
})
