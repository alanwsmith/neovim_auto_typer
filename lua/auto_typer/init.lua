local M = {
  content = {}
}

-- not sure how naming spacing works here so 
-- prefixing with `aws_`
function string:aws_split(delimiter)
  local result = {}
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

-- function M.ping()
--   print("yyyy")
-- end

function M.type_the_script() 
  print("typing the script")
  M.load_script()
end

function M.load_script() 
  local fn = "/Users/alan/workshop/nvim_auto_typer/auto-type-script.txt"
  local f = assert(io.open(fn, "r"))
  local script_data = f:read("*all")
  local lines = script_data:split("\n")
  f:close()
  for _, line in ipairs(lines) do
    if line ~= "" then
      local line_parts = line:split("|")
      if line_parts[1] ~= nil then
        if line_parts[1] == "newline" then
          table.insert(M.content, { action = "newline" })
        elseif line_parts[1] == "pause" then
          table.insert(M.content, { action = "pause", kind = line_parts[2] })
        elseif line_parts[1] == "pop_window" then
          table.insert(M.content, { action = "pop_window" })
        elseif line_parts[1] == "tab" then
          table.insert(M.content, { action = "tab" })
        elseif line_parts[1] == "write" then
          table.insert(M.content, { action = "write", data = line_parts[2] })
        end
      end
    end
  end
end


-- local output_chars = function(data)
--   for str in string.gmatch(data, "(.)") do
--     vim.api.nvim_paste(str, false, -1)
--     vim.uv.sleep(20)
--   end
-- end

-- local go = function(content)
--   for _, v in ipairs(content) do
--     if v.action == "newline" then
--       vim.api.nvim_paste("\n", false, -1)
--     elseif v.action == "pause" then
--       vim.uv.sleep(1000)
--     elseif v.action == "tab" then
--       vim.api.nvim_paste("\t", false, -1)
--     elseif v.action == "write" then
--       output_chars(v.data)
--     end
--   end
-- end

-- run = function() 
--   vim.cmd('NvimTreeClose')
--   vim.cmd('set paste')
--   local content = load_script()
--   go(content)
--   vim.cmd('set nopaste')
-- end

-- run()



-- return {
--  run = run
-- }

M.type_the_script()

return M
