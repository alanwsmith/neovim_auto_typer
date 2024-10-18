local M = {
  debug = "off",
  source = os.getenv('HOME') .. "/Desktop/auto-typer-script.txt",
  content = {},
  popup_id = nil,
}

function M.close_popup()
  vim.api.nvim_win_close(M.popup_id, {}) 
  M.popup_id = nil
  -- this is a hack to close the popup window
  -- without it, the window stays open until 
  -- the next character is written which means
  -- pauses after it closes doesn't work
  vim.api.nvim_paste("", false, -1)
end

function M.do_delay(min, max) 
  if M.debug ~= "on" then
    math.randomseed(os.time())
    local delay = math.random(min, max)
    vim.uv.sleep(delay)
  end
end

function M.load_script() 
  M.content = {}
  local f = assert(io.open(M.source, "r"))
  local script_data = f:read("*all")
  -- TODO: Make this a single split so pipes can be send in the data
  local lines = M.split(script_data, "\n")
  f:close()
  for _, line in ipairs(lines) do
    if line ~= "" then
      local line_parts = M.split(line, "|")
      if line_parts[1] ~= nil then
        if line_parts[1] == "close-popup" then
          table.insert(M.content, { action = "close-popup" })
        elseif line_parts[1] == "cmd" then
          table.insert(M.content, { action = "cmd", command = M.trim(line_parts[2]) })
        elseif line_parts[1] == "debug" then
          table.insert(M.content, { action = "debug", state = M.trim(line_parts[2]) })
        elseif line_parts[1] == "end-skip" then
          table.insert(M.content, { action = "end-skip" })
        -- elseif line_parts[1] == "feedkeys" then
          --table.insert(M.content, { action = "feedkeys", keys = M.trim(line_parts[2]) })
          -- setting the file extension isn't working
          -- as expected this way, so just opening a tmp file
          -- for now
        -- elseif line_parts[1] == "filetype" then
        --   table.insert(M.content, { action = "filetype", extension = M.trim(line_parts[2]) })
        elseif line_parts[1] == "newline" then
          table.insert(M.content, { action = "newline" })
        elseif line_parts[1] == "pause" then
          table.insert(M.content, { action = "pause", kind = M.trim(line_parts[2]) })
        elseif line_parts[1] == "open_file" then
          table.insert(M.content, { action = "open_file", path = M.trim(line_parts[2]) })
        elseif line_parts[1] == "open-popup" then
          table.insert(M.content, { action = "open-popup" })
        elseif line_parts[1] == "start-skip" then
          table.insert(M.content, { action = "start-skip" })
        elseif line_parts[1] == "tab" then
          table.insert(M.content, { action = "tab" })
        elseif line_parts[1] == "write" then
          table.insert(M.content, { action = "write", data = line_parts[2] })
        end
      end
    end
  end
end

function M.open_file(path)
  vim.api.nvim_command('edit ' .. path)
end

function M.open_popup()
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
  M.popup_id = floating_window
end

function M.output_chars(data)
  for str in string.gmatch(data, "(.)") do
    vim.api.nvim_paste(str, false, -1)
    M.do_delay(20, 40)
  end
end

function M.run()
  M.load_script()
  vim.cmd('set paste')
  M.type_the_script()
  vim.cmd('set nopaste')
end

-- setting the file type isn't working as expected
-- right now. so just opening a tmp file for now
-- function M.set_filetype(extension)
--   vim.cmd('set filetype=' .. extension)
--   -- this is a hack to set the file extension at
--   -- the start of the run
--   vim.api.nvim_paste("", false, -1)
-- end

function M.split(str, delimiter) 
  local results = {}
  local from = 1
  local delim_from, delim_to = string.find(str, delimiter, from)
  while delim_from do
    table.insert(results, string.sub(str, from , delim_from-1))
    from  = delim_to + 1
    delim_from, delim_to = string.find(str, delimiter, from)
  end
  table.insert(results, string.sub(str, from))
  return results
end

function M.trim(str) 
  return string.gsub(str, '^%s*(.-)%s*$', '%1')
end

function M.type_the_script() 
  for _, v in ipairs(M.content) do
    if v.action == "close-popup" then
      M.close_popup()
    elseif v.action == "cmd" then
      vim.cmd(v.command)
    elseif v.action == "debug" then
      print("debug now: " .. v.state)
      M.debug = v.state
--    elseif v.action == "feedkeys" then  
 --     local key = nvim_replace_termcodes(v.keys, v:true, v:false, v:true)
  --    nvim_feedkeys(key, 'n', v:false)
    -- turn this back on when filetype setting
    -- is fixed
    -- elseif v.action == "filetype" then
    --   M.set_filetype(v.extension)
    elseif v.action == "newline" then
      vim.api.nvim_paste("\n", false, -1)
    elseif v.action == "open-popup" then
      M.open_popup()
    elseif v.action == "open_file" then
      M.open_file(v.path)
    elseif v.action == "pause" then
      M.do_delay(2000, 2000)
    elseif v.action == "tab" then
      vim.api.nvim_paste("\t", false, -1)
    elseif v.action == "write" then
      M.output_chars(v.data)
    end
  end
end

return M
