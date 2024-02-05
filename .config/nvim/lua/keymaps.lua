-- Set space as the leader key
vim.g.mapleader = " "

-- Move selected lines down in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true })

-- Move selected lines up in visual mode
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true })

-- Join lines without moving the cursor
vim.keymap.set("n", "J", "mzJ`z", { silent = true })

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

-- Exit insert mode with Ctrl-c (not recommended as it doesn't trigger InsertLeave events)
vim.keymap.set("i", "<C-c>", "<Esc>")

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


vim.api.nvim_set_keymap('i', '<C-Tab>', '<Plug>(copilot-accept)', {})

-- Use Telescope Live Grep to find files.
vim.keymap.set("n", "<leader>g", ":Telescope live_grep<CR>", { silent = true })

-- Telescope Keybindings
vim.keymap.set('n', '<leader>p', ":Telescope find_files<CR>", { silent = true })
vim.keymap.set('n', '<C-p>', function()
    local opts = {} -- Define here if you want to define something
    local ok, _ = pcall(require('telescope.builtin').git_files, opts)
    if not ok then
        require('telescope.builtin').find_files(opts)
    end
end, { silent = true })

vim.keymap.set('n', '<C-gs>', function()
    require('telescope.builtin').grep_string({ search = vim.fn.input("Grep > ") })
end, { silent = true })


vim.keymap.set('n', '<leader>vh', require('telescope.builtin').help_tags, { silent = true })

-- Double tap leader to source the current file
vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so %")
end)

-- Fugitive Keybindings
vim.keymap.set("n", "<leader>", ":Git<CR>", { silent = true })

-- Set up buffer-local keybindings for fugitive buffers
local function set_fugitive_keymaps()
    if vim.bo.filetype ~= "fugitive" then
        return
    end

    local bufnr = vim.api.nvim_get_current_buf()
    local opts = {buffer = bufnr, silent = true}

    vim.keymap.set("n", "<leader>", ":Git push<CR>", opts)
    vim.keymap.set("n", "<leader>", ":Git pull --rebase<CR>", opts)
    vim.keymap.set("n", "<leader>T", ":Git push -u origin ", opts)
end

-- Create an augroup for Fugitive-related autocmds
local IntiMech_Fugitive = vim.api.nvim_create_augroup("IntiMech_Fugitive", {})

-- Define autocmd to set keymaps when entering a buffer with 'fugitive' filetype
vim.api.nvim_create_autocmd("BufWinEnter", {
    group = IntiMech_Fugitive,
    pattern = "*",
    callback = set_fugitive_keymaps,
})


