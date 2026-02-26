local M = {}

-- Function to run a compiled C program
M.run_c_program = function()
  -- 1. Check if we already have a cached path
  local path = vim.g.last_run_path

  -- 2. If no cache, ask the user
  if not path or path == '' then
    path = vim.fn.input('Path to executable to run: ', vim.fn.getcwd() .. '/', 'file')
    vim.g.last_run_path = path
  end

  -- 3. Run the program in a horizontal split terminal
  if path and path ~= '' then
    vim.cmd 'write' -- Save changes
    vim.cmd 'split' -- Open the window
    vim.cmd 'enew' -- Create a fresh buffer in that window

    -- Start the program. The window will NOT close when it's done.
    vim.fn.termopen(path)

    -- This keeps you in "Normal Mode" so you can read the 4 lines
    -- and close the window whenever you're ready with :q
    vim.cmd 'stopinsert'
  end
end

-- Function to clear the cache
M.clear_run_cache = function()
  vim.g.last_run_path = nil
  print 'Run cache cleared!'
end

return M
