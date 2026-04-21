return {
    { "neovim/nvim-lspconfig" },
    {
        "mrcjkb/rustaceanvim",
        version = "^5",
        ft = { "rust" },
    },
    -- Filetype plugins
    {
        "Saecki/crates.nvim",
        event = "BufRead Cargo.toml",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            lsp = {
                enabled = true,
                actions = true,
                completion = true,
                hover = true,
            },
        },
    },
    "ziglang/zig.vim",

    {
        "saghen/blink.cmp",
        version = "1.*",
        opts = {
            completion = {
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 500,
                },
            },
            keymap = {
                preset = "default",
                ["<C-j>"] = { "select_next", "fallback" },
                ["<C-k>"] = { "select_prev", "fallback" },
            },
        },
    },
    -- UI
    {
        "EdenEast/nightfox.nvim",
        config = function()
            -- NOTE: you do not need to call setup if you don't want to.
            vim.cmd.colorscheme("carbonfox")
        end,
    },
    {
        "ethanholz/nvim-lastplace",
        config = true,
    },
    {
        "folke/which-key.nvim",
        config = true,
    },
}
