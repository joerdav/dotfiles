map = require("map")
local wikiloc = "~/log"

function draw(opts)
	local file = wikiloc.."/diagrams/"..os.date("%Y-%m-%d-")..opts.args..".excalidraw"
	local template = wikiloc .. "/templates/drawing.excalidraw"
	os.execute("cp -n " .. template .. " " .. file)
	os.execute("open " .. file)
	local pos = vim.api.nvim_win_get_cursor(0)[2]
	local line = vim.api.nvim_get_current_line()
	local nline = line:sub(0, pos) .. '[['..file..']]' .. line:sub(pos + 1)
	vim.api.nvim_set_current_line(nline)
end
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
function push()
    local current = vim.fn.expand("%:p:h")
    if current:find(vim.fn.expand(wikiloc), 1, true) == 1 then
	    os.execute("git -C "..wikiloc.." add . ; git -C "..wikiloc.." commit -m \""..os.date("%Y-%m-%d").."\"; git -C "..wikiloc.." push origin main")
    end
end
vim.api.nvim_create_user_command("Wk", ":E " .. wikiloc, {})
vim.api.nvim_create_user_command("Wf", ":Files " .. wikiloc, {})
vim.api.nvim_create_user_command("Draw", draw, {nargs="*"})
vim.api.nvim_create_user_command("Da", function()
	openday(os.time())
end, {})
vim.api.nvim_create_user_command("Ds", push, {})
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
vim.api.nvim_create_autocmd(
    { "BufRead", "VimEnter", "BufEnter" },
    { callback = function()
	    local current = vim.fn.expand("%:p:h")
	    if current:find(vim.fn.expand(wikiloc), 1, true) == 1 then
		    vim.fn.jobstart("git -C "..wikiloc.." pull origin main")
	    end
    end
    }
)

vim.api.nvim_create_autocmd(
    { "VimLeave" },
    { callback = push }
)

require("mkdnflow").setup({
	mappings = {
		MkdnDecreaseHeading = { "n", "=" },
		MkdnToggleToDo = {{'n', 'v'}, '<C-t>'},
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
