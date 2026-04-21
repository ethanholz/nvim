return {
    {
        "folke/snacks.nvim",
        opts = {
            input = {},
            picker = {},
            indent = {
                animate = {
                    enabled = false,
                },
            },
            explorer = {},
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
