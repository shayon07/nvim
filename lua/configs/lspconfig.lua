-- ~/.config/nvim/lua/configs/lspconfig.lua

-- Helper for common on_attach
local function on_attach(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Set shiftwidth and tabstop to 4 spaces for ALL filetypes
  vim.api.nvim_buf_set_option(bufnr, "shiftwidth", 4)
  vim.api.nvim_buf_set_option(bufnr, "tabstop", 4)
  vim.api.nvim_buf_set_option(bufnr, "expandtab", true)

  -- LSP keymaps
  local opts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  
  -- Custom format function with 4-space settings
  if client.server_capabilities.documentFormattingProvider then
    vim.keymap.set("n", "<leader>f", function()
      vim.lsp.buf.format({
        bufnr = bufnr,
        formatting_options = {
          tabSize = 4,
          insertSpaces = true
        },
        async = false
      })
    end, opts)
  end
end

-- ===== C / C++ =====
vim.lsp.config("clangd", {
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--completion-style=detailed",
    "--header-insertion=iwyu"
  },
  filetypes = { "c", "cpp", "objc", "objcpp" },
  on_attach = on_attach,
  init_options = {
    clangdFileStatus = true
  }
})
vim.lsp.enable("clangd")

-- ===== Rust =====
vim.lsp.config("rust_analyzer", {
  cmd = { "rust-analyzer" },
  on_attach = on_attach,
  settings = {
    ["rust-analyzer"] = {
      cargo = { allFeatures = true },
      checkOnSave = {
        command = "clippy"
      },
      diagnostics = { enable = true }
    }
  }
})
vim.lsp.enable("rust_analyzer")

-- ===== Python =====
vim.lsp.config("pylsp", {
  cmd = { "pylsp" },
  filetypes = { "python" },
  on_attach = on_attach,
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = { enabled = true, maxLineLength = 100 },
        pyflakes = { enabled = true },
        mccabe = { enabled = true, threshold = 15 },
        yapf = { enabled = true },
        rope_completion = { enabled = true }
      }
    }
  }
})
vim.lsp.enable("pylsp")

-- ===== Bash =====
vim.lsp.config("bashls", {
  cmd = { "bash-language-server", "start" },
  filetypes = { "sh", "bash" },
  on_attach = on_attach
})
vim.lsp.enable("bashls")

-- ===== Docker =====
vim.lsp.config("dockerls", {
  cmd = { "docker-langserver", "--stdio" },
  filetypes = { "dockerfile" },
  on_attach = on_attach
})
vim.lsp.enable("dockerls")

-- ===== Nix =====
vim.lsp.config("nil_ls", {
  cmd = { "nil" },
  filetypes = { "nix" },
  on_attach = on_attach,
  settings = {
    nil = {
      formatting = {
        command = { "nixpkgs-fmt" }
      }
    }
  }
})
vim.lsp.enable("nil_ls")

-- Auto-format on save for all supported languages with 4-space settings
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.c", "*.cpp", "*.rs", "*.py", "*.sh", "*.dockerfile", "*.nix" },
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()
    local clients = vim.lsp.get_clients({ bufnr = bufnr })
    for _, client in ipairs(clients) do
      if client.server_capabilities.documentFormattingProvider then
        vim.lsp.buf.format({
          bufnr = bufnr,
          formatting_options = {
            tabSize = 4,
            insertSpaces = true
          },
          async = false
        })
        break
      end
    end
  end
})
