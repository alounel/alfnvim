vim.keymap.set("n", "<leader>lw", vim.diagnostic.open_float, { desc = "Float Window View Diagnostic" })
vim.keymap.set("n", "[n", vim.diagnostic.goto_prev, { desc = "Prev Diagnostic Location" })
vim.keymap.set("n", "]n", vim.diagnostic.goto_next, { desc = "Next Diagnostic Location" })
vim.keymap.set("n", "<leader>lq", vim.diagnostic.setloclist, { desc = "QuickFix Window View Diagnostic" })
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConifg", {}),
    callback = function(ev)
        vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
        vim.keymap.set({ "n", "v" }, "<leader>lc", vim.lsp.buf.code_action, { buffer = ev.buf, desc = "Code Action" })
        vim.keymap.set({ "n", "v" }, "<leader>lC", function()
            vim.lsp.buf.code_action({
                context = {
                    only = {
                        "source",
                    },
                    diagnostics = {},
                },
            })
        end, { buffer = ev.buf, desc = "Source Action" })
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = ev.buf, desc = "Goto Declaration" })
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = ev.buf, desc = "Goto Definition" })
        vim.keymap.set("n", "gI", vim.lsp.buf.implementation, { buffer = ev.buf, desc = "Goto Implementation" })
        vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, { buffer = ev.buf, desc = "Goto Type Definition" })
        vim.keymap.set("n", "<leader>lh", vim.lsp.buf.hover, { buffer = ev.buf, desc = "Hover" })
        vim.keymap.set("n", "<leader>ls", vim.lsp.buf.signature_help, { buffer = ev.buf, desc = "Signature Help" })
        vim.keymap.set("n", "<leader>ln", vim.lsp.buf.rename, { buffer = ev.buf, desc = "Rename" })
        vim.keymap.set("n", "<leader>lr", vim.lsp.buf.references, { buffer = ev.buf, desc = "References" })
        vim.keymap.set("n", "<leader>li", vim.lsp.buf.incoming_calls, { buffer = ev.buf, desc = "Incoming" })
        vim.keymap.set("n", "<leader>lo", vim.lsp.buf.outgoing_calls, { buffer = ev.buf, desc = "Outgoing" })
        vim.keymap.set(
            "n",
            "<leader>la",
            vim.lsp.buf.add_workspace_folder,
            { buffer = ev.buf, desc = "Add Workspace Folder" }
        )
        vim.keymap.set(
            "n",
            "<leader>lm",
            vim.lsp.buf.remove_workspace_folder,
            { buffer = ev.buf, desc = "Remove Workspace Folder" }
        )
        vim.keymap.set("n", "<leader>ll", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, { buffer = ev.buf, desc = "Print Workspace Folder List" })
        vim.keymap.set("n", "<leader>lf", function()
            vim.lsp.buf.format({ async = true })
        end, { buffer = ev.buf, desc = "Async Format" })
    end,
})
