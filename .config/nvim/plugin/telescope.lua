
-- Set up Telescope with additional settings
require('telescope').setup({
    extensions = {
        fzf = {
            fuzzy = true,                    -- Enable fuzzy finding
            override_generic_sorter = true,  -- Override the generic sorter
            override_file_sorter = true,     -- Override the file sorter
            case_mode = "smart_case",        -- Smart case searching
        }
    }
})

-- Load Telescope extensions, such as fzf integration
require('telescope').load_extension('fzf')
