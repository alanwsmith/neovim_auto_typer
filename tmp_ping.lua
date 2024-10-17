
local do_sleep = function(t) 
  os.execute("sleep " .. tonumber(t))
end


local ping = function()
  vim.api.nvim_paste([[-- alfa
]], false, -1)
  --print("alfa")
  do_sleep(3)
  --print("bravo")
  -- nvim_paste({"asdf"})
  vim.api.nvim_paste([[-- bravo]], false, -1)
end


ping()

-- alfa
-- bravo
