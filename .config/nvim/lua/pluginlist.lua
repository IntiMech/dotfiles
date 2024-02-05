return {

{
    "numToStr/Comment.nvim",
    config = function()
        require('Comment').setup()
    end,
    -- Lazy loading triggers can be added if needed
},

{
        "tiagovla/tokyodark.nvim",
        config = function ()
            vim.cmd("colorscheme tokyodark")
        end,
},

{
    "williamboman/mason.nvim",
    config = function()
        require("mason").setup()
    end,
    -- Additional configuration options can be added
},

{
    "onsails/lspkind.nvim",
    config = function()
        require('lspkind').init({
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        })
    end,
},

{
    "williamboman/mason-lspconfig.nvim",
    after = "mason.nvim",  -- Load after mason.nvim
    config = function()
        require("mason-lspconfig").setup()
    end,
},

{
    "L3MON4D3/LuaSnip",
    config = function()
        require("luasnip").setup()
        -- Add any LuaSnip specific configurations here if needed
    end,
    -- You can add conditions for lazy loading if necessary
},

{
    "neovim/nvim-lspconfig",
    config = function()
        vim.cmd('source ~/.config/nvim/plugin/lsp.lua')
    end,
    -- Add lazy loading conditions if needed
},

{
    'folke/neodev.nvim',
    after = "nvim-lspconfig",  -- Load after nvim-lspconfig
    config = function()
        require('neodev').setup()
    end,
},

{
    "saadparwaiz1/cmp_luasnip",
    after = "nvim-cmp",  -- Load after nvim-cmp
    -- No specific config function required unless you have custom settings
},

{
    "rafamadriz/friendly-snippets",
    after = "LuaSnip",  -- Load after LuaSnip
    -- This plugin typically doesn't require a config function
},


{
    "hrsh7th/cmp-nvim-lsp",
    after = "nvim-cmp",  -- Load after nvim-cmp
    -- No specific config function required unless you have custom settings
},


{
  "hrsh7th/cmp-cmdline",
  config = function()
    local cmp = require('cmp')

    -- Set up completions for '/' search based on the current buffer
    cmp.setup.cmdline('/', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = 'buffer' }
      }
    })

    -- Set up completions for ':' command mode
    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = 'path' }
      }, {
        {
          name = 'cmdline',
          option = {
            ignore_cmds = { 'Man', '!' }
          }
        }
      })
    })
  end
},

{
    'hrsh7th/nvim-cmp',
    requires = {
        'L3MON4D3/LuaSnip',
        'saadparwaiz1/cmp_luasnip',
        'rafamadriz/friendly-snippets',
        'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
        vim.cmd('source ~/.config/nvim/plugin/cmp.lua')
    end,
},

{
    "windwp/nvim-autopairs",
    event = "InsertEnter",  -- Lazy load on insert enter
    config = function()
        require('nvim-autopairs').setup({
            -- Configuration options here
        })
    end,
},


{
    "nvim-telescope/telescope.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
        vim.cmd('source ~/.config/nvim/plugin/telescope.lua')
    end,
},

{
    "nvim-telescope/telescope-fzf-native.nvim",
    run = "make",  -- This plugin requires a build step
    after = "telescope.nvim",  -- Load after Telescope
    config = function()
        require('telescope').load_extension('fzf')
    end,
},

{
    "ThePrimeagen/harpoon",
    config = function()
        require("harpoon")
    end,

},

{
    "christoomey/vim-tmux-navigator",
    -- This plugin might not require specific Lua configuration
    -- If you have specific keybindings or settings, configure them here
},

{
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require('lualine').setup{
            -- Add your Lualine configuration here
            options = { theme = 'auto' },
            -- Other configuration settings...
        }
    end,
    -- Lazy loading triggers can be added if needed
},

{
    "nvim-treesitter/nvim-treesitter-context",
    config = function()
        require('treesitter-context').setup{
            -- Add your Treesitter Context configuration here
        }
    end,
    -- Specify lazy loading conditions if needed
},

{
    "nvim-treesitter/nvim-treesitter-textobjects",
    requires = {"nvim-treesitter/nvim-treesitter"},
    config = function()
		vim.cmd('source ~/.config/nvim/plugin/treesitter.lua')
    end,
},

{
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = function()
        vim.cmd('source ~/.config/nvim/plugin/treesitter.lua')
    end,
},




{
    "mbbill/undotree",
    cmd = "UndotreeToggle",
    -- This plugin is triggered with the UndotreeToggle command
    -- Additional configuration can be added if needed
},

{
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",  -- Lazy load on a custom event, you can adjust this as needed
    config = function()
        require("chatgpt")
    end,
    dependencies = {
        "MunifTanjim/nui.nvim",
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim"
    },
},

{
    "tpope/vim-fugitive",
    config = function()
        -- Assuming your custom config file for vim-fugitive is named 'fugitive-config.lua'
        -- and is located in the 'plugin' directory of your Neovim config
        vim.cmd('source ~/.config/nvim/plugin/fugitive.lua')
    end,
},
     -- New Pluggins that I am testing.

{
    "vim-python/python-syntax",
    -- Additional configuration options can be added
},

{
    "tpope/vim-rhubarb",
    -- vim-rhubarb works alongside vim-fugitive, so no separate config is needed
},

{
    "mfussenegger/nvim-lint",
    config = function()
        require('lint').linters_by_ft = {
            python = {'flake8'},  -- Example for Python, configure as needed
            -- Add other filetypes and their linters here
        }
    end,
},

{
    "sheerun/vim-polyglot",
    -- Additional configuration options can be added
},
    {
        "github/copilot.vim"
    },

{
    "kkoomen/vim-doge",
    config = function()
        -- Optional: Configuration for vim-doge
    end,
},


{
    "folke/noice.nvim",
    event = "VeryLazy",
    config = function()
        -- Directly include the configuration settings here
        require("noice").setup({
            -- Command line configuration
            cmdline = {
                enabled = true,
                view = "cmdline_popup",  -- Use a fancy cmdline popup
                opts = {},
                format = {
                    -- Your format configurations...
                },
            },
            -- Messages configuration
            messages = {
                enabled = true,
                view = "notify",  -- Default view for messages
                opts = {
                    timeout = 5000,  -- Duration in milliseconds for notifications
                },
            },
            -- Popup menu configuration
            popupmenu = {
                enabled = true,
                backend = "nui",  -- Backend to use for regular cmdline completions
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
    end,
},
}
