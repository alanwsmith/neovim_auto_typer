-- local do_it = function()
--   print("asdf")
--   local t = vim.loop.new_timer()
--   t:start(0, 4000, vim.schedule_wrap(function()
--     print("qwer")
--     t:close()
--     end))
--   -- print("eeeee")
-- end

local updates = {
  content = {},
  current_index = 1
}

updates.content[1] = { kind = "write", data = "this is some code" }

-- d.write = function(s)
--   print(s)
-- end
--

updates.write = function(data)
  -- local timer = vim.loop.new_timer()
  -- local d = {}
  -- local i = 1
  -- for str in string.gmatch(data, "(%w)") do
  --   table.insert(t, str)
  -- end
  -- timer:start(0, 100, vim.schedule_wrap(
  --   function() 
  --     vim.cmd("normal A" .. d.current_index)
  --     d.current_index = d.current_index + 1
  --     if d.current_index > #d.content then
  --       d.timer:close()
  --     end
  --   end
  -- ))

end


-- function mysplit(inputstr, sep)
--   if sep == nil then
--     sep = "%s"
--   end
--   local t = {}
--   for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
--     table.insert(t, str)
--   end
--   return t
-- end

updates.run = function()
  for k, v in ipairs(updates.content) do
    if v.kind == "write" then
      updates.write(v.data)
    end
  end

  -- d.timer:start(1000, 1000, vim.schedule_wrap(
  --   function() 
  --     vim.cmd("normal A" .. d.current_index)
  --     d.current_index = d.current_index + 1
  --     if d.current_index > #d.content then
  --       d.timer:close()
  --     end
  --   end
  -- ))

end


updates.run()

print("asdf")

-- return {
--   run = updates.run() 
-- }




-- local fa = function()
--   print("a")
-- end

-- local fb = function()
--   print("b")
-- end

-- local do_it = function()
--   vim.defer_fn(fa, 1000)
--   vim.defer_fn(fb, 2000)
-- end



-- local do_sleep = function(t) 
--   os.execute("sleep " .. tonumber(t))
-- end

-- function foo1 (a)
--   print("foo", a)
--   return coroutine.yield(2*a)
-- end
-- co = coroutine.create(function (a,b)
--       vim.api.nvim_command('echo ' .. a)
--       -- print("co-body", a, b)
--       do_sleep(a)
--       local r = foo1(a+1)
--       -- print("co-body", r)
--       local r, s = coroutine.yield(a+b, a-b)
--       -- print("co-body", r, s)
--       return b, "end"
-- end)
-- print("main", coroutine.resume(co, 4, 10))
-- print("main", coroutine.resume(co, 1, 10))

-- print("main", coroutine.resume(co, "r"))
-- print("main", coroutine.resume(co, "x", "y"))
-- print("main", coroutine.resume(co, "x", "y"))-- local ping1 = function()

--   vim.cmd('normal Aa')
-- end


-- local ping2 = function()
--   vim.cmd('normal Ab')
-- end

-- local run_it = function()
--   ping1()
--   do_sleep(3)
--   ping2()
-- end

-- local run_it = function()
--   vim.api.nvim_command('echo "Hello, Nvim!"')
--   do_sleep(3)
--   vim.api.nvim_command('echo "etc...!"')
-- end

-- run_it()

-- local a = require'plenary.async'

-- -- Create a timer handle (implementation detail: uv_timer_t).
-- local timer = vim.uv.new_timer()
-- local i = 0
-- -- Waits 1000ms, then repeats every 750ms until timer:close().
-- timer:start(1000, 750, function()
--   print('timer invoked! i='..tostring(i))
--   if i > 4 then
--     timer:close()  -- Always close handles to avoid leaks.
--   end
--   i = i + 1
-- end)
-- print('sleeping');



-- local Job = require'plenary.job'


-- local do3 = function()
--   print("asdf")
--   Job:new({
--     command = 'sleep',
--     args = { '3' },
--     -- cwd = '/usr/bin',
--     -- env = { ['a'] = 'b' },
--     on_exit = function(j, return_val)
--       print(j:result())
--       -- print(return_val)
--       -- print(j:result())
--     end,
--   }):start() -- or start()
--   print("qwer")
-- end

-- do3()



-- local a = require "plenary.async"

-- function do_sleep(t)
--   os.execute("sleep " .. tonumber(t))
-- end

-- local ping = function() 
--   print("asdf")
--   print("werwerw")
-- end

-- local ping2 = function() 
--   print("qwer")
-- end

--local do_it = function()
--  print("asdf")
--  print("werwerw")
--  -- do_sleep(1)
--  -- print("qwer")
--  -- do_sleep(1)
--  -- print("zxcv")
---- a.run(ping)
---- do_sleep(1)
---- a.run(ping2)
---- do_sleep(1)
---- a.run(ping2)
----return vim.cmd.luaeval('math.pi')
---- call v:lua.ping2()
--end

--local do_it2 = function()
--  do_sleep(2)
--  print("qwer")
---- a.run(ping)
---- do_sleep(1)
---- a.run(ping2)
---- do_sleep(1)
---- a.run(ping2)
----return vim.cmd.luaeval('math.pi')
---- call v:lua.ping2()
--end


-- a.run(do_it)
-- a.run(do_it2)



-- b = vim.api.nvim_get_current_buf()
-- print(b)

-- function write_character(char) 
--   vim.cmd('normal A' .. char)
--   -- local pos = vim.api.nvim_win_get_cursor(0)[2]
--   -- local line = vim.api.nvim_get_current_line()
--   -- local nline = line:sub(0, pos) .. char .. line:sub(pos + 1)
--   -- vim.api.nvim_set_current_line(nline)
-- end

-- function working_write_character() 
--   local pos = vim.api.nvim_win_get_cursor(0)[2]
--   local line = vim.api.nvim_get_current_line()
--   local nline = line:sub(0, pos) .. '-- code' .. line:sub(pos + 1)
--   vim.api.nvim_set_current_line(nline)
-- end

-- function make_newline()
--   -- local pos = vim.api.nvim_win_get_cursor(0)
--   -- vim.api.nvim_buf_set_lines(0, pos[1], pos[1], false, {''}) -- For `o`
--   -- vim.api.nvim_buf_set_lines(0, pos[1]-1, pos[1]-1, false, {''}) -- For `O`
--   vim.cmd'normal o'
-- end


-- function do_sleep(t)
--   os.execute("sleep " .. tonumber(t))
-- end


-- write_character("a")
-- -- make_newline()
-- do_sleep(0.9)
-- write_character("b")
-- do_sleep(0.9)
-- -- make_newline()
-- write_character("c")

-- vim.api.execute("normal! i" .. "asdf")

-- function doIt()
-- write_character("a")
-- -- make_newline()
-- do_sleep(0.9)
-- write_character("b")
-- do_sleep(0.9)
-- -- make_newline()
-- write_character("c")
-- end

-- doIt()





-- local a = require "plenary.async"

-- local function write_char(char) 
--   vim.cmd('normal A' .. char)
-- end

-- local function wchar(char)
--   local pos = vim.api.nvim_win_get_cursor(0)[2]
--   local line = vim.api.nvim_get_current_line()
--   local nline = line:sub(0, pos) .. char .. line:sub(pos + 1)
--   vim.api.nvim_set_current_line(nline)
-- end

-- local function do_sleep(t)
--   os.execute("sleep " .. tonumber(t))
-- end

-- local function do_stuff()
--   wchar('a')
--   do_sleep(1)
--   wchar('b')
-- end


-- local do_stuff = function() 
--   a.uv.do_sleep(2)
--   vim.cmd('normal Ax')
-- end
