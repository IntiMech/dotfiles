-- Require the necessary Telescope modules
local builtin = require('telescope.builtin')
local actions = require("telescope.actions")

-- Move selected lines down in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true })

-- Move selected lines up in visual mode
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true })

-- Move half-page down and recenter
vim.keymap.set("n", "<C-d>", "<C-d>zz")

-- Move half-page up and recenter
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Move to the next search result and recenter, with visual selection restored if present
vim.keymap.set("n", "n", "nzzzv")

-- Move to the previous search result and recenter, with visual selection restored if present
vim.keymap.set("n", "N", "Nzzzv")

-- Copy to clipboard in normal and visual mode
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])

-- Copy whole line to clipboard in normal mode
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Delete without changing the clipboard in normal and visual mode
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

-- Disable the 'Q' command in normal mode to enter Ex mode
vim.keymap.set("n", "Q", "<nop>")

-- Format the current buffer using LSP
vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { silent = true, noremap = true })

-- Jump to next and previous items in quickfix list with Ctrl-k and Ctrl-j
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")

-- Jump to next and previous items in location list with leader-k and leader-j
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- Substitute the word under cursor in the whole file
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])


local neogit = require('neogit')
-- Neogit Keybindings
vim.keymap.set("n", "<leader>ng", neogit.open, { silent = true, noremap = true })

-- Open Netrw file explorer with leader E
vim.keymap.set("n", "<leader>E", "<cmd>Ex<CR>", { silent = true, noremap = true })

-- Neotest Keybindings
local function setup_neotest_keybindings()
  local neotest = require("neotest")
  if not neotest or not neotest.run then
    print("Neotest is not loaded properly!")
    return
  end

  -- Define keybindings
  vim.keymap.set('n', '<Leader>tt', function() neotest.run.run(vim.fn.expand("%")) end, { silent = true, desc = "Run Neotest on current file" })
  vim.keymap.set('n', '<Leader>tT', function() neotest.run.run(vim.loop.cwd()) end, { silent = true, desc = "Run all Neotest files" })
  vim.keymap.set('n', '<Leader>tr', function() neotest.run.run() end, { silent = true, desc = "Run nearest Neotest" })
  vim.keymap.set('n', '<Leader>tl', function() neotest.run.run_last() end, { silent = true, desc = "Run last Neotest" })
  vim.keymap.set('n', '<Leader>ts', function() neotest.summary.toggle() end, { silent = true, desc = "Toggle Neotest summary" })
  vim.keymap.set('n', '<Leader>to', function() neotest.output.open({ enter = true, auto_close = true }) end, { silent = true, desc = "Open Neotest output" })
  vim.keymap.set('n', '<Leader>tO', function() neotest.output_panel.toggle() end, { silent = true, desc = "Toggle Neotest output panel" })
  vim.keymap.set('n', '<Leader>tS', function() neotest.run.stop() end, { silent = true, desc = "Stop Neotest run" })
end

-- Delay keybinding setup to ensure Neotest is fully loaded
vim.defer_fn(setup_neotest_keybindings, 100)  -- Adjust delay as needed



-- Telescope Keybindings
vim.keymap.set('n', '<leader>ff', ":Telescope find_files<CR>", { silent = true })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Search for a string in the workspace using Ripgrep" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find Help Tags" })
vim.keymap.set('n', '<leader>ft', '<cmd>Telescope tags<CR>', {noremap = true, silent = true})
vim.keymap.set("n", "<leader>fs", builtin.lsp_document_symbols, { desc = "Find Symbols" })
vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "Find Word under Cursor" })
vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "Find Keymaps" })
vim.keymap.set('n', '<leader>e', ":Telescope emoji<CR>", { noremap = true, silent = true, desc = "Open Emoji Picker" })
vim.keymap.set("n", "<leader>/", function()
      -- You can pass additional configuration to telescope to change theme, layout, etc.
      require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
        winblend = 10,
        previewer = true,
        layout_config = { width = 0.9 },
      }))
    end, { desc = "[/] Fuzzily search in current buffer" })

local function setup_telescope_keybindings()
  return {
    n = {
      ["<C-w>"] = actions.send_selected_to_qflist + actions.open_qflist,
    },
    i = {
      ["<C-j>"] = actions.cycle_history_next,
      ["<C-k>"] = actions.cycle_history_prev,
      ["<CR>"] = actions.select_default,
      ["<C-w>"] = actions.send_selected_to_qflist + actions.open_qflist,
      ["<C-S-d>"] = actions.delete_buffer,
      ["<C-s>"] = actions.cycle_previewers_next,
      ["<C-a>"] = actions.cycle_previewers_prev,
    },
  }
end

return {
  setup_telescope_keybindings = setup_telescope_keybindings
}
