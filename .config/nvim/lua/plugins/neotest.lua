local M = {}

function M.setup()
  -- Setup neodev for better development experience
  require("neodev").setup({
    library = { plugins = { "neotest" }, types = true },
  })

  require("neotest").setup({
    adapters = {
      require("neotest-python")({
        dap = { justMyCode = false },
      }),
      require("neotest-plenary"),
    },
    status = { virtual_text = true },
    output = { open_on_run = true },
    quickfix = {
      open = function()
        local has_trouble, trouble = pcall(require, "trouble")
        if has_trouble then
          trouble.open({ mode = "quickfix", focus = false })
        else
          vim.cmd("copen")
        end
      end,
    },
  })

  -- Function to setup keybindings
  local function setup_neotest_keybindings()
    local neotest = require("neotest")
    if not neotest or not neotest.run then
      print("Neotest is not loaded properly!")
      return
    end

    print("Setting up Neotest keybindings...")

    -- Define keybindings
    vim.keymap.set('n', '<Leader>tt', function() neotest.run.run(vim.fn.expand("%")) end, { silent = true, desc = "Run Neotest on current file" })
    vim.keymap.set('n', '<Leader>tT', function() neotest.run.run(vim.loop.cwd()) end, { silent = true, desc = "Run all Neotest files" })
    vim.keymap.set('n', '<Leader>tr', function() neotest.run.run() end, { silent = true, desc = "Run nearest Neotest" })
    vim.keymap.set('n', '<Leader>tl', function() neotest.run.run_last() end, { silent = true, desc = "Run last Neotest" })
    vim.keymap.set('n', '<Leader>ts', function() neotest.summary.toggle() end, { silent = true, desc = "Toggle Neotest summary" })
    vim.keymap.set('n', '<Leader>to', function() neotest.output.open({ enter = true, auto_close = true }) end, { silent = true, desc = "Open Neotest output" })
    vim.keymap.set('n', '<Leader>tO', function() neotest.output_panel.toggle() end, { silent = true, desc = "Toggle Neotest output panel" })
    vim.keymap.set('n', '<Leader>tS', function() neotest.run.stop() end, { silent = true, desc = "Stop Neotest run" })

    print("Neotest keybindings set up successfully!")
  end

  -- Delay keybinding setup to ensure Neotest is fully loaded
  vim.defer_fn(setup_neotest_keybindings, 100)  -- Adjust delay as needed
end

return M
