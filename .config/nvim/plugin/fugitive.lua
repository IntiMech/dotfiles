
-- Create an augroup for Fugitive-related autocmds
local IntiMech_Fugitive = vim.api.nvim_create_augroup("IntiMech_Fugitive", {})

-- Define autocmd to set keymaps when entering a buffer with 'fugitive' filetype
vim.api.nvim_create_autocmd("BufWinEnter", {
    group = IntiMech_Fugitive,
    pattern = "*",
    callback = function()
        -- Only set these keymaps for fugitive buffers
        if vim.bo.filetype ~= "fugitive" then
            return
        end

        local bufnr = vim.api.nvim_get_current_buf()
        local opts = {buffer = bufnr, silent = true}

        -- The actual keybindings will be set in keymaps.lua
    end,
})
