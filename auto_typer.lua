local updates = {
  content = {},
  debug = 1
}

function string:split(delimiter)
  local result = { }
  local from  = 1
  local delim_from, delim_to = string.find( self, delimiter, from  )
  while delim_from do
    table.insert( result, string.sub( self, from , delim_from-1 ) )
    from  = delim_to + 1
    delim_from, delim_to = string.find( self, delimiter, from  )
  end
  table.insert( result, string.sub( self, from  ) )
  return result
end

updates.load_script = function() 
  local fn = "/Users/alan/workshop/nvim_auto_typer/auto-type-script.txt"
  local f = assert(io.open(fn, "r"))
  local script_data = f:read("*all")
  local lines = script_data:split("\n")
  f:close()
  for _, line in ipairs(lines) do
    if line ~= "" then
      local line_parts = line:split("|")
      if line_parts[1] == "newline" then
        table.insert(updates.content, { action = "newline" })
      elseif line_parts[1] == "pause" then
        table.insert(updates.content, { action = "pause", kind = line_parts[2])
      elseif line_parts[1] == "tab" then
        table.insert(updates.content, { action = "tab" })
      elseif line_parts[1] == "write" then
        table.insert(updates.content, { action = "write", data = line_parts[2] })
      end
    end
  end
end


--local ping = function()
--  vim.api.nvim_paste([[-- alfa
--]], false, -1)
--  --print("alfa")
--  do_sleep(3)
--  --print("bravo")
--  -- nvim_paste({"asdf"})
--  vim.api.nvim_paste([[-- bravo]], false, -1)
--end


-- ping()

-- alfa
-- bravo
-- local do_sleep = function(t) 
--   os.execute("sleep " .. tonumber(t))
-- end

updates.output_chars = function(data)
  for str in string.gmatch(data, "(.)") do
    vim.api.nvim_paste(str, false, -1)
  end
end


updates.go = function()
  for _, v in ipairs(updates.content) do
    if v.action == "newline" then
      vim.cmd('normal o')
    elseif v.action == "pause" then
    elseif v.action == "tab" then
    elseif v.action == "write" then
      updates.output_chars(v.data)
    end
  end
end

updates.run = function() 
  vim.cmd('set paste')
  updates.load_script()
  -- vim.cmd('NvimTreeClose')
  -- vim.cmd('tabnew')
  updates.go()
  vim.cmd('set nopaste')
end


-- updates.run = function() 
--   -- local pop_buffer = vim.api.nvim_create_buf(false, true)
--   vim.cmd('NvimTreeClose')
--   updates.load_script()
--   updates.make_runner()
--   updates.go()
-- end

updates.run()

