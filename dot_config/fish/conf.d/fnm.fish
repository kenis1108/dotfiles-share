# fnm
set FNM_PATH "/data/data/com.termux/files/home/.local/share/fnm"
if [ -d "$FNM_PATH" ]
  set PATH $FNM_PATH $PATH
  fnm env | source
end
if type -q fnm
  fnm env --use-on-cd --shell fish | source
  fnm completions --shell fish | source
end

