#--------------------
# completions
#--------------------
autoload -Uz compinit
compinit
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'       # Case insensitive tab completion 设置补全时不区分大小写
zstyle ':completion:*' rehash true                              # automatically find new executables in path  自动刷新补全缓存，当 PATH 中新增可执行文件时，无需手动运行 `rehash`
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"         # Colored completion (different colors for dirs/files/etc)
zstyle ':completion:*' menu select # 启用菜单选择模式，在补全结果较多时可以使用方向键选择

# 定义补全器的顺序，使补全功能更加强大
zstyle ':completion:*' completer _expand _complete _ignored _approximate
# _expand：展开路径、别名或变量（如 `~` 展开为 `/home/username`）
# _complete：标准补全器，用于匹配已有内容
# _ignored：包括被忽略的补全项
# _approximate：容错补全器，可纠正拼写错误或漏字                          

# 设置菜单选择模式下的提示信息
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
# %S 和 %s：启用和关闭高亮显示
# %p：显示当前选择项的百分比位置
# 提示效果：例如 **Scrolling active: current selection at 50%**

# 美化补全描述信息的显示格式
zstyle ':completion:*:descriptions' format '%U%F{cyan}%d%f%u'   
# %U 和 %u：启用和关闭下划线
# %F{cyan} 和 %f：设置字体颜色为青色，并关闭颜色
# %d：显示补全项的描述文本
# 效果：补全描述以青色下划线显示，突出内容

# Speed up completions
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.cache/zcache

# automatically load bash completion functions
autoload -U +X bashcompinit && bashcompinit


