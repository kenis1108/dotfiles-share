# settings
# see the doc via run: "config nu --doc | nu-highlight | less -R"
$env.config.buffer_editor = "nvim"
$env.config.show_banner = false

# completions
source ./completions/git/git-completions.nu
source ./completions/npm/npm-completions.nu
source ./completions/scoop/scoop-completions.nu
source ./completions/rg/rg-completions.nu
source ./completions/uv/uv-completions.nu

# alias
# chezmoi
alias cc = cd (chezmoi source-path)
alias ca = chezmoi apply --force
alias ce = chezmoi edit --apply

# lazygit
alias lg = lazygit

# yazi
def --env y [...args] {
	let tmp = (mktemp -t "yazi-cwd.XXXXXX")
	yazi ...$args --cwd-file $tmp
	let cwd = (open $tmp)
	if $cwd != "" and $cwd != $env.PWD {
		cd $cwd
	}
	rm -fp $tmp
}

# fnm
# See More About How To Use Fnm On NuShell From The issues https://github.com/Schniz/fnm/issues/463 
fnm env --json | from json | load-env
$env.PATH ++= [($env.FNM_MULTISHELL_PATH)]

# starship
mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
