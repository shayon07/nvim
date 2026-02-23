-- Adding formatter configurations for LSP

local lspconfig = require('lspconfig')

local servers = { 'pyright', 'tsserver', 'gopls', 'rust_analyzer' }  -- Add other LSP servers here

for _, server in ipairs(servers) do
  lspconfig[server].setup {
    settings = {
      -- Formatter settings with indentation configurations
      editor = {
        format = {
          indent = {
            shiftwidth = 4,
            tabwidth = 4
          }
        }
      }
    },
    on_attach = function(client, bufnr)
      -- Set additional settings for each language server if necessary
    end,
  }
end

-- Add any additional languages to configure here
