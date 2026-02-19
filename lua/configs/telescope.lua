local telescope = require("telescope")
local builtin = require("telescope.builtin")

telescope.setup({
    defaults = {
        layout_strategy = "horizontal",
        sorting_strategy = "ascending",
        prompt_prefix = "🔍 ",
        color_devicons = true,
        vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "-g",
            "!.git/*",
        },

        layout_config = {
            horizontal = {
                prompt_position = "bottom",
                preview_width = 0.55,
            },
            width = 0.87,
            height = 0.80,
        },

        mappings = {
            n = { ["q"] = require("telescope.actions").close },
        },
    },

    pickers = {
        find_files = {
            hidden = true, -- show dotfiles too
        },
    },

    extensions = {
        -- fzf = {
        --     fuzzy = true,
        --     override_generic_sorter = true,
        --     override_file_sorter = true,
        --     case_mode = "smart_case",
        -- },
        file_browser = {
            hijack_netrw = true,
            hidden = true,
            grouped = true,
        },
    },
})

-- load extensions
-- telescope.load_extension("fzf")
telescope.load_extension("file_browser")

-- === Keymaps ===
-- File Pickers (prefix <leader>f)
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
vim.keymap.set("n", "<leader><leader>", builtin.find_files, { desc = "Find Files" })
vim.keymap.set("n", "<leader>fc", function()
    builtin.find_files({ cwd = vim.fn.stdpath("config") })
end, { desc = "Find Config Files" })
vim.keymap.set("n", "<leader>fs", builtin.live_grep, { desc = "Grep Word" })
vim.keymap.set({ "n", "x" }, "<leader>fws", builtin.grep_string, { desc = "Search Word/Selection" })
vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "Search Keymaps" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help Pages" })
vim.keymap.set("n", "<leader>ma", "<cmd>Telescope marks<CR>", { desc = "telescope find marks" })
vim.keymap.set("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "telescope find oldfiles" })
vim.keymap.set(
    "n",
    "<leader>fz",
    "<cmd>Telescope current_buffer_fuzzy_find<CR>",
    { desc = "telescope find in current buffer" }
)

-- Git integration
vim.keymap.set("n", "<leader>fgb", builtin.git_branches, { desc = "Switch Git Branch" })
vim.keymap.set("n", "<leader>fgs", builtin.git_status, { desc = "Git Status" })
vim.keymap.set("n", "<leader>fgc", builtin.git_commits, { desc = "Git Commits" })

-- File Browser
vim.keymap.set("n", "<leader>fb", function()
    telescope.extensions.file_browser.file_browser({
        path = "%:p:h", -- open in current file's directory
        select_buffer = true,
    })
end, { desc = "File Browser" })
