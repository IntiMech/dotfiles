
local M = {}

function M.setup()
  -- Setup neodev for better development experience
  require("neodev").setup({
    library = { plugins = { "neotest" }, types = true },
  })

  -- Setup Neotest with its adapters and configurations
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
end

return M
