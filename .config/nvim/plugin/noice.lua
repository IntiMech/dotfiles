-- noice-config.lua
-- Make sure to install 'noice.nvim' and its dependencies before using this configuration

-- Require and set up the 'noice.nvim' plugin
require("noice").setup({
    -- Command line configuration
    cmdline = {
        enabled = true,
        view = "cmdline_popup",  -- Use a fancy cmdline popup
        opts = {},
        format = {
            cmdline = { pattern = "^:", icon = "", lang = "vim" },
            search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
            search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
            filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
            lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "", lang = "lua" },
            help = { pattern = "^:%s*he?l?p?%s+", icon = "" },
            input = {},  -- Used by input()
        },
    },

    -- Messages configuration
    messages = {
        enabled = true,
        view = "notify",  -- Default view for messages
        view_error = "notify",  -- View for errors
        view_warn = "notify",  -- View for warnings
        view_history = "messages",  -- View for :messages
        view_search = "virtualtext",  -- View for search count messages
        opts = {
            timeout = 5000,  -- Duration in milliseconds for notifications
        },
    },

    -- Popup menu configuration
    popupmenu = {
        enabled = true,
        backend = "nui",  -- Backend to use for regular cmdline completions
        kind_icons = false,  -- Set to `false` to disable icons
    },

    -- LSP configuration
    lsp = {
        progress = {
            enabled = true,
            view = "mini",
        },
        hover = {
            enabled = true,
            silent = false,
            view = nil,
            opts = {},
        },
        signature = {
            enabled = true,
            view = nil,
            opts = {},
        },
        message = {
            enabled = true,
            view = "notify",
            opts = {},
        },
    },

    -- Additional configurations...
})

-- Optional: Add a keybinding to open the message history
vim.keymap.set("n", "<leader>nh", ":Noice<CR>", { silent = true, noremap = true })

