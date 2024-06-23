local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  {
        "nvim-treesitter/nvim-treesitter",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "python", "markdown", "markdown_inline", "bash", "csv", "dockerfile", "json" },

                auto_install = true,

                indent = {
                    enable = true,
                },

                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,  -- Ensure markdown highlighting
                },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "<Leader>ss",
                        node_incremental = "<Leader>si",
                        node_decremental = "<Leader>sd",
                    },
                },
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true,
                        keymaps = {
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["ac"] = "@class.outer",
                            ["ic"] = { query = "class.inner", desc = "Select inner part of a class region" },

                        },
                        selection_modes = {
                            ["@parameter.outer"] = "v",
                            ["@function.outer"] = "v",
                            ["@class.outer"] = "<c-v>",
                        },
                        include_surrounding_whitespace = false,
                    },
                },
                refactor = {
                highlight_definitions = {
                  enable = true,
                  -- Set to false if you have an `updatetime` of ~100.
                  clear_on_cursor_move = true,
                },
              },
            })
            -- Set conceallevel for Markdown files
            vim.api.nvim_create_autocmd("FileType", {
                pattern = "markdown",
                callback = function()
                    vim.opt_local.conceallevel = 2
                end,
        })
        end,
    },
    {
        "nvim-lua/plenary.nvim",
    },
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
          "ThePrimeagen/harpoon",
          "nvim-lua/plenary.nvim",
          "joshmedeski/telescope-smart-goto.nvim",
        },
        config = function()
          require("plugins.telescope")
        end,
    },
    {
        "rebelot/kanagawa.nvim",
        config = function()
            vim.cmd.colorscheme("kanagawa-dragon")
        end,
    },
    {
        "MunifTanjim/nui.nvim"
    },
    {
        "nvim-treesitter/nvim-treesitter-refactor",
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
    },
    {
        "rafamadriz/friendly-snippets",
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
        end,
    },
    {
        "L3MON4D3/LuaSnip",
        dependencies = { "rafamadriz/friendly-snippets" },
        version = "v2.*",
        run = "make install_jsregexp"  -- Compiles the jsregexp component required for certain snippets
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            require("plugins.lsp")
        end,
    },
    {
        "hrsh7th/cmp-nvim-lsp"
    },
    {
        "hrsh7th/nvim-cmp",
        config = function()
            require("plugins.completions")
        end,
    },
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "mason.nvim" },
        config = function()
            require("mason-lspconfig").setup()
            require("mason-lspconfig").setup_handlers({
                function(server_name)
                    require("lspconfig")[server_name].setup({})
                end,
            })
        end,
    },
    {
        "ThePrimeagen/harpoon",
        config = function()
            require("plugins.harpoon")
        end,
    },
    {
        "folke/noice.nvim",
        -- event = "VeryLazy",
        config = function()
            require("plugins.noice")
        end,
    },
    -- {
    --     "nvim-telescope/telescope.nvim",
    --     dependencies = { "nvim-lua/plenary.nvim" },
    --     config = function()
    --         require("plugins.telescope")
    --     end,
    -- },

    {
        "christoomey/vim-tmux-navigator",
    },
    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "sindrets/diffview.nvim",
            "nvim-telescope/telescope.nvim",
        },
        config = function()
            require("plugins.neogit")
        end,
    },
    {
        "nvim-tree/nvim-web-devicons"
    },
    {
    "folke/trouble.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("plugins.trouble").setup()
    end,
    },
    {
      "nvim-neotest/neotest",
      dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter",
        "nvim-neotest/neotest-python",
        "nvim-neotest/neotest-plenary",
        "folke/trouble.nvim",
        "folke/neodev.nvim"
      },
      config = function()
        require("plugins.neotest").setup()
    end,
    },
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "theHamsta/nvim-dap-virtual-text",
        },
        config = function ()
            require("plugins.dap")
        end,
    },
    {
        "linux-cultist/venv-selector.nvim",
        branch = "regexp",
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "neovim/nvim-lspconfig",
            "mfussenegger/nvim-dap-python"
         },
         config = function()
            require("plugins.venv-selector")
         end,
    },
    {
        "tpope/vim-dadbod",
        dependencies = {
            "kristijanhusak/vim-dadbod-ui",
            "kristijanhusak/vim-dadbod-completion"
        },
        config = function ()
           require ("plugins.dadbod")
        end,
    },
    {
        "preservim/tagbar",
        config = function()
            -- Set keybinding for Tagbar
            vim.keymap.set('n', '<leader>tb', ':TagbarToggle<CR>', {silent = true, noremap = true})
        end,
    },
    {
        "Exafunction/codeium.vim",
        config = function ()
            vim.keymap.set("i", "<C-g>", function () return vim.fn['codeium#Accept']() end, { expr = true, silent = true })
            vim.keymap.set("i", "<C-;>", function () return vim.fn['codeium#CycleCompletions'](1) end, { expr = true, silent = true })
            vim.keymap.set("i", "<C-,>", function () return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true, silent = true })
            vim.keymap.set("i", "<C-x>", function () return vim.fn['codeium#Clear']() end, { expr = true, silent = true })

        end,
    },
    {
        "AckslD/nvim-neoclip.lua",
        dependencies = {
        "kkharji/sqlite.lua",
        "nvim-telescope/telescope.nvim",
        },
        config = function()
            require('plugins.neoclip')
        end,
    },
    {
        "ggandor/leap.nvim",
        config = function()
            local leap = require("leap")
            leap.add_default_mappings()
            leap.opts.case_sensitive = true
        end,
    },
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("plugins.gitsigns")
        end,
    },
    {
        "xiyaowong/telescope-emoji.nvim"
    },
    {
        "epwalsh/obsidian.nvim",
        version = "*",
        lazy = true,
        ft = "markdown",
        dependencies = {
            "nvim-lua/plenary.nvim"
        },
        config = function()
            require("plugins.obsidian")  -- Keep your custom config file
        end,
    },



})
