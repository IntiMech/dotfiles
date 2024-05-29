
return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.4",
  dependencies = {
    "ThePrimeagen/harpoon",
    "nvim-lua/plenary.nvim",
    "joshmedeski/telescope-smart-goto.nvim",
  },
  config = function()
    -- Load keybindings
    require("plugins.keybindings")

    local telescope = require("telescope")
    local actions = require("telescope.actions")

    local select_one_or_multi = function(prompt_bufnr)
      local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
      local multi = picker:get_multi_selection()
      if not vim.tbl_isempty(multi) then
        require("telescope.actions").close(prompt_bufnr)
        for _, j in pairs(multi) do
          if j.path ~= nil then
            vim.cmd(string.format("%s %s", "edit", j.path))
          end
        end
      else
        require("telescope.actions").select_default(prompt_bufnr)
      end
    end

    telescope.setup({
      defaults = {
        path_display = { "truncate" },
        mappings = {
          n = {
            ["<C-w>"] = actions.send_selected_to_qflist + actions.open_qflist,
          },
          i = {
            ["<C-j>"] = actions.cycle_history_next,
            ["<C-k>"] = actions.cycle_history_prev,
            ["<CR>"] = select_one_or_multi,
            ["<C-w>"] = actions.send_selected_to_qflist + actions.open_qflist,
            ["<C-S-d>"] = actions.delete_buffer,
            ["<C-s>"] = actions.cycle_previewers_next,
            ["<C-a>"] = actions.cycle_previewers_prev,
          },
        },
      },
      pickers = {
        find_files = {
          find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
        },
        live_grep = {
          -- Additional Ripgrep arguments for live_grep
          additional_args = function()
            return {"--hidden", "--glob", "!**/.git/*"}
          end
        },
      },
      extensions = {
        undo = {
          use_delta = true,
          use_custom_command = nil, -- setting this implies `use_delta = false`
          side_by_side = false,
          diff_context_lines = vim.o.scrolloff,
          entry_format = "state #$ID, $STAT, $TIME",
          mappings = {
            i = {
              ["<C-cr>"] = require("telescope-undo.actions").yank_additions,
              ["<S-cr>"] = require("telescope-undo.actions").yank_deletions,
              ["<cr>"] = require("telescope-undo.actions").restore,
            },
          },
        },
      },
    })

    require("telescope").load_extension("neoclip")
    require("telescope").load_extension("fzf")
    require("telescope").load_extension("ui-select")
    vim.g.zoxide_use_select = true
    require("telescope").load_extension("undo")
    require("telescope").load_extension("advanced_git_search")
    require("telescope").load_extension("live_grep_args")
    require("telescope").load_extension("colors")
    require("telescope").load_extension("noice")
  end,
}