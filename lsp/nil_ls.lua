---@brief
--- https://github.com/oxalica/nil

---@type vim.lsp.Config
return {
    cmd = { "nil" },
    filetypes = { "nix" },
    root_markers = { "flake.nix", ".git" },
    settings = {
        ["nil"] = {
            formatting = {
                command = { "alejandra" },
            },
            nix = {
                flake = {
                    autoArchive = true,
                },
            },
        },
    },
}
