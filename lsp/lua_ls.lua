local root_markers1 = {
    ".emmyrc.json",
    ".luarc.json",
    ".luarc.jsonc",
}
local root_markers2 = {
    ".luacheckrc",
    ".stylua.toml",
    "stylua.toml",
    "selene.toml",
    "selene.yml",
}

---@type vim.lsp.Config
return {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    root_markers = vim.fn.has("nvim-0.11.3") == 1 and { root_markers1, root_markers2, { ".git" } }
        or vim.list_extend(vim.list_extend(root_markers1, root_markers2), { ".git" }),
    ---@type lspconfig.settings.lua_ls
    settings = {
        Lua = {
            codeLens = { enable = true },
            diagnostics = {
                -- Get the language server to recognize the `vim` global and `awesome`
                globals = { "vim", "use", "beautiful", "awful" },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = { vim.env.VIMRUNTIME },
                checkThirdParty = false,
            },
            hint = {
                enable = true,
            },
            telemetry = {
                enable = false,
            },
        },
    },
}
