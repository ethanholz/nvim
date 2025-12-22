vim.o.completeopt = "menuone,noinsert,noselect"
-- local lspkind = require("lspkind")
-- A table of servers used for setting up LSP
local servers = {
    -- "bashls",
    "superhtml",
    -- "pyright",
    "nixd",
    "zls",
    "ruff",
    "tflint",
    "just",
    "ty",
    -- {
    --     "harper_ls",
    --     exec = "harper-ls",
    -- },
    {
        "terraformls",
        exec = "terraform-ls",
    },
    {
        "eslint",
        exec = "vscode-eslint-language-server",
    },
    {
        "nil_ls",
        exec = "nil",
    },
    -- {
    --     "ltex",
    --     exec = "ltex-ls",
    -- },
    {
        "ts_ls",
        exec = "typescript-language-server",
    },
    {
        "astro",
        exec = "astro-ls",
    },
    {
        "lua_ls",
        exec = "lua-language-server",
    },
    "gopls",
    {
        "gh_actions_ls",
        exec = "gh-actions-language-server",
    },
    {
        "yamlls",
        exec = "yaml-language-server",
    },
}

-- Only install servers that exist + use custom options
-- We may be able to potentially remove this
for _, server in ipairs(servers) do
    local exec = ""
    local lsp = ""
    if type(server) == "table" then
        lsp = server[1]
        if server.enable ~= nil and server.continue then
            goto continue
        end
        if server.exec ~= nil then
            exec = server.exec
        else
            exec = lsp
        end
    else
        lsp = server
        exec = server
    end

    local command = [[echo executable("]] .. exec .. [[")]]
    local out = vim.api.nvim_exec2(command, { output = true })
    local result = tonumber(out.output)
    if result ~= 0 then
        vim.lsp.enable(lsp)
        -- nvim_lsp[lsp].setup(setup)
    end
    ::continue::
end

vim.lsp.enable("biome-custom")

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
