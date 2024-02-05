return {
    -- Commenting utility
    {
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup()
        end
    },

    -- Kanagawa color scheme (currently not in use)
    {
        "rebelot/kanagawa.nvim",
        priority = 1000,
        config = function()
            -- vim.cmd("colorscheme kanagawa") -- Uncomment to use Kanagawa theme
        end
    },

    -- Lualine status line
    {
        'nvim-lualine/lualine.nvim',
        dependencies = {
            "nvim-tree/nvim-web-devicons"
        },
        config = function()
            require("lualine").setup({
                icons_enabled = true,
                theme = 'kanagawa', -- Change to 'catppuccin' to match your theme
            })
        end,
    },

    -- Mason for managing LSP, DAP, linters, and formatters
    {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
		'folke/neodev.nvim'
    },

    -- Autocompletion setup
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
            'rafamadriz/friendly-snippets',
            'hrsh7th/cmp-nvim-lsp',
        },
    },

    -- Treesitter context for enhanced syntax highlighting
    {
        "nvim-treesitter/nvim-treesitter-context",
        config = function()
            require('treesitter-context').setup{}
            -- Keymap for context navigation
            vim.keymap.set("n", "<leader>c", function()
                require("treesitter-context").go_to_context()
            end, { silent = true, desc = "Go to context using treesitter-context" })
        end
    },

	-- nvim-treesitter-textobjects: Enhances text object selection, Movement and swapping based on syntax
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		requires = {"nvim-treesitter/nvim-treesitter"},
		config = function()
			require('nvim-treesitter.configs').setup({
				textobjects = {
					-- Here you can define your text objects as per the plugins doc's
				},
			})
		end
		},

    -- Telescope for fuzzy finding
    {
        'nvim-telescope/telescope.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },

    -- Git integration with vim-fugitive
    {
        "tpope/vim-fugitive",
        config = function()
            vim.keymap.set("n", "<leader>gs", ":Git<CR>", { silent = true, desc = "Open Git status window" })
        end
    },

    -- FZF native extension for Telescope
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
    },

    -- Harpoon for quick file navigation
    {
        "ThePrimeagen/harpoon"
    },

    -- Vim-be-good for practicing Vim
    {
        "ThePrimeagen/vim-be-good"
    },

    -- TypeScript utilities for Neovim
    {
        "jose-elias-alvarez/nvim-lsp-ts-utils",
        after = "nvim-lspconfig",
    },

    -- Treesitter for syntax highlighting
    {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
    },

    -- Null-ls for integrating with linters and formatters
    {
        "jose-elias-alvarez/null-ls.nvim",
        after = "nvim-lspconfig",
    },

    -- Autopairs for automatic closing of brackets and quotes
    {
        "windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require('nvim-autopairs').setup({
				check_ts = true,
				ts_config = {
					lua = {'string'},
					javascript = {'template_string'},
					java = false,
				},
				disable_filetype = { "TelescopePrompt", 'vim'},
				fast_wrap = {
						map = '<M-e>',
						chars = { '{', '[', '(', '"', "'" },
						pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], '%s+', ''),
						offset = 0,  -- Offset from pattern match
						end_key = '$',
						keys = 'qwertyuiopzxcvbnmasdfghjkl',
						check_comma = true,
						highlight = 'PmenuSel',
						highlight_grey = 'LineNr',
				},
		})
		-- 
		local cmp_autopairs = require('nvim-autopairs.completion.cmp')
		local cmp = require('cmp')
		cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done({ map_char = { tex = '' } }))
		end
    },

    -- UndoTree for visualizing undo history
    {
        "mbbill/undotree",
        cmd = "UndotreeToggle",
    },

    -- Vim-tmux-navigator for seamless navigation between tmux and Vim
    {
        "christoomey/vim-tmux-navigator"
    },

    -- NERDTree for file exploration
    {
        "preservim/nerdtree",
    },
	{
	"jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    config = function()
      require("chatgpt").setup()
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim"
	},


}
:
