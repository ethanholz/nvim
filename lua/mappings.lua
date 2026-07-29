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
map("n", "<leader>ff", function()
    Snacks.picker.files()
end, { desc = "Find files" })
map("n", "<leader>fg", function()
    Snacks.picker.grep()
end, { desc = "Grep" })
map("n", "<leader>fb", function()
    Snacks.picker.buffers()
end, { desc = "Buffers" })
map("n", "<leader>s", function()
    Snacks.picker.spelling()
end, { desc = "Spelling" })
map("n", "<leader>gr", function()
    Snacks.picker.lsp_references()
end, { desc = "References" })
map("n", "<leader>gi", function()
    Snacks.picker.lsp_implementations()
end, { desc = "Implementations" })
map("n", "<leader>e", function()
    Snacks.explorer.open()
end, { desc = "File Explorer" })
map("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", {
    desc = "Diagnostics (Trouble)",
})

-- Register LSP mappings
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(args)
        map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
        map("n", "<leader>R", vim.lsp.buf.rename, { desc = "Rename" })
        map("n", "gd", vim.lsp.buf.definition, { desc = "Goto Definition" })
        map("n", "K", vim.lsp.buf.hover, { desc = "Hover (LSP)" })
    end,
})
