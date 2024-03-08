local nvim_lsp = require('lspconfig')
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local on_attach = function(client, bufnr)
    -- Existing on_attach code...
    local bufmap = function(keys, func)
        vim.keymap.set('n', keys, func, { buffer = bufnr })
    end

    bufmap('<leader>r', vim.lsp.buf.rename)
    bufmap('<leader>a', vim.lsp.buf.code_action)
    bufmap('gd', vim.lsp.buf.definition)
    bufmap('gD', vim.lsp.buf.declaration)
    bufmap('gI', vim.lsp.buf.implementation)
    bufmap('<leader>D', vim.lsp.buf.type_definition)
    bufmap('gr', require('telescope.builtin').lsp_references)
    bufmap('<leader>s', require('telescope.builtin').lsp_document_symbols)
    bufmap('<leader>S', require('telescope.builtin').lsp_dynamic_workspace_symbols)
    bufmap('K', vim.lsp.buf.hover)
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function()
        vim.lsp.buf.formatting()
    end, {})

    if client.name == "tsserver" then
        client.resolved_capabilities.document_formatting = false
        local ts_utils = require("nvim-lsp-ts-utils")
        ts_utils.setup({ })
        ts_utils.setup_client(client)
    end
end

require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "tsserver", "pyright",  "lua_ls" },
    automatic_installation = true,
})

-- LSP handlers setup, now without the unnecessary existential crisis of deno.
require("mason-lspconfig").setup_handlers({
    -- tsserver configuration, assuming deno.json files are as mythical as a good day without debugging
    ["tsserver"] = function()
        require('lspconfig')['tsserver'].setup({
            on_attach = on_attach,
            capabilities = capabilities,
            root_dir = require('lspconfig.util').root_pattern("package.json"), -- because why not?
            single_file_support = false -- because who edits a single file these days?
        })
    end,
    -- lua_ls configuration, let's pretend we understand Lua deeply
    ["lua_ls"] = function()
        require('neodev').setup() -- because Lua development without neodev is like pizza without cheese
        require('lspconfig')['lua_ls'].setup({
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
                Lua = {
                    workspace = { checkThirdParty = false }, -- third-party? never heard of them
                    telemetry = { enable = false }, -- because who wants to share their secrets?
                },
            },
        })
    end,
    -- pyright, because Python scripts are just too mainstream without type checking
    ["pyright"] = function()
        require('lspconfig')['pyright'].setup({
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
                python = {
                    analysis = {
                        autoSearchPaths = true,
                        diagnosticMode = "workspace", -- because we love seeing all our mistakes at once
                        useLibraryCodeForTypes = true,
                        typeCheckingMode = "off", -- because who needs type safety?
                    }
                }
            }
        })
    end,
    -- Here you could add more LSP configurations as needed, because the more the merrier, right?
})

-- And there you have it, a beautifully crafted piece of modern art.
