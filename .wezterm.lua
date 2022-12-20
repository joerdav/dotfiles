local wezterm = require 'wezterm'
return {
  default_prog = { 'zsh', '-c', 'tmux' },
  font = wezterm.font('Fira Code', {weight="Medium"}),
  enable_tab_bar = false,
}
