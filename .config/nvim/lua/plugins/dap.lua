local dap = require('dap')
local dapui = require('dapui')
local nvim_dap_virtual_text = require('nvim-dap-virtual-text').setup()

-- Configure the Python adapter
dap.adapters.python = {
    type = 'executable',
    command = 'python',  -- Use the system-wide Anaconda Python
    args = { '-m', 'debugpy.adapter' }
}

-- Define the configurations for debugging
dap.configurations.python = {
    {
        type = 'python',
        request = 'launch',
        name = 'Launch file',
        program = '${file}',  -- This will launch the current file
        pythonPath = function()
            return '/home/mrmagee/Projects/IGScraper/IGScraperEnv/bin/python'  -- Adjust this path if necessary
        end,
    },
}

-- Set up dap-ui
dapui.setup({
    icons = { expanded = "", collapsed = "", current_frame = "" },
    mappings = {
        expand = { "<CR>", "<2-LeftMouse>" },
        open = "o",
        remove = "d",
        edit = "e",
        repl = "r",
        toggle = "t",
    },
    layouts = {
        {
            elements = {
                { id = "scopes", size = 0.25 },
                "breakpoints",
                "stacks",
                -- "watches",
            },
            size = 60,  -- 40 columns
            position = "right",
        },
        {
            elements = {
                "repl",
                "watches",
            },
            size = 0.25,  -- 25% of total lines
            position = "bottom",
        },
    },
    controls = {
        enabled = true,
        element = "repl",
        icons = {
            pause = "",
            play = "",
            step_into = "",
            step_over = "",
            step_out = "",
            step_back = "",
            run_last = "",
            terminate = "",
        },
    },
    floating = {
        max_height = nil,
        max_width = nil,
        border = "single",
        mappings = {
            close = { "q", "<Esc>" },
        },
    },
    windows = { indent = 1 },
    render = {
        max_type_length = nil,
        max_value_lines = 100,
    }
})

vim.fn.sign_define('DapBreakpoint', { text='🔴', texthl='DapBreakpoint', linehl='DapBreakpoint', numhl='DapBreakpoint' })

-- DAP Keybindings
vim.keymap.set('n', '<leader>dt', function() require('dapui').toggle() end)
vim.keymap.set('n', '<leader>db', function() require('dap').toggle_breakpoint() end)
vim.keymap.set('n', '<leader>dc', function() require('dap').continue() end)
vim.keymap.set('n', '<leader>dl', function() require('dap').run_last() end)
vim.keymap.set('n', '<leader>dr', function() require('dap').repl.open() end)
vim.keymap.set('n', '<leader>bc', function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end)
vim.keymap.set('n', '<leader>dp', function() require('dap').pause() end)
vim.keymap.set('n', '<leader>dw', function() require('dap.ui.widgets').hover() end)
vim.keymap.set('n', '<F6>', function() require('dap').step_over() end)
vim.keymap.set('n', '<F7>', function() require('dap').step_into() end)
vim.keymap.set('n', '<F8>', function() require('dap').step_out() end)

vim.keymap.set('n', '<leader>?', function()
    require('dapui').eval(nil, { enter = true })
end)

vim.keymap.set({'n', 'v'}, '<Leader>dh', function()
      require('dap.ui.widgets').hover()
    end)

-- Automatically open and close dap-ui
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
