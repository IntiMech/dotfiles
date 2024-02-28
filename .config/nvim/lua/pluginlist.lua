return {
{
    "numToStr/Comment.nvim",
    config = function()
        require('Comment').setup()
    end,
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
},
{
    "onsails/lspkind.nvim",
    config = function()
        require('lspkind').init({
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
    end,
},
{
    "neovim/nvim-lspconfig",
    config = function()
        vim.cmd('source ~/.config/nvim/plugin/lsp.lua')
    end,
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
},
{
    "rafamadriz/friendly-snippets",
    after = "LuaSnip",  -- Load after LuaSnip
},
{
    "hrsh7th/cmp-nvim-lsp",
    after = "nvim-cmp",  -- Load after nvim-cmp
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
  end,
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
},
{
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require('lualine').setup{
            options = { theme = 'auto' },
        }
    end,
},
{
    "nvim-treesitter/nvim-treesitter-context",
    config = function()
        require('treesitter-context').setup{}
    end,
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

-- {
--     "mfussenegger/nvim-lint",
--     config = function()
--         require('lint').linters_by_ft = {
--             python = {'flake8'},  -- Example for Python, configure as needed
--             -- Add other filetypes and their linters here
--         }
--     end,
-- },

{
    "sheerun/vim-polyglot",
    -- Additional configuration options can be added
},
{
    "github/copilot.vim"
},
{
    "xiyaowong/transparent.nvim",
},

{
    "kkoomen/vim-doge",
    config = function()
    end,
},
{
    "epwalsh/obsidian.nvim",
    version = "*",  -- recommended, use latest release instead of latest commit
    lazy = false,
    ft = "markdown",
    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",
    },
    opts = {
      workspaces = {
        {
          name = "ZacsValut",
          path = "~/Obsidian/ZacsVault",
        },
      },
      completion = {
        nvim_cmp = true,
        min_chars = 2,
        new_note_location = "current_dir",
      },
    mappings = {
    -- "Obsidian follow"
    ["<leader>of"] = {
      action = function()
        return require("obsidian").util.gf_passthrough()
      end,
      opts = { noremap = false, expr = true, buffer = true },
    },
    -- Toggle check-boxes "obsidian done"
    ["<leader>od"] = {
      action = function()
        return require("obsidian").util.toggle_checkbox()
      end,
      opts = { buffer = true },
    },
      },
      }
},
{
    "folke/noice.nvim",
    event = "VeryLazy",
    config = function()
        require("noice").setup({
            cmdline = {
                enabled = true,
                view = "cmdline_popup",  -- Use a fancy cmdline popup
                opts = {},
                format = {
                },
            },
            messages = {
                enabled = true,
                view = "notify",  -- Default view for messages
                opts = {
                    timeout = 5000,  -- Duration in milliseconds for notifications
                },
            },
            popupmenu = {
                enabled = true,
                backend = "nui",  -- Backend to use for regular cmdline completions
            },
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
        })
        vim.keymap.set("n", "<leader>nh", ":Noice<CR>", { silent = true, noremap = true })
    end,
},
}
