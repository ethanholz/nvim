return {
    {
        "folke/snacks.nvim",
        opts = {
            input = {},
            picker = {
                sources = {
                    files = {
                        exclude = { "*.lock" },
                    },
                    grep = {
                        exclude = { "*.lock" },
                    },
                },
            },
            indent = {
                animate = {
                    enabled = false,
                },
            },
            explorer = {},
            notifier = {},
        },
        keys = {
            {
                "<leader>ff",
                function()
                    Snacks.picker.files()
                end,
                desc = "Find files",
            },
            {
                "<leader>fg",
                function()
                    Snacks.picker.grep()
                end,
                desc = "Grep",
            },
            {
                "<leader>fb",
                function()
                    Snacks.picker.buffers()
                end,
                desc = "Buffers",
            },
            {
                "<leader>s",
                function()
                    Snacks.picker.spelling()
                end,
                desc = "Spelling",
            },
            {
                "<leader>gr",
                function()
                    Snacks.picker.lsp_references()
                end,
                desc = "References",
            },
            {
                "<leader>gi",
                function()
                    Snacks.picker.lsp_implementations()
                end,
                desc = "Implementations",
            },
            {
                "<leader>e",
                function()
                    Snacks.explorer.open()
                end,
                desc = "File Explorer",
            },
        },
    },
}
