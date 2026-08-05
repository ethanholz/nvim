---@brief
--- https://github.com/typescript-language-server/typescript-language-server

---@type vim.lsp.Config
return {
    init_options = { hostInfo = "neovim" },
    cmd = function(dispatchers, config)
        local cmd = "typescript-language-server"
        if (config or {}).root_dir then
            local local_cmd = vim.fs.joinpath(config.root_dir, "node_modules", ".bin", cmd)
            if vim.fn.executable(local_cmd) == 1 then
                cmd = local_cmd
            end
        end
        return vim.lsp.rpc.start({ cmd, "--stdio" }, dispatchers)
    end,
    filetypes = {
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
    },
    root_dir = function(bufnr, on_dir)
        local root_markers = { "package-lock.json", "yarn.lock", "pnpm-lock.yaml", "bun.lockb", "bun.lock" }
        root_markers = { root_markers, { ".git" } }

        local deno_root = vim.fs.root(bufnr, { "deno.json", "deno.jsonc" })
        local deno_lock_root = vim.fs.root(bufnr, "deno.lock")
        local project_root = vim.fs.root(bufnr, root_markers)

        if deno_lock_root and (not project_root or #deno_lock_root > #project_root) then
            return
        end
        if deno_root and (not project_root or #deno_root >= #project_root) then
            return
        end

        on_dir(project_root or vim.fn.getcwd())
    end,
    handlers = {
        ["_typescript.rename"] = function(_, result, ctx)
            local client = assert(vim.lsp.get_client_by_id(ctx.client_id))
            vim.lsp.util.show_document({
                uri = result.textDocument.uri,
                range = {
                    start = result.position,
                    ["end"] = result.position,
                },
            }, client.offset_encoding)
            vim.lsp.buf.rename()
            return vim.NIL
        end,
    },
    commands = {
        ["editor.action.showReferences"] = function(command, ctx)
            local client = assert(vim.lsp.get_client_by_id(ctx.client_id))
            local file_uri, position, references = unpack(command.arguments)
            local items = vim.lsp.util.locations_to_items(references, client.offset_encoding)

            vim.fn.setqflist({}, " ", {
                title = command.title,
                items = items,
                context = {
                    command = command,
                    bufnr = ctx.bufnr,
                },
            })
            vim.lsp.util.show_document({
                uri = file_uri,
                range = {
                    start = position,
                    ["end"] = position,
                },
            }, client.offset_encoding)
            vim.cmd("botright copen")
        end,
    },
    on_attach = function(client, bufnr)
        vim.api.nvim_buf_create_user_command(bufnr, "LspTypescriptSourceAction", function()
            local source_actions = vim.tbl_filter(function(action)
                return vim.startswith(action, "source.")
            end, client.server_capabilities.codeActionProvider.codeActionKinds)

            vim.lsp.buf.code_action({
                context = {
                    only = source_actions,
                    diagnostics = {},
                },
            })
        end, {})

        vim.api.nvim_buf_create_user_command(bufnr, "LspTypescriptGoToSourceDefinition", function()
            local win = vim.api.nvim_get_current_win()
            local params = vim.lsp.util.make_position_params(win, client.offset_encoding)
            client:exec_cmd({
                command = "_typescript.goToSourceDefinition",
                title = "Go to source definition",
                arguments = { params.textDocument.uri, params.position },
            }, { bufnr = bufnr }, function(err, result)
                if err then
                    vim.notify("Go to source definition failed: " .. err.message, vim.log.levels.ERROR)
                    return
                end
                if not result or vim.tbl_isempty(result) then
                    vim.notify("No source definition found", vim.log.levels.INFO)
                    return
                end
                vim.lsp.util.show_document(result[1], client.offset_encoding, { focus = true })
            end)
        end, { desc = "Go to source definition" })
    end,
}
