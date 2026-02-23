-- ~/.config/nvim/lua/configs/lspconfig.lua

-- Helper for common on_attach
local function on_attach(client, bufnr)
  -- Enable completion
  if client.server_capabilities.document_formatting then
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
  end

  -- Set shiftwidth and tabstop for all filetypes
  vim.api.nvim_buf_set_option(bufnr, "shiftwidth", 4)
  vim.api.nvim_buf_set_option(bufnr, "tabstop", 4)
  vim.api.nvim_buf_set_option(bufnr, "expandtab", true)  -- Use spaces instead of tabs

  -- Keymaps for LSP
  local opts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, opts)
end

-- ===== C / C++ =====
vim.lsp.config("clangd", {
  cmd = {
    "clangd",
    "--background-index",       -- speed up code indexing
    "--clang-tidy",             -- enable clang-tidy diagnostics
    "--completion-style=detailed",
    "--header-insertion=iwyu"   -- insert includes where used
  },
  filetypes = { "c", "cpp", "objc", "objcpp" },
  on_attach = on_attach,
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
      diagnostics = { enable = true },
    }
  }
})
vim.lsp.enable("rust_analyzer")

-- ===== Python =====
vim.lsp.config("pylsp", {  -- python-lsp-server
  cmd = { "pylsp" },
  filetypes = { "python" },
  on_attach = on_attach,
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = { enabled = true, maxLineLength = 100 },
        pyflakes = { enabled = true },
        mccabe = { enabled = true, threshold = 15 },
        yapf = { enabled = true },         -- autoformat
        rope_completion = { enabled = true }, -- smart completions
      },
    },
  },
})
vim.lsp.enable("pylsp")

-- ===== Bash =====
vim.lsp.config("bashls", {
  cmd = { "bash-language-server", "start" },
  filetypes = { "sh", "bash" },
  on_attach = on_attach,
})
vim.lsp.enable("bashls")

-- ===== Docker =====
vim.lsp.config("dockerls", {
  cmd = { "docker-langserver", "--stdio" },
  filetypes = { "dockerfile" },
  on_attach = on_attach,
})
vim.lsp.enable("dockerls")

-- ===== Nix =====
vim.lsp.config("nil_ls", {
  cmd = { "nil" },
  filetypes = { "nix" },
  on_attach = on_attach,
})
vim.lsp.enable("nil_ls")

-- Optional: format all buffers on save for supported languages
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.c", "*.cpp", "*.rs", "*.py", "*.sh", "*.nix" },
  callback = function()
    vim.lsp.buf.format()
  end,
})
