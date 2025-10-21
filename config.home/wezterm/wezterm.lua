-- Pull in the wezterm API
local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true
config.native_macos_fullscreen_mode = true
config.font = wezterm.font("Source Code Pro for Powerline")
config.font_size = 13.0
config.freetype_load_target = 'Light'
config.freetype_render_target = 'HorizontalLcd'
config.term = 'wezterm'
config.window_padding = { left = 0, right = 2, bottom = 0, top = 0 }
return config
