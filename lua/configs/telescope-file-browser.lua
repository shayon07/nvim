local telescope = require("telescope")
local actions = require("telescope.actions")
local fb_actions = require("telescope").extensions.file_browser.actions

telescope.setup({
    defaults = {
        mappings = {
            i = { ["<A-q>"] = actions.close }, -- Alt+Q to quit in insert mode
            n = { ["<A-q>"] = actions.close }, -- Alt+Q to quit in normal mode
        },
    },
    extensions = {
        file_browser = {
            hijack_netrw = true, -- Disable netrw, use Telescope instead
            hidden = true, -- Show hidden files/folders
            grouped = true, -- Group directories first
            respect_gitignore = true, -- Ignore files in .gitignore
            initial_mode = "normal", -- Start in normal mode
            layout_strategy = "horizontal", -- Horizontal layout (floating with right preview)
            layout_config = {
                width = 0.8, -- Overall width of the floating window
                height = 0.7, -- Overall height
                preview_width = 0.5, -- Right-side preview takes 50% of width
                prompt_position = "top", -- Prompt on top
                horizontal = { mirror = false },
            },
            borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }, -- Rounded floating borders

            -- Insert and normal mode keymaps
            mappings = {
                i = {
                    ["<A-c>"] = fb_actions.create, -- Alt+C: Create file/folder
                    ["<S-CR>"] = fb_actions.create_from_prompt, -- Shift+Enter: Create from prompt
                    ["<A-r>"] = fb_actions.rename, -- Alt+R: Rename selected files/folders
                    ["<A-m>"] = fb_actions.move, -- Alt+M: Move selected files/folders
                    ["<A-y>"] = fb_actions.copy, -- Alt+Y: Copy selected files/folders
                    ["<A-d>"] = fb_actions.remove, -- Alt+D: Delete selected files/folders
                    ["<C-o>"] = fb_actions.open, -- Ctrl+O: Open with system default app
                    ["<C-g>"] = fb_actions.goto_parent_dir, -- Ctrl+G: Go to parent directory
                    ["<C-e>"] = fb_actions.goto_home_dir, -- Ctrl+E: Go to home directory
                    ["<C-w>"] = fb_actions.goto_cwd, -- Ctrl+W: Go to current working directory
                    ["<C-t>"] = fb_actions.change_cwd, -- Ctrl+T: Change nvim cwd to selected folder
                    ["<C-f>"] = fb_actions.toggle_browser, -- Ctrl+F: Toggle file/folder browser view
                    ["<C-h>"] = fb_actions.toggle_hidden, -- Ctrl+H: Toggle hidden files
                    ["<C-s>"] = fb_actions.toggle_all, -- Ctrl+S: Toggle all entries ignoring ./ and ../
                    ["<BS>"] = fb_actions.backspace, -- Backspace: Go to parent dir or normal backspace
                    ["<A-q>"] = actions.close, -- Alt+Q: Close File Browser
                },
                n = {
                    ["<A-c>"] = fb_actions.create,
                    ["<S-CR>"] = fb_actions.create_from_prompt,
                    ["<A-r>"] = fb_actions.rename,
                    ["<A-m>"] = fb_actions.move,
                    ["<A-y>"] = fb_actions.copy,
                    ["<A-d>"] = fb_actions.remove,
                    ["<C-o>"] = fb_actions.open,
                    ["<C-g>"] = fb_actions.goto_parent_dir,
                    ["<C-e>"] = fb_actions.goto_home_dir,
                    ["<C-w>"] = fb_actions.goto_cwd,
                    ["<C-t>"] = fb_actions.change_cwd,
                    ["<C-f>"] = fb_actions.toggle_browser,
                    ["<C-h>"] = fb_actions.toggle_hidden,
                    ["<C-s>"] = fb_actions.toggle_all,
                    ["<BS>"] = fb_actions.backspace,
                    ["<A-q>"] = actions.close,
                },
            },
        },
    },
})

telescope.load_extension("file_browser")

-- Keymap to open floating File Browser at current buffer
vim.keymap.set("n", "<leader>fb", function()
    telescope.extensions.file_browser.file_browser({
        path = "%:p:h", -- Open at current file's directory
        select_buffer = true, -- Preselect current buffer
    })
end, { desc = "File Browser (Floating, Right Preview)" })
