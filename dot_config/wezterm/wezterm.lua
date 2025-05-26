local wezterm = require("wezterm")
local platform = require("utils.platform")

local config = {}

config.font = wezterm.font("FiraCode Nerd Font")
config.color_scheme = "Catppuccin Mocha"

config.window_background_opacity = 0.95
config.window_decorations = "RESIZE"
config.adjust_window_size_when_changing_font_size = false
config.window_padding = {
	left = 14,
	right = 10,
	top = 10,
	bottom = 10,
}

-- +++++++++++++++++++++++++++
-- keybindings
-- +++++++++++++++++++++++++++
config.keys = {
	{
		key = "t",
		mods = "CTRL|SHIFT",
		action = wezterm.action.ShowLauncherArgs({ flags = "FUZZY|LAUNCH_MENU_ITEMS|TABS" }),
	},
}

-- +++++++++++++++++++++++++++
-- tabbar
-- +++++++++++++++++++++++++++
-- The filled in variant of thee < symbol
local SOLID_LEFT_ARROW = wezterm.nerdfonts.pl_right_hard_divider
-- The filled in variant of the > symbol
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.pl_left_hard_divider

-- This function returns the suggested title for a tab.
-- It prefers the title that was set via `tab:set_title()`
-- or `wezterm cli set-tab-title`, but falls back to the
-- title of the active pane in that tab.
function tab_title(tab_info)
	local title = tab_info.tab_title
	-- if the tab title is explicitly set, take that
	if title and #title > 0 then
		return title
	end
	-- Otherwise, use the title from the active pane
	-- in that tab
	return tab_info.active_pane.title
end

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local edge_background = "#0b0022"
	local background = "#1b1032"
	local foreground = "#808080"

	if tab.is_active then
		background = "#2b2042"
		foreground = "#c0c0c0"
	elseif hover then
		background = "#3b3052"
		foreground = "#909090"
	end

	local edge_foreground = background

	local title = tab_title(tab)

	-- ensure that the titles fit in the available space,
	-- and that we have room for the edges.
	title = wezterm.truncate_right(title, max_width - 2)

	return {
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = SOLID_LEFT_ARROW },
		{ Background = { Color = background } },
		{ Foreground = { Color = foreground } },
		{ Text = title },
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = SOLID_RIGHT_ARROW },
	}
end)

-- config.enable_tab_bar = false
config.show_new_tab_button_in_tab_bar = false
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.tab_max_width = 100

-- +++++++++++++++++++++++++++++++++
-- shells
-- +++++++++++++++++++++++++++++++++
if platform.is_win then
	-- config.default_prog = io.popen("where pwsh.exe 2>nul"):read("*a") ~= "" and { "pwsh", "-NoLogo" } or { "powershell" }
	config.default_prog = { os.getenv("USERPROFILE") .. "\\scoop\\apps\\nu\\current\\nu.exe" }
	config.launch_menu = {
		{ label = "PowerShell Core", args = { "pwsh", "-NoLogo" } },
		{ label = "PowerShell Desktop", args = { "powershell" } },
		{ label = "Command Prompt", args = { "cmd" } },
		{
			label = "Git Bash",
			args = { os.getenv("USERPROFILE") .. "\\scoop\\apps\\git\\current\\bin\\bash.exe" },
		},
		{
			label = "NuShell",
			args = { os.getenv("USERPROFILE") .. "\\scoop\\apps\\nu\\current\\nu.exe" },
		},
	}
end

return config
