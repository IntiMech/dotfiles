local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Function to setup LSP keymaps and options
local function set_global_lsp_keymaps()
    local opts = { noremap=true, silent=true }
    vim.api.nvim_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    vim.api.nvim_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.api.nvim_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    vim.api.nvim_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
end

-- Configure Pyright as the Python language server
lspconfig.pyright.setup({
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        print("Pyright is now active.")
    end,
    settings = {
        python = {
            analysis = {
                typeCheckingMode = "strict",  -- Can be "off", "basic", or "strict"
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "workspace",
            }
        }
    }
})
-- Configure JDTLS as the Java language server
lspconfig.jdtls.setup({
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        print("JDTLS is now active.")
        set_global_lsp_keymaps()
    end,
    root_dir = function(fname)
        return lspconfig.util.root_pattern('.git', 'mvnw', 'gradlew')(fname) or lspconfig.util.path.dirname(fname)
    end,
    settings = {
        java = {
            signatureHelp = { enabled = true },
            contentProvider = { preferred = 'fernflower' },
            completion = {
                favoriteStaticMembers = {
                    "org.hamcrest.MatcherAssert.assertThat",
                    "org.hamcrest.Matchers.*",
                    "org.hamcrest.CoreMatchers.*",
                    "org.junit.jupiter.api.Assertions.*",
                    "java.util.Objects.requireNonNull",
                    "java.util.Objects.requireNonNullElse",
                },
            },
        },
    }
})

-- Call the function to set global keymaps
set_global_lsp_keymaps()
