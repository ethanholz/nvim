---@brief
--- https://github.com/terror/just-lsp

---@type vim.lsp.Config
return {
    cmd = { "just-lsp" },
    filetypes = { "just" },
    root_markers = { ".git" },
}
