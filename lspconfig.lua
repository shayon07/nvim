-- Improvements to lspconfig.lua

-- Use vim.opt_local instead of deprecated nvim_buf_set_option
local lspconfig = require('lspconfig')

-- Autocommand for formatting with client check
vim.api.nvim_create_autocmd("BufWritePre", {
    group = vim.api.nvim_create_augroup("FormatOnSave", { clear = true }),
    callback = function()
        local clients = vim.lsp.get_active_clients()
        if #clients > 0 then
            vim.lsp.buf.formatting_sync({}, 1000)
        end
    end,
})

-- Improved format function
local format_options = {
    tabSize = 4,
    insertSpaces = true,
}  

-- Adding Dockerfile pattern match
lspconfig.dockerls.setup({
    filetypes = { "dockerfile", "Dockerfile" },
})

-- Adding diagnostic navigation keymaps
vim.api.nvim_set_keymap('n', '<leader>dn', '<cmd>lua vim.diagnostic.goto_next()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>dp', '<cmd>lua vim.diagnostic.goto_prev()<CR>', { noremap = true })
