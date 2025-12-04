local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- Your existing settings
config.initial_cols = 120
config.initial_rows = 28
config.font_size = 11
config.color_scheme = "Eldritch"
config.font = wezterm.font("JetBrainsMono Nerd Font")
config.window_padding = {
	left = 10,
	right = 10,
	top = 10,
	bottom = 0,
}

config.window_background_opacity = 0.90
config.default_cursor_style = "BlinkingBlock"
config.cursor_blink_rate = 700

-- Tab bar styling to match Eldritch theme
config.use_fancy_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = false
config.hyperlink_rules = wezterm.default_hyperlink_rules()

-- Copy on select (like in many terminals)
config.mouse_bindings = {
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "NONE",
		action = wezterm.action.CompleteSelection("ClipboardAndPrimarySelection"),
	},
}

config.keys = {
	{
		key = "t",
		mods = "CTRL",
		action = wezterm.action.SpawnTab("CurrentPaneDomain"),
	},
	{
		key = "w",
		mods = "CTRL",
		action = wezterm.action.CloseCurrentTab({ confirm = true }),
	},
	{
		key = "Tab",
		mods = "CTRL",
		action = wezterm.action.ActivateTabRelative(1),
	},
	{
		key = "Tab",
		mods = "CTRL|SHIFT",
		action = wezterm.action.ActivateTabRelative(-1),
	},
	{
		key = "F11",
		-- mods = "CTRL|SHIFT",
		action = wezterm.action.ToggleFullScreen,
	},
}

config.colors = {
	tab_bar = {
		background = "#09090d",

		active_tab = {
			bg_color = "#37f499",
			fg_color = "#09090d",
			intensity = "Bold",
		},

		inactive_tab = {
			bg_color = "#212337",
			fg_color = "#6f7c9f",
		},

		inactive_tab_hover = {
			bg_color = "#323449",
			fg_color = "#cdd6f4",
			italic = true,
		},

		new_tab = {
			bg_color = "#212337",
			fg_color = "#37f499",
		},

		new_tab_hover = {
			bg_color = "#323449",
			fg_color = "#37f499",
			italic = true,
		},
	},
}

return config
