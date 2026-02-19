local map = vim.keymap.set

map("i", "<C-b>", "<ESC>^i", { desc = "move beginning of line" })
map("i", "<C-e>", "<End>", { desc = "move end of line" })
map("i", "<C-h>", "<Left>", { desc = "move left" })
map("i", "<C-l>", "<Right>", { desc = "move right" })
map("i", "<C-j>", "<Down>", { desc = "move down" })
map("i", "<C-k>", "<Up>", { desc = "move up" })

map("n", "<C-h>", "<C-w>h", { desc = "switch window left" })
map("n", "<C-l>", "<C-w>l", { desc = "switch window right" })
map("n", "<C-j>", "<C-w>j", { desc = "switch window down" })
map("n", "<C-k>", "<C-w>k", { desc = "switch window up" })

map("n", "<Esc>", "<cmd>noh<CR>", { desc = "general clear highlights" })

map("n", "<C-s>", "<cmd>w<CR>", { desc = "general save file" })
map("n", "<C-c>", "<cmd>%y+<CR>", { desc = "general copy whole file" })

map("n", "<leader>n", "<cmd>set nu!<CR>", { desc = "toggle line number" })
map("n", "<leader>rn", "<cmd>set rnu!<CR>", { desc = "toggle relative number" })
map("n", "<leader>ch", "<cmd>NvCheatsheet<CR>", { desc = "toggle nvcheatsheet" })

map({ "n", "x" }, "<leader>fm", function()
    require("conform").format({ lsp_fallback = true })
end, { desc = "general format file" })

-- global lsp mappings
map("n", "<leader>ds", vim.diagnostic.setloclist, { desc = "LSP diagnostic loclist" })

-- tabufline
if require("nvconfig").ui.tabufline.enabled then
    map("n", "<leader>b", "<cmd>enew<CR>", { desc = "buffer new" })

    map("n", "<tab>", function()
        require("nvchad.tabufline").next()
    end, { desc = "buffer goto next" })

    map("n", "<S-tab>", function()
        require("nvchad.tabufline").prev()
    end, { desc = "buffer goto prev" })

    map("n", "<leader>x", function()
        require("nvchad.tabufline").close_buffer()
    end, { desc = "buffer close" })
end

-- Comment
map("n", "<leader>/", "gcc", { desc = "toggle comment", remap = true })
map("v", "<leader>/", "gc", { desc = "toggle comment", remap = true })

-- nvimtree
map("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", { desc = "nvimtree toggle window" })
map("n", "<leader>e", "<cmd>NvimTreeFocus<CR>", { desc = "nvimtree focus window" })
map({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete without yanking" })

-- telescope
-- map("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", { desc = "telescope live grep" })
-- map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "telescope find buffers" })
-- map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "telescope help page" })
-- map("n", "<leader>ma", "<cmd>Telescope marks<CR>", { desc = "telescope find marks" })
-- map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "telescope find oldfiles" })
-- map("n", "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "telescope find in current buffer" })
-- map("n", "<leader>cm", "<cmd>Telescope git_commits<CR>", { desc = "telescope git commits" })
-- map("n", "<leader>gt", "<cmd>Telescope git_status<CR>", { desc = "telescope git status" })
-- map("n", "<leader>pt", "<cmd>Telescope terms<CR>", { desc = "telescope pick hidden term" })

map("n", "<leader>th", function()
    require("nvchad.themes").open()
end, { desc = "telescope nvchad themes" })

map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "telescope find files" })
map(
    "n",
    "<leader>fa",
    "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
    { desc = "telescope find all files" }
)

-- terminal
map("t", "<C-x>", "<C-\\><C-N>", { desc = "terminal escape terminal mode" })

-- new terminals
map("n", "<leader>h", function()
    require("nvchad.term").new({ pos = "sp" })
end, { desc = "terminal new horizontal term" })

map("n", "<leader>v", function()
    require("nvchad.term").new({ pos = "vsp" })
end, { desc = "terminal new vertical term" })

