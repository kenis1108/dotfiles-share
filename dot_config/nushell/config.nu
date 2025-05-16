# settings
# see the doc via run: "config nu --doc | nu-highlight | less -R"
$env.config.buffer_editor = "nvim"
$env.config.show_banner = false

# completions
source ./completions/git/git-completions.nu

# starship
mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
