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
                ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "python", "markdown", "bash", "csv", "dockerfile", "json" },

                auto_install = true,

                highlight = {
                    enable = true,
                },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "<Leader>ss",
                        node_incremental = "<Leader>si",
                        node_decremental = "<Leader>sd",
                    },
                },
                textobjexts = {
                    select = {
                        enable = true,
                        lookahead = true,
                        keymaps = {
                            ["af"] = "@functoin.outter",
                            ["if"] = "@function.inner",
                            ["ac"] = "@class.outter",
                            ["ic"] = { query = "class.inner", desc = "Select inner part of a class region" },

                        },
                        selection_modes = {
                            ["@parameter.outer"] = "v",
                            ["@function.outer"] = "v",
                            ["@class.outer"] = "<c-v>",
                        },
                        include_surrounding_whitespace = true,
                    },
                },
            })
        end
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
        "nvim-treesitter/nvim-treesitter-textobjects",
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
        "nvim-lua/plenary.nvim",
    },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        config = function()
            require("plugins.noice")
        end,
    },
    {
        "nvim-telescope/telescope.nvim",
        requires = { "nvim-lua/plenary.nvim" },
        config = function()
            require("plugins.telescope")
        end,
    },

    {
        "christoomey/vim-tmux-navigator",
    },

})