-- toggleable
map({ "n", "t" }, "<A-v>", function()
    require("nvchad.term").toggle({ pos = "vsp", id = "vtoggleTerm" })
end, { desc = "terminal toggleable vertical term" })

map({ "n", "t" }, "<A-h>", function()
    require("nvchad.term").toggle({ pos = "sp", id = "htoggleTerm" })
end, { desc = "terminal toggleable horizontal term" })

local function get_term_id()
    return "runner_" .. vim.fn.expand("%:t:r")
end

map({ "n", "t" }, "<A-i>", function()
    require("nvchad.term").toggle({ pos = "float", id = get_term_id() })
end, { desc = "terminal toggle floating term" })

map({ "n", "t" }, "<A-r>", function()
    local id = get_term_id()

    require("nvchad.term").runner({
        id = id,
        pos = "float",
        cmd = function()
            local fname = vim.fn.expand("%")
            local fname_no_ext = vim.fn.expand("%:t:r")
            local dir = vim.fn.expand("%:p:h")

            local ft_cmds = {
                python = "python3 " .. fname,
                c = "clear && gcc "
                    .. fname
                    .. " -o "
                    .. dir
                    .. "/"
                    .. fname_no_ext
                    .. " && "
                    .. dir
                    .. "/"
                    .. fname_no_ext,
                cpp = "clear && g++ "
                    .. fname
                    .. " -o "
                    .. dir
                    .. "/"
                    .. fname_no_ext
                    .. " && "
                    .. dir
                    .. "/"
                    .. fname_no_ext,
                java = "cd " .. dir .. " && javac " .. fname .. " && java " .. fname_no_ext,
                sh = "bash " .. fname,
                javascript = "node " .. fname,
                go = "go run " .. fname,
                php = "php " .. fname,
                rust = "cargo run",
                lua = "lua " .. fname,
                cs = "dotnet run",
            }

            return ft_cmds[vim.bo.filetype]
        end,
    })
end, { desc = "terminal toggle floating term and run" })

-- map({ "n", "t" }, "<A-i>", function()
--     require("nvchad.term").toggle({ pos = "float", id = "floatTerm" })
-- end, { desc = "terminal toggle floating term" })
--
-- map({ "n", "t" }, "<A-r>", function()
--     local file = vim.fn.expand("%")
--     local id = "runner_" .. vim.fn.expand("%:t:r") -- specific id per file
--
--     require("nvchad.term").runner({
--         id = id,
--         pos = "float",
--         cmd = function()
--             local fname = vim.fn.expand("%")
--             local fname_no_ext = vim.fn.expand("%:t:r")
--             local dir = vim.fn.expand("%:p:h")
--
--             local ft_cmds = {
--                 python = "python3 " .. fname,
--                 c = "clear && gcc "
--                     .. fname
--                     .. " -o "
--                     .. dir
--                     .. "/"
--                     .. fname_no_ext
--                     .. " && "
--                     .. dir
--                     .. "/"
--                     .. fname_no_ext,
--                 cpp = "clear && g++ "
--                     .. fname
--                     .. " -o "
--                     .. dir
--                     .. "/"
--                     .. fname_no_ext
--                     .. " && "
--                     .. dir
--                     .. "/"
--                     .. fname_no_ext,
--                 java = "cd " .. dir .. " && javac " .. fname .. " && java " .. fname_no_ext,
--                 sh = "bash " .. fname,
--                 javascript = "node " .. fname,
--                 go = "go run " .. fname,
--                 php = "php " .. fname,
--                 rust = "cargo run",
--                 lua = "lua " .. fname,
--                 cs = "dotnet run",
--             }
--
--             return ft_cmds[vim.bo.filetype]
--         end,
--     })
-- end, { desc = "terminal toggle floating term and run" })

