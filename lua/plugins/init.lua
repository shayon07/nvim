return {

    {
        "nvim-treesitter/nvim-treesitter",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("configs.treesitter")
        end,
    },

    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("nvchad.configs.lspconfig").defaults()
            require("configs.lspconfig")
        end,
    },

    -- {
    --     "williamboman/mason-lspconfig.nvim",
    --     event = "VeryLazy",
    --     dependencies = { "nvim-lspconfig" },
    --     config = function()
    --         require("configs.mason-lspconfig")
    --     end,
    -- },

    {
        "mfussenegger/nvim-lint",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("configs.lint")
        end,
    },

    -- {
    --     "rshkarin/mason-nvim-lint",
    --     event = "VeryLazy",
    --     dependencies = { "nvim-lint" },
    --     config = function()
    --         require("configs.mason-lint")
    --     end,
    -- },

    {
        "stevearc/conform.nvim",
        event = "BufWritePre",
        config = function()
            require("configs.conform")
        end,
    },

    -- {
    --     "zapling/mason-conform.nvim",
    --     event = "VeryLazy",
    --     dependencies = { "conform.nvim" },
    --     config = function()
    --         require("configs.mason-conform")
    --     end,
    -- },

    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        lazy = false,
        config = function()
            require("configs.telescope")
        end,
    },

    {
        "nvim-telescope/telescope-file-browser.nvim",
        dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
        config = function()
            require("configs.telescope-file-browser")
        end,
    },

    {
        "stevearc/oil.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        lazy = false,
        config = function()
            require("configs.oil")
        end,
    },

    {
        "gbprod/substitute.nvim",
        config = function()
            require("configs.substitute")
        end,
    },

    {
        "nvim-pack/nvim-spectre",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("spectre").setup()
        end,
    },
}
