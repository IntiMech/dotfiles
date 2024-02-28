require('nvim-treesitter.configs').setup {
  -- List of parsers to install
  ensure_installed = { 'vim', 'lua', 'cpp', 'python', 'javascript', 'typescript', 'rust', 'bash', 'json' },

  -- Automatically install missing parsers when entering buffer
  auto_install = true,

  highlight = {
    enable = true,
  },

  -- Enable indentation based on treesitter
  indent = {
    enable = true,
  },

  -- Treesitter text objects
  textobjects = {
    select = {
      enable = true,

      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,

      keymaps = {
        -- Argument text objects
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        -- More text objects can be added here
      },
    },

    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]f"] = "@function.outer",
        ["]c"] = "@class.outer",
        -- More mappings can be added here
      },
      goto_next_end = {
        ["]F"] = "@function.outer",
        ["]C"] = "@class.outer",
        -- More mappings can be added here
      },
      goto_previous_start = {
        ["[f"] = "@function.outer",
        ["[c"] = "@class.outer",
        -- More mappings can be added here
      },
      goto_previous_end = {
        ["[F"] = "@function.outer",
        ["[C"] = "@class.outer",
        -- More mappings can be added here
      },
    },
  },
}

