return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = {
                "bash",
                "c",
                "dockerfile",
                "gitcommit",
                "go",
                "gomod",
                "lua",
                "python",
                "query",
                "rust",
                "toml",
                "yaml",
                "just",
            },
            highlight = {
                enable = true,
            },
            playground = {
                enable = true,
            },
            -- Potentially remove, this is not really in my roation yet
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<c-space>",
                    node_incremental = "<c-space>",
                    scope_incremental = "<c-s>",
                    node_decremental = "<c-backspace>",
                },
            },
            sync_install = false,
            auto_install = false,
            ignore_install = {},
            modules = {},
        })
    end,

    {
        "nvim-treesitter/nvim-treesitter-context",
        event = "VeryLazy",
    },

    -- Treesitter Consistent Syntax Highlighting and indent
}
