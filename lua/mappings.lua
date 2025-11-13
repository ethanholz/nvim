-- Map leader config
vim.cmd.timeoutlen = 0
local function map(mode, l, r, opts)
    opts = opts or {}
    if type(mode) == "table" then
        for _, m in ipairs(mode) do
            vim.keymap.set(m, l, r, opts)
        end
    else
        vim.keymap.set(mode, l, r, opts)
    end
end
map({ "n", "v" }, "<leader>p", '"+p', { desc = "Paste from clipboard" })
map({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to clipboard" })
map("t", "<ESC>", "<C-\\><C-n>", { desc = "Exit terminal" })
map("n", "<leader>zz", "<cmd>ZenMode<CR>", { desc = "Toggle ZendMode" })

-- Register LSP mappings
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(args)
        map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
        map("n", "<leader>R", vim.lsp.buf.rename, { desc = "Rename" })
        map("n", "<leader>fl", require("telescope.builtin").lsp_document_symbols, { desc = "LSP Document Symbols" })
        map("n", "gd", vim.lsp.buf.definition, { desc = "Goto Definition" })
        map("n", "<leader>gr", require("telescope.builtin").lsp_references, { desc = "References" })
        map("n", "<leader>gi", require("telescope.builtin").lsp_implementations, { desc = "Implementations" })
        map("n", "K", vim.lsp.buf.hover, { desc = "Hover (LSP)" })
    end,
})
