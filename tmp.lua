local open_floating_window = function()
  local opts = {
    style="minimal", 
    relative='editor',
    border='single'
  }
  opts.width = vim.api.nvim_win_get_width(0) - 18
  opts.height = vim.api.nvim_win_get_height(0) - 12
  opts.col = (vim.api.nvim_win_get_width(0) / 2) - (opts.width / 2)
  opts.row = (vim.api.nvim_win_get_height(0) / 2) - (opts.height / 2)
  local floating_buffer = vim.api.nvim_create_buf(false, true)
  local floating_window = vim.api.nvim_open_win(floating_buffer, true, opts)
  return floating_buffer
end

open_floating_window()

