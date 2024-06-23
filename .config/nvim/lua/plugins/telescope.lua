return function()
  local telescope = require("telescope")
  local keybindings = require("plugins.keybindings").setup_telescope_keybindings()

  telescope.setup({
    defaults = {
      mappings = keybindings,  -- Load the keybindings
    },
    pickers = {
      find_files = {
        find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
      },
      live_grep = {
        additional_args = function()
          return { "--hidden", "--glob", "!**/.git/*" }
        end
      },
    },
    extensions = {
      undo = {
        use_delta = true,
        side_by_side = false,
        diff_context_lines = vim.o.scrolloff,
        entry_format = "state #$ID, $STAT, $TIME",
        mappings = keybindings.i,  -- Include undo-specific keybindings
      },
    },
  })

  -- Load extensions
  local extensions = {
    "neoclip",
    "fzf",
    "ui-select",
    "undo",
    "advanced_git_search",
    "live_grep_args",
    "colors",
    "noice",
    "emoji"
  }
  for _, ext in ipairs(extensions) do
    telescope.load_extension(ext)
  end
end
