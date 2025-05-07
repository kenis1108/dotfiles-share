if vim.g.vscode then
  -- VSCode extension
  require('vscode').notify("Hello Neovim")
else
  -- ordinary Neovim
  require("config.options")
  require("config.keybinds")
  require("lazynvim")
end
