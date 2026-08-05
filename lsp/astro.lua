---@brief
--- https://github.com/withastro/astro/tree/main/packages/language-tools/language-server
---
--- Install with:
--- ```sh
--- npm install -g @astrojs/language-server
--- ```
---
--- Astro also requires a TypeScript SDK. TypeScript 7.x no longer ships
--- `tsserverlibrary.js`, so use TypeScript <= 6.x.

local function get_typescript_server_path(root_dir)
    local node_modules = vim.fs.find("node_modules", {
        path = root_dir,
        upward = true,
        limit = math.huge,
    })

    for _, dir in ipairs(node_modules) do
        local typescript = vim.fs.joinpath(dir, "typescript")
        if vim.uv.fs_stat(typescript) then
            return vim.fs.joinpath(typescript, "lib")
        end
    end

    return ""
end

---@type vim.lsp.Config
return {
    cmd = function(dispatchers, config)
        local cmd = "astro-ls"
        if (config or {}).root_dir then
            local local_cmd = vim.fs.joinpath(config.root_dir, "node_modules", ".bin", cmd)
            if vim.fn.executable(local_cmd) == 1 then
                cmd = local_cmd
            end
        end
        return vim.lsp.rpc.start({ cmd, "--stdio" }, dispatchers)
    end,
    filetypes = { "astro" },
    root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
    init_options = {
        typescript = {},
    },
    before_init = function(_, config)
        local typescript = config.init_options and config.init_options.typescript
        if typescript and not typescript.tsdk then
            typescript.tsdk = get_typescript_server_path(config.root_dir)
        end
    end,
}
