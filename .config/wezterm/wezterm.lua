local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.font = wezterm.font('Dank Mono', { weight = 'DemiBold' })
config.font_size = 16.0
config.color_scheme = 'iceberg-dark'

config.window_padding = {
	left = '2cell',
	right = '2cell',
	top = '1cell',
	bottom = '1cell',
}

config.window_frame = {
	font = wezterm.font 'Dank Mono',
	font_size = 14.0,
}

config.window_decorations = "RESIZE"
config.window_background_opacity = 0.95
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = true

return config
