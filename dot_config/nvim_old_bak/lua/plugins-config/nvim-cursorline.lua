-- 取消vim高亮当前行和列
vim.o.cursorline = false
vim.o.cursorcolumn = false

require('nvim-cursorline').setup {
  cursorline = {
    enable = false,
    timeout = 1000,
    number = false,
  },
  cursorword = {
    enable = true,
    min_length = 3,
    hl = { underline = true },
  }
}
