local M = {
  source = os.getenv('HOME') .. "/Desktop/auto-typer-script.txt",
  content = {}
}

function M.load_script() 
  M.content = {}
  local f = assert(io.open(M.source, "r"))
  local script_data = f:read("*all")
  local lines = M.split(script_data, "\n")
  f:close()
  for _, line in ipairs(lines) do
    if line ~= "" then
      local line_parts = M.split(line, "|")
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

function M.output_chars(data)
  for str in string.gmatch(data, "(.)") do
    vim.api.nvim_paste(str, false, -1)
    vim.uv.sleep(20)
  end
end

function M.run()
  M.load_script()
  vim.cmd('NvimTreeClose')
  vim.cmd('set paste')
  M.type_the_script()
  vim.cmd('set nopaste')
  vim.cmd('NvimTreeOpen')
end

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

function M.type_the_script() 
  for _, v in ipairs(M.content) do
    if v.action == "newline" then
      vim.api.nvim_paste("\n", false, -1)
    elseif v.action == "pause" then
      vim.uv.sleep(1000)
    elseif v.action == "tab" then
      vim.api.nvim_paste("\t", false, -1)
    elseif v.action == "write" then
      M.output_chars(v.data)
    end
  end
end

return M
