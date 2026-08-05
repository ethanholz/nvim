---@brief
--- https://github.com/hashicorp/terraform-ls

---@type vim.lsp.Config
return {
    cmd = { "terraform-ls", "serve" },
    filetypes = { "terraform", "terraform-vars" },
    root_markers = { ".terraform", ".git" },
    init_options = {
        terraform = {
            path = "/etc/profiles/per-user/ethan/bin/tofu",
        },
    },
    capabilities = {
        experimental = {
            showReferencesCommandId = "client.showReferences",
        },
    },
    on_attach = function(_, bufnr)
        vim.lsp.codelens.enable(true, { bufnr = bufnr })
    end,
}
