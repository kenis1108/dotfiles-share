vim.opt.termguicolors = true
require("bufferline").setup {
  options = {
    offsets = {
      {
        filetype = "netrw", -- 添加对Netrw的偏移 
        text = "Netrw File Explorer",
        text_align = "left", 
        separator = false
      }
    },
    separator_style = "slant"
  }
}
