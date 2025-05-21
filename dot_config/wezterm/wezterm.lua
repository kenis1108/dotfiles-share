local wezterm = require("wezterm")
local platform = require("utils.platform")

local config = {
	font = wezterm.font("FiraCode Nerd Font"),
	color_scheme = "Catppuccin Mocha",
	window_background_opacity = 0.95,
	window_decorations = "RESIZE",
	use_fancy_tab_bar = false,
	hide_tab_bar_if_only_one_tab = true,
	show_new_tab_button_in_tab_bar = false,
	adjust_window_size_when_changing_font_size = false,
	window_padding = {
		left = 14,
		right = 10,
		top = 10,
		bottom = 10,
	},
	keys = {
		{
			key = "t",
			mods = "CTRL|SHIFT",
			action = wezterm.action.ShowLauncherArgs({ flags = "FUZZY|LAUNCH_MENU_ITEMS|TABS" }),
		},
	},
}

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
