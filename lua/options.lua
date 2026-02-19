require("nvchad.options")

local o = vim.o

-- Indenting
o.shiftwidth = 4
o.tabstop = 4
o.softtabstop = 4

vim.api.nvim_create_autocmd("FileType", {
    pattern = "jsonc",
    callback = function()
        vim.bo.commentstring = "// %s"
    end,
})

-- o.cursorlineopt ='both' -- to enable cursorline!

-- set filetype for .CBL COBOL files.
-- vim.cmd([[ au BufRead,BufNewFile *.CBL set filetype=cobol ]])
