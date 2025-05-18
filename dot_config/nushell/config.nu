# settings
# see the doc via run: "config nu --doc | nu-highlight | less -R"
$env.config.buffer_editor = "nvim"
$env.config.show_banner = false

# completions
source ./completions/git/git-completions.nu
source ./completions/npm/npm-completions.nu

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

# starship
mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
