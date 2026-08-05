local github = function(repo)
    return "https://github.com/" .. repo
end

vim.g.mapleader = ","
vim.opt.winborder = "rounded"
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.spelllang = "en"
-- Global options
vim.opt.termguicolors = true
vim.opt.hidden = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.scrolloff = 8
vim.opt.splitright = true
local tab_value = 4
vim.opt.tabstop = tab_value
vim.opt.softtabstop = tab_value
vim.opt.shiftwidth = tab_value
vim.opt.expandtab = true

vim.opt.shell = "fish"
vim.opt.bg = "dark"
vim.opt.spell = false -- Enables treesitter comment spelling
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.filetype = "on"
vim.o.swapfile = false
vim.o.wrap = false
vim.o.clipboard = "unnamedplus"
vim.opt.cmdheight = 1
vim.opt.laststatus = 3

-- Persistent undos
vim.opt.undofile = true
vim.filetype.add({ extension = { service = "systemd", templ = "templ" } })
vim.opt.packpath:prepend(vim.fn.stdpath("data") .. "/site")

vim.pack.add({
    github("neovim/nvim-lspconfig"),
    { src = github("mrcjkb/rustaceanvim"), version = vim.version.range("^9") },
    github("nvim-lua/plenary.nvim"),
    github("Saecki/crates.nvim"),
    github("ziglang/zig.vim"),
    github("EdenEast/nightfox.nvim"),
    github("ethanholz/nvim-lastplace"),
    github("folke/which-key.nvim"),
    github("folke/snacks.nvim"),
    github("echasnovski/mini.icons"),
    github("folke/lsp-trouble.nvim"),
    github("stevearc/conform.nvim"),
    github("nvim-lualine/lualine.nvim"),
    github("nvim-treesitter/nvim-treesitter"),
    github("nvim-treesitter/nvim-treesitter-context"),
}, { confirm = false, load = true })

local nts = require("nvim-treesitter")
local ts_parsers = {
    "astro",
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
}
nts.setup({
    install_dir = vim.fn.stdpath("data") .. "/site",
})
nts.install(ts_parsers)
vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(event)
        if
            event.data.spec.name == "nvim-treesitter"
            and (event.data.kind == "install" or event.data.kind == "update")
        then
            nts.update()
        end
    end,
})
vim.api.nvim_create_autocmd("FileType", {
    pattern = ts_parsers,
    callback = function()
        pcall(vim.treesitter.start)
    end,
})

require("snacks").setup({
    input = {},
    picker = {
        sources = {
            files = {
                hidden = true,
                exclude = { "*.lock", ".env*" },
            },
            grep = {
                hidden = true,
                exclude = { "*.lock", ".env*" },
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
})

require("mini.icons").setup()
require("trouble").setup()

require("crates").setup({
    lsp = {
        enabled = true,
        actions = true,
        completion = true,
        hover = true,
    },
})
require("nvim-lastplace").setup()
require("which-key").setup()
require("lualine").setup({
    options = {
        component_separators = { left = "|", right = "|" },
        section_separators = "",
    },
})
vim.cmd.colorscheme("carbonfox")

local conform_folder = "/Users/ethan/Documents/work/openfe/openfe"
local cwd = vim.fs.normalize(vim.loop.cwd() or "")
conform_folder = vim.fs.normalize(conform_folder)
if cwd:sub(1, #conform_folder) ~= conform_folder then
    require("conform").setup({
        formatters_by_ft = {
            lua = { "stylua" },
            python = { "ruff_format" },
            terraform = { "tofu_fmt" },
            astro = { "prettierd", "prettier", stop_after_first = true },
            svelte = { "prettierd", "prettier", stop_after_first = true },
            typescript = { "prettierd", "prettier", stop_after_first = true },
            javascript = { "prettierd", "prettier", stop_after_first = true },
        },
        format_on_save = {
            timeout_ms = 500,
            lsp_fallback = true,
        },
    })
end

require("mappings")
require("lsp")
vim.cmd("set completeopt+=noselect")
vim.lsp.enable({ "lua_ls", "gh_actions_ls", "gopls", "astro", "nixd", "zls", "ruff", "tflint" })
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client ~= nil and client:supports_method("textDocument/completion") then
            vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
        end
    end,
})

require("treesitter-context").setup()

vim.api.nvim_create_autocmd({ "FileType" }, {
    group = vim.api.nvim_create_augroup("edit_text", { clear = true }),
    pattern = { "gitcommit", "markdown", "txt" },
    desc = "Enable spell checking and text wrapping for certain filetypes",
    callback = function()
        vim.opt_local.spell = true
    end,
})
vim.opt.spell = false

vim.diagnostic.config({
    -- update_in_insert = false,
    virtual_text = true,
    virtual_lines = { current_line = true },
})
