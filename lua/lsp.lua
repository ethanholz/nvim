vim.g.rustaceanvim = {
    server = {
        on_attach = function(client, _)
            client.server_capabilities.workspace.didChangeWatchedFiles = {
                dynamicRegistration = false,
            }
        end,
        default_settings = {
            ["rust-analyzer"] = {
                files = {
                    watcherExclude = {
                        "**/.direnv/**",
                    },
                    excludeDirs = {
                        ".direnv",
                        ".github",
                    },
                },
                cargo = {
                    features = "all",
                },
            },
        },
    },
}

vim.api.nvim_create_augroup("LspAttach_inlayhints", {})
vim.api.nvim_create_autocmd("LspAttach", {
    group = "LspAttach_inlayhints",
    callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        -- Enable for all clients except for lua_ls
        if client and client.name ~= "lua_ls" then
            vim.lsp.inlay_hint.enable(true)
        end
    end,
})
