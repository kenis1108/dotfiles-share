-- 判断是否为 Linux 系统
local is_linux = jit and jit.os == "Linux"

-- 检查 pokemon-colorscripts 命令是否存在
local is_pokemon_available = vim.fn.executable("pokemon-colorscripts") == 1

-- 获取当前窗口的宽度
local function get_window_width()
  local win = vim.api.nvim_get_current_win()
  return vim.api.nvim_win_get_width(win)
end

return {
  "folke/snacks.nvim",
  opts = {
    dashboard = {
      preset = {
        header = [[
          .-. .-')     ('-.       .-') _          .-')             ('-. .-.          ('-. .-. 
          \  ( OO )  _(  OO)     ( OO ) )        ( OO ).          ( OO )  /         ( OO )  / 
          ,--. ,--. (,------.,--./ ,--,' ,-.-') (_)---\_)         ,--. ,--.     ,--.,--. ,--. 
          |  .'   /  |  .---'|   \ |  |\ |  |OO)/    _ |    .-')  |  | |  | .-')| ,||  | |  | 
          |      /,  |  |    |    \|  | )|  |  \\  :` `.  _(  OO) |   .|  |( OO |(_||   .|  | 
          |     ' _)(|  '--. |  .     |/ |  |(_/ '..`''.)(,------.|       || `-'|  ||       | 
          |  .   \   |  .--' |  |\    | ,|  |_.'.-._)   \ '------'|  .-.  |,--. |  ||  .-.  | 
          |  |\   \  |  `---.|  | \   |(_|  |   \       /         |  | |  ||  '-'  /|  | |  | 
          `--' '--'  `------'`--'  `--'  `--'    `-----'          `--' `--' `-----' `--' `--' 
        ]],
      },
      sections = function()
        local base_sections = {
          { section = "header" },
          { section = "keys", gap = 1, padding = 1 },
          { section = "startup" },
        }

        local width = get_window_width()
        if is_linux and is_pokemon_available and width > 180 then
          table.insert(base_sections, {
            pane = 2,
            section = "terminal",
            cmd = "pokemon-colorscripts -r --no-title; sleep .1",
            random = 10,
            indent = 4,
            height = 30,
          })
        end

        return base_sections
      end,
    },
  },
}
