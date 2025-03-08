# Kenis DotFiles (分享版，内容不全，未整理好)

📁 个人 dotfiles 配置管理仓库，使用 chezmoi 进行管理。

## 目录

- [如何使用](#如何使用)
- [配置文件说明](#配置文件说明)
  - [编辑器配置](#编辑器配置)
  - [Shell 配置](#shell配置)
  - [系统配置](#系统配置)
  - [窗口管理器配置](#窗口管理器配置)
  - [终端仿真器配置](#终端仿真器配置)
  - [终端文件管理器配置](#终端文件管理器配置)
  - [应用启动器配置](#应用启动器配置)
  - [其他工具配置](#其他工具配置)
- [特殊文件管理](#特殊文件管理)
- [不在用户目录下的文件管理](#不在用户目录下的文件管理)
  - [Windows](#windows)
  - [Linux](#linux)

## 如何使用

1. 初始化 chezmoi：

   ```powershell
   git clone https://github.com/yourusername/dotfiles.git ~/.local/share/chezmoi
   # or
   chezmoi init yourusername
   # or
   chezmoi init https://github.com/yourusername/dotfiles.git
   ```

2. 复制`chezmoi_config_template.toml`到`~/.config/chezmoi/chezmoi.toml`

3. 修改 chezmoi 配置：
   编辑`~/.config/chezmoi/chezmoi.toml`，根据当前系统修改相应变量值

4. 应用所有配置：

   ```powershell
   chezmoi apply
   ```

5. 修改各个应用的配置
   使用`chezmoi edit --apply $FILE`来编辑各个应用配置文件并在保存的时候自动 apply，并且自动 push 到 git 仓库

## 配置文件说明

### 编辑器配置

| 配置文件          | 路径                                  | 说明                  |
| ----------------- | ------------------------------------- | --------------------- |
| Neovim（Windows） | `AppData/Local/nvim`                  | Neovim 配置文件       |
| Neovim（Linux）   | `~/.config/nvim`                      | Neovim 配置文件       |
| Neovide           | `AppData/Roaming/neovide/config.toml` | Neovide 配置文件      |
| VSCode            | `AppData/Roaming/Code`                | VSCode 配置文件       |
| Cursor            | `AppData/Roaming/Cursor`              | Cursor 编辑器配置     |
| Vim (Windows)     | `_vimrc`                              | Windows 下的 Vim 配置 |
| Vim (Linux)       | `.vimrc`                              | Linux 下的 Vim 配置   |

#### Neovim 注意事项

- 需要提前安装 gcc：`scoop install gcc`
- 需要提前安装 node：`scoop install nvm-windows`

#### VSCode 说明

- 配置文件包括设置和快捷键
- 配合 VSCode 的同步功能一起使用
- 不同 Profile 的配置文件继承 Default 配置文件

#### Cursor 说明

- 复制 VSCode 的配置文件
- 可以通过 File->Preferences->Cursor Settings->General->VS Code Import 导入 VSCode 配置

### Shell 配置

| 配置文件     | 路径                                                           | 说明                      |
| ------------ | -------------------------------------------------------------- | ------------------------- |
| PowerShell 7 | `Documents/PowerShell/Microsoft.PowerShell_profile.ps1`        | PowerShell 7 配置         |
| PowerShell 5 | `Documents/WindowsPowerShell/Microsoft.PowerShell_profile.ps1` | Windows PowerShell 5 配置 |
| Zsh          | `.zshrc`                                                       | Zsh 配置文件              |

### 系统配置

| 配置文件 | 路径         | 说明         |
| -------- | ------------ | ------------ |
| Git      | `.gitconfig` | Git 全局配置 |
| WSL      | `.wslconfig` | WSL 配置文件 |
| X11      | `.xprofile`  | X11 会话配置 |

### 窗口管理器配置

| 配置文件 | 路径                        | 说明                       |
| -------- | --------------------------- | -------------------------- |
| GlazeWM  | `.glzr/glazewm/config.yaml` | GlazeWM 平铺窗口管理器配置 |
| i3wm     | `.config/.i3/config`        | i3wm 配置                  |
| i3status | `.config/i3status/config`   | i3status 配置              |
| swaywm   | `.config/sway`              | sway 配置                  |
| Hyprland | `.config/hypr`              | Hyprland 配置              |
| waybar   | `.config/waybar`            | waybar 配置                |

### 终端仿真器配置

| 配置文件 | 路径                        | 说明           |
| -------- | --------------------------- | -------------- |
| kitty    | `.config/kitty`             | kitty 配置     |
| foot     | `.config/foot`              | foot 配置      |
| Urxvt    | `.Xresources`               | Urxvt 终端配置 |
| termux   | `.termux/termux.properties` | termux 配置    |

### 终端文件管理器配置

| 配置文件 | 路径             | 说明        |
| -------- | ---------------- | ----------- |
| ranger   | `.config/ranger` | ranger 配置 |
| yazi     | `.config/yazi`   | yazi 配置   |

### 应用启动器配置

| 配置文件          | 路径                    | 说明                                       |
| ----------------- | ----------------------- | ------------------------------------------ |
| rofi/rofi-wayland | `.config/rofi`          | rofi 配置，基于 adi1090x/rofi 的配置修改的 |
| xdg-open          | `.config/mimeapps.list` | xdg-open 配置                              |

### 其他工具配置

| 配置文件   | 路径                                                         | 说明                                             |
| ---------- | ------------------------------------------------------------ | ------------------------------------------------ |
| Navi       | `AppData/Roaming/navi/config.yaml`                           | Navi 命令行备忘录配置                            |
| Quicker    | `Documents/Quicker/Ceastld/userdata.db`                      | Quicker 剪贴板数据文件                           |
| urxvt 插件 | `.urxvt/ext`                                                 | urxvt 终端插件                                   |
| rime       | IBus: `.config/ibus/rime` Fcitx5: `.local/share/fcitx5/rime` | rime 输入法配置，基于 oh-my-rime 修改的          |
| mpv        | `.config/mpv/mpv.conf`                                       | mpv 配置，基于 Garuda_i3wm 的 mpv.conf 修改的    |
| Xmodmap    | `.Xmodmap`                                                   | Xmodmap 配置                                     |
| picom      | `.config/picom.conf`                                         | picom 配置，基于 Garuda_i3wm 的 picom 配置修改的 |
| nix        | `.config/nix/nix.conf`                                       | nix 包管理器配置                                 |

#### Quicker 注意事项

- 在另一台电脑中粘贴 userdata.db 时，需要 Quicker 处于退出状态
- chezmoi apply 之前需要退出 Quicker

#### urxvt 快捷键

- 字体放大：Ctrl + +
- 字体缩小：Ctrl + -
- 字体重置：Ctrl + =
- 显示字体信息：Ctrl + ?

## 特殊文件管理

- `.reset_config`: 存放系统初始配置文件，方便回滚
- `.ssh`: SSH 配置文件
- `.zzsz`: zzsz 相关配置
- `Pictures`: Windows 系统用户目录的图片文件夹
- `scoop/persist`: 管理使用 scoop 安装的 espanso 和 win-vind 的配置文件数据, 其实他们也有默认的配置文件路径在用户目录下面, 但是使用 scoop 安装的话, 配置文件会安装到这里来
- `.chezmoiignore`: 管理不同操作系统下的配置文件
- `chezmoi_config_template.toml`: chezmoi 配置文件模板
- `.profile`: 修改 Linux 默认程序
- `.custom-scripts`: 存放自定义脚本，如获取网站 favicon
- `.config/nixos`: NixOS 系统的配置，使用`sh ~/.config/nixos/scripts/switch_xxx.sh`部署

## 不在用户目录下的文件管理

### Windows

| 文件  | 路径                                    | 说明            |
| ----- | --------------------------------------- | --------------- |
| hosts | `C:/Windows/System32/drivers/etc/hosts` | 系统 hosts 文件 |

### Linux

| 文件  | 路径         | 说明            |
| ----- | ------------ | --------------- |
| hosts | `/etc/hosts` | 系统 hosts 文件 |

Linux hosts 文件安装命令：

```bash
sudo mv dot_hosts /etc/hosts
```
