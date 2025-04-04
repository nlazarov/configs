-- Pull in the wezterm API
local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.hide_tab_bar_if_only_one_tab = true
config.native_macos_fullscreen_mode = true
config.font = wezterm.font("Source Code Pro for Powerline")
config.font_size = 13.0
config.freetype_load_target = 'Light'
config.freetype_render_target = 'HorizontalLcd'
return config
