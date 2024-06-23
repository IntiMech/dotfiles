local cmp = require('cmp')
local luasnip = require('luasnip')

require("luasnip.loaders.from_vscode").load()  -- Using .load() to ensure snippets are loaded immediately

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        -- Remove '<Tab>' binding
        -- Remove '<S-Tab>' binding

        -- Reassign snippet expansion to '<S-Enter>'
        ['<S-CR>'] = cmp.mapping(function(fallback)
            if luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, {'i', 's'}),

        ['<CR>'] = cmp.mapping.confirm({ select = true }),  -- Confirm the selected completion
    }),
    sources = cmp.config.sources({
        { name = 'luasnip', option = { show_autosnippets = true } },  -- Enabling autosnippets
        { name = 'nvim_lsp' },
        { name = 'buffer' },
        { name = 'path' },
    })
})
-- Setup vim-dadbod
cmp.setup.filetype({ "sql" }, {
    sources = {
        { name = "vim-dadbod-completion" },
        { name = "buffer" },
    },
})
