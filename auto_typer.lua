local updates = {
  content = {},
  runner = {},
  debug = 0
}

updates.content[1] = { action = "write", data = "-- this is some code" }
updates.content[2] = { action = "newline" }
updates.content[3] = { action = "write", data = " and some more" }
updates.content[4] = { action = "newline" }
updates.content[5] = { action = "write", data = " and even more" }


updates.deploy = function(d)
  if d.kind == 'char' then
    vim.cmd('normal A' .. d.data)
  elseif d.kind == 'newline' then
    vim.cmd('normal o')
  end
end

updates.make_runner = function() 
  local runner_ping = 1
  for k, v in ipairs(updates.content) do
    if v.action == 'write' then
      for str in string.gmatch(v.data, "(.)") do
        local tics = 5
        if updates.debug == 1 then
          tics = 0
        end
        updates.runner[runner_ping] = { kind = "char", tics = tics, data = str }
        runner_ping = runner_ping + 1
      end
    elseif v.action == 'newline' then
      local tics = 80
      if updates.debug == 1 then
        tics = 0
      end
      updates.runner[runner_ping] = { kind = "newline", tics = tics }
      runner_ping = runner_ping + 1
    end
  end
end


updates.go = function() 
  local timer = vim.loop.new_timer()  
  local runner_index = 1
  local runner_tics = 0
  -- updates.runner[runner_index].tics
  timer:start(0, 5, vim.schedule_wrap(function() 
    if runner_tics == updates.runner[runner_index].tics then
      updates.deploy(updates.runner[runner_index])
      runner_index = runner_index + 1
      if runner_index > #updates.runner then
        timer:stop()
        timer:close()
      else
        runner_tics = 0
      end
    else 
      runner_tics = runner_tics + 1
    end
  end))
end

updates.run = function() 
  updates.make_runner()
  updates.go()
end

updates.run()

