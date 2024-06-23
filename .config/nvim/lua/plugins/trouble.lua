
-- plugins/trouble.lua
local M = {}

function M.setup()
    require("trouble").setup {
        position = "bottom", -- position of the list can be: bottom, top, left, right
        height = 30,         -- height of the trouble list when position is top or bottom
        width = 80,          -- width of the list when position is left or right
        icons = {
            error = "",
            warning = "",
            hint = "",
            information = "",
            other = "﫠"
        },                   -- use devicons for filenames
        mode = "workspace_diagnostics", -- or "document_diagnostics", "quickfix", etc.
        fold_open = "",     -- icon used for open folds
        fold_closed = "",   -- icon used for closed folds
        group = true,        -- group results by file
        padding = true,      -- add an extra new line on top of the list
        action_keys = {      -- key mappings for actions in the trouble list
            close = "q",       -- close the list
            refresh = "r",     -- manually refresh
            jump = {"<cr>", "<tab>"}, -- jump to the diagnostic or open/close folds
            toggle_mode = "m", -- toggle between workspace/document diagnostics
            toggle_preview = "P", -- toggle auto-preview
            hover = "K",       -- opens a small popup with the full multiline message
            preview = "p",     -- preview the diagnostic location
            previous = "k",    -- previous item
            next = "j"         -- next item
        },
        indent_lines = true, -- add an indent guide below the fold icons
        auto_open = false,   -- automatically open the list when you have diagnostics
        auto_close = false,  -- automatically close the list when you have no diagnostics
        auto_preview = true, -- automatically preview the diagnostic location
        auto_fold = false,   -- automatically fold a file trouble list at creation
        signs = {
            error = "",
            warning = "",
            hint = "",
            information = "",
            other = "﫠"
        },
        use_diagnostic_signs = false, -- enabling this will use the signs defined in your LSP client
        modes = {
            preview_float = {
                mode = "diagnostics",
                preview = {
                    type = "float",
                    relative = "editor",
                    border = "rounded",
                    title = "Preview",
                    title_pos = "center",
                    position = { 0, -2 },
                    size = { width = 0.5, height = 0.6 },
                    zindex = 200,
                },
            },
        },
    }

    -- Key mappings for Trouble
    vim.api.nvim_set_keymap("n", "<leader>cs", "<cmd>Trouble symbols toggle focus=true<cr>", { silent = true, noremap = true, desc = "Symbols (Trouble)" })
    vim.api.nvim_set_keymap("n", "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", { silent = true, noremap = true, desc = "LSP Definitions / references / ... (Trouble)" })
    vim.api.nvim_set_keymap("n", "<leader>xL", "<cmd>Trouble loclist toggle<cr>", { silent = true, noremap = true, desc = "Location List (Trouble)" })
    vim.api.nvim_set_keymap("n", "<leader>qf", "<cmd>Trouble qflist toggle<cr>", { silent = true, noremap = true, desc = "Quickfix List (Trouble)" })
    vim.api.nvim_set_keymap("n", "<leader>xx", "<cmd>Trouble preview_float focus=true<cr>", { silent = true, noremap = true, desc = "Floating Preview (Trouble)" })
end

return M
