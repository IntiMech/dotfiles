require('venv-selector').setup({
  search = true, -- Enable searching for virtual environments
  auto_refresh = true, -- Automatically refresh the list of virtual environments
  search_workspace = true, -- Search for virtual environments within the current workspace
  dap_enabled = true, -- Integrate with nvim-dap to use the selected virtual environment
  parents = 2, -- Number of parent directories to search upwards before searching for virtual environments
  name = {"venv", ".venv"}, -- Names of directories to look for virtual environments
  notify_user_on_activate = true, -- Notify when a virtual environment is activated
  keys = {
    {'<leader>vs', '<cmd>VenvSelect<cr>'}, -- Keymap to open VenvSelector to pick a venv
    {'<leader>vc', '<cmd>VenvSelectCached<cr>'} -- Keymap to retrieve the venv from a cache
  }
})
