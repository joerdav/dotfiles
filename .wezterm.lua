local wezterm = require("wezterm")
local dark = true

local config = {
	default_prog = { "zsh", "-c", "tmux" },
	font = wezterm.font("Fira Code", { weight = "Medium" }),
	enable_tab_bar = false,
}

if dark then
else
	config.color_scheme = "Gruvbox light, hard (base16)"
end

return config
