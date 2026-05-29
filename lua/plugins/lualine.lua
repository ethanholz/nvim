return {
    {
        "nvim-lualine/lualine.nvim",
        config = function()
            vim.opt.cmdheight = 1
            vim.opt.laststatus = 3
            require("lualine").setup({
                options = {
                    component_separators = { left = "|", right = "|" },
                    section_separators = "",
                },
            })
        end,
    },
}
