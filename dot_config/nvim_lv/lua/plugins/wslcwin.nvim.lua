-- TODO: 其实在vscode里使用nvim也可以使用这个插件，所以要改下插件名了
return {
  "kenis1108/wslcwin.nvim",
  event = "VeryLazy",
  config = function()
    require("wslcwin").setup()
  end,
  -- 仅在 WSL 环境中启用
  cond = function()
    return vim.fn.getenv("WSL_DISTRO_NAME") ~= vim.NIL
  end,
}