map({ "n", "t" }, "<A-q>", function()
    -- local term = require("nvchad.term")
    -- Attempt to toggle off any toggleable terminals without clearing
    -- term.toggle({ pos = "vsp", id = "vtoggleTerm" })
    -- term.toggle({ pos = "sp", id = "htoggleTerm" })
    -- term.toggle({ pos = "float", id = "floatTerm" })

    -- If in terminal buffer, switch to normal mode and hide window to avoid clearing
    if vim.bo.buftype == "terminal" then
        vim.cmd("stopinsert") -- exit terminal insert mode
        vim.cmd("hide") -- hide the current window without closing buffer
    end
end, { desc = "Hide any terminal without clearing" })

map({ "n", "t" }, "<A-Q>", function()
    -- Alternatively, you can check if the current buffer is a terminal and close it
    if vim.bo.buftype == "terminal" then
        vim.cmd("bd!") -- force buffer delete to close terminal window
    end
end, { desc = "Close any terminal" })

-- whichkey
map("n", "<leader>wK", "<cmd>WhichKey <CR>", { desc = "whichkey all keymaps" })

map("n", "<leader>wk", function()
    vim.cmd("WhichKey " .. vim.fn.input("WhichKey: "))
end, { desc = "whichkey query lookup" })

-- Replace word under cursor globally
map(
    "n",
    "<leader>rr",
    [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { desc = "Replace word under cursor globally" }
)

-- Make current file executable
map("n", "<C-A-x>", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Make file executable" })

-- Highlight yanked text temporarily
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking text",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
    callback = function()
        vim.hl.on_yank()
    end,
})

-- Copy current file path to system clipboard
map("n", "<leader>fp", function()
    local filePath = vim.fn.expand("%:~") -- Get path relative to home
    vim.fn.setreg("+", filePath) -- Copy to clipboard
    print("File path copied: " .. filePath) -- Confirmation message
end, { desc = "Copy file path to clipboard" })

-- -- Window split management
-- map("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
-- map("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
-- map("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

map("n", "<leader>S", require("spectre").toggle, { desc = "Toggle Spectre" })
map("n", "<leader>sw", function()
    require("spectre").open_visual({ select_word = true })
end, { desc = "Search current word" })
map("v", "<leader>sw", function()
    require("spectre").open_visual()
end, { desc = "Search selection" })
map("n", "<leader>sp", function()
    require("spectre").open_file_search({ select_word = true })
end, { desc = "Search current file" })

-- substitute
map("n", "s", require("substitute").operator, { noremap = true, desc = "Substitute operator for motions" })
map("n", "ss", require("substitute").line, { noremap = true, desc = "Substitute entire line" })
map("n", "S", require("substitute").eol, { noremap = true, desc = "Substitute to end of line" })
map("x", "s", require("substitute").visual, { noremap = true, desc = "Substitute visual selection" })

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("x", "p", [["_dP]], { desc = "Paste without overwriting default register" })

-- Universal "Run Code" with Alt+r
-- vim.api.nvim_create_autocmd("FileType", {
--     pattern = "*",
--     callback = function()
--         local ft = vim.bo.filetype
--         local cmd = nil
--
--         if ft == "python" then
--             cmd = ":!python3 %<CR>"
--         elseif ft == "c" then
--             cmd = ":!gcc % && ./a.out<CR>"
--         elseif ft == "cpp" then
--             cmd = ":!g++ % && ./a.out<CR>"
--         elseif ft == "java" then
--             cmd = ":!javac % && java %:r<CR>"
--         elseif ft == "cs" then
--             cmd = ":!dotnet run<CR>"
--         elseif ft == "sh" then
--             cmd = ":!bash %<CR>"
--         elseif ft == "javascript" then
--             cmd = ":!node %<CR>"
--         elseif ft == "go" then
--             cmd = ":!go run %<CR>"
--         elseif ft == "php" then
--             cmd = ":!php %<CR>"
--         elseif ft == "rust" then
--             cmd = ":!cargo run<CR>"
--         end
--
--         if cmd then
--             map("n", "<A-r>", cmd, { buffer = true, desc = "Run current file" })
--         end
--     end,
-- })
