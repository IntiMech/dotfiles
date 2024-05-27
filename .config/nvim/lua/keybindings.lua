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

-- Make the current file executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- Require the necessary Telescope modules
local builtin = require('telescope.builtin')

-- Telescope Keybindings
vim.keymap.set('n', '<leader>ff', ":Telescope find_files<CR>", { silent = true })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Search for a string in the workspace using Ripgrep" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find Help Tags" })
vim.keymap.set('n', '<leader>ft', '<cmd>Telescope tags<CR>', {noremap = true, silent = true})
vim.keymap.set("n", "<leader>fs", builtin.lsp_document_symbols, { desc = "Find Symbols" })
vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "Find Word under Cursor" })
vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "Find Keymaps" })
vim.keymap.set("n", "<leader>/", function()
      -- You can pass additional configuration to telescope to change theme, layout, etc.
      require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
        winblend = 10,
        previewer = false,
        layout_config = { width = 0.7 },
      }))
    end, { desc = "[/] Fuzzily search in current buffer" })
