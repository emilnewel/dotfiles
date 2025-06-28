-- Pull in the wezterm API
local wezterm = require("wezterm")
local theme = wezterm.plugin.require("https://github.com/neapsix/wezterm").main
local config = wezterm.config_builder()

local keys = {
	{
		key = "|",
		mods = "LEADER|SHIFT",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "-",
		mods = "LEADER",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "c",
		mods = "LEADER",
		action = wezterm.action.SpawnCommandInNewTab({ cwd = "~" }),
	},
	{
		key = "x",
		mods = "LEADER",
		action = wezterm.action.CloseCurrentTab({ confirm = false }),
	},
	{
		key = "l",
		mods = "CTRL",
		action = wezterm.action.ActivatePaneDirection("Right"),
	},
	{
		key = "h",
		mods = "CTRL",
		action = wezterm.action.ActivatePaneDirection("Left"),
	},
	{
		key = "k",
		mods = "CTRL",
		action = wezterm.action.ActivatePaneDirection("Up"),
	},
	{
		key = "j",
		mods = "CTRL",
		action = wezterm.action.ActivatePaneDirection("Down"),
	},
}

for i = 1, 9 do
	table.insert(keys, {
		key = tostring(i),
		mods = "LEADER",
		action = wezterm.action({ ActivateTab = i - 1 }),
	})
end

local colors = theme.colors()
colors["background"] = "black"

local window_frame = theme.window_frame()
window_frame["active_titlebar_bg"] = "black"

config = {
	-- Powershell
	default_prog = { "pwsh.exe", "-NoLogo" },

	-- Font
	font = wezterm.font("JetBrainsMono Nerd Font"),
	font_size = 14.00,
	colors = colors,
	window_frame = window_frame,
	window_background_opacity = 0.9,
	window_decorations = "RESIZE",
	hide_tab_bar_if_only_one_tab = false,
	tab_bar_at_bottom = true,
	use_fancy_tab_bar = true,

	-- Keymaps
	leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 },
	keys = keys,

	--scrollback
	scrollback_lines = 3500,
	enable_scroll_bar = true,
	max_fps = 120,
	prefer_egl = true,
	window_close_confirmation = "NeverPrompt",
}

return config
