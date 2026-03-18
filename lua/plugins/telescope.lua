return {
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        cmd = "Telescope",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-fzf-native.nvim",
        },
        config = function()
            require("telescope").setup({
                pickers = {
                    find_files = {
                        find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
                    },
                },
            })

            require("telescope").load_extension("fzf")
            pcall(function()
                require("telescope").load_extension("harpoon")
            end)
        end,
        keys = {
            {
                "ff",
                function()
                    require("telescope.builtin").find_files()
                end,
                desc = "Find File",
            },
            {
                "fg",
                function()
                    require("telescope.builtin").live_grep()
                end,
                desc = "Live Grep",
            },
            {
                "fb",
                function()
                    require("telescope.builtin").buffers()
                end,
                desc = "Buffer List",
            },
            {
                "fh",
                function()
                    require("telescope.builtin").help_tags()
                end,
                desc = "Help Tags",
            },
            {
                "fc",
                function()
                    require("telescope.builtin").colorscheme()
                end,
                desc = "Colorscheme",
            },
            {
                "fq",
                function()
                    local ok, telescope = pcall(require, "telescope")
                    if ok and telescope.extensions.harpoon then
                        telescope.extensions.harpoon.marks()
                    end
                end,
                desc = "Harpoon Marks",
            },
            {
                "fs",
                function()
                    require("telescope.builtin").grep_string()
                end,
                desc = "Grep String",
            },
            {
                "s",
                function()
                    require("telescope.builtin").spell_suggest()
                end,
                desc = "Spell Suggest",
            },
        },
    },
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
    },
}
