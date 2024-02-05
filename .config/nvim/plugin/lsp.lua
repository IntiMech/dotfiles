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
    ensure_installed = { "tsserver", "pyright", "denols", "lua_ls" },
    automatic_installation = true,
})

require("mason-lspconfig").setup_handlers({
    ["denols"] = function()
        nvim_lsp.denols.setup({
            on_attach = on_attach,
            root_dir = nvim_lsp.util.root_pattern("deno.json", "deno.jsonc"),
        })
    end,
    ["tsserver"] = function()
        if vim.fn.glob("deno.json") == "" and vim.fn.glob("deno.jsonc") == "" then
            nvim_lsp.tsserver.setup({
                on_attach = on_attach,
                capabilities = capabilities,
                root_dir = nvim_lsp.util.root_pattern("package.json"),
                single_file_support = false
            })
        end
    end,
    ["lua_ls"] = function()
        require('neodev').setup()
        nvim_lsp.lua_ls.setup({
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
                Lua = {
                    workspace = { checkThirdParty = false },
                    telemetry = { enable = false },
                },
            },
        })
    end,
    ["pyright"] = function()
        require('lspconfig').pyright.setup({
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
                python = {
                    analysis = {
                        autoSearchPaths = true,
                        diagnosticMode = "workspace",
                        useLibraryCodeForTypes = true,
                        typeCheckingMode = "off",
                    }
                }
            }
        })
    end,
})
