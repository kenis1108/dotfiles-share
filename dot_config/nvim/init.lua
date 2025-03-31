if vim.g.vscode then
  -- VSCode extension
  require('vscode').notify("Hello Neovim")
else
  -- ordinary Neovim
  
  -- bootstrap lazy.nvim, LazyVim and your plugins
  require("config.lazy")
end


