return {
    {
        "stevearc/conform.nvim",
        cond = function()
            local folder = "/Users/ethan/Documents/work/openfe/openfe"
            local cwd = vim.loop.cwd() -- current working directory
            -- Normalize both paths
            local function normalize(path)
                return vim.fs.normalize(path or "")
            end
            cwd = normalize(cwd)
            folder = normalize(folder)

            -- Check if cwd starts with folder path
            return cwd:sub(1, #folder) ~= folder
        end,
        opts = {
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
        },
    },
}
