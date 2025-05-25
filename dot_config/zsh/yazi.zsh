## yazi退出时自动切换到退出时的目录
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	EDITOR=nvim yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}