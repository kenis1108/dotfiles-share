-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.number = true
-- Make line numbers default
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = "a"

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
vim.schedule(function()
  vim.opt.clipboard = "unnamedplus"
end)

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- Decrease update time
vim.opt.updatetime = 250

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- display certain whitespace characters in the editor.
vim.opt.list = true

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Highlight Current Line
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- raise a dialog asking if you wish to save the current file(s)
vim.opt.confirm = true

-- default shell
-- vim.opt.shell = "powershell.exe"

-- default indent
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.expandtab = true

-- fold
vim.opt.foldmethod = "indent"
vim.opt.foldlevel = 99

-- modeline
vim.opt.modeline = true
vim.opt.modelines = 2
