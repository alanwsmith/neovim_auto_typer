if vim.g.auto_typer_version then
  return
end

vim.g.auto_typer_version = '0.1.0'

local typer = require('auto_typer')

vim.api.nvim_create_user_command(
  'AutoType', 
  function(opts)
    -- TODO: allow for passing in file path to a script here
    -- local args = vim.split(opts.args, ' ')
    -- local file_path = args[1]
    typer.run()
  end, 
  {}
)

