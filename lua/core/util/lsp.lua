local M = {}

function M.get_clients(...)
    local fn = vim.lsp.get_clients or vim.lsp.get_active_clients
    return fn(...)
end

function M.on_attach(on_attach)
    vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
            local buffer = args.buf
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            on_attach(client, buffer)
        end,
    })
end

function M.on_rename(from, to)
    local clients = M.get_clients()
    for _, client in ipairs(clients) do
        if client.supports_method("workspace/willRenameFiles") then
            local resp = client.request_sync("workspace/willRenameFiles", {
                files = {
                    {
                        oldUri = vim.uri_from_fname(from),
                        newUri = vim.uri_from_fname(to),
                    },
                },
            }, 1000, 0)
            if resp and resp.result ~= nil then
                vim.lsp.util.apply_workspace_edit(resp.result, client.offset_encoding)
            end
        end
    end
end

function M.get_config(server)
    local configs = require("lspconfig.configs")
    return rawget(configs, server)
end

function M.disable(server, cond)
    local util = require("lspconfig.util")
    local def = M.get_config(server)
    def.document_config.on_new_config = util.add_hook_before(
        def.document_config.on_new_config,
        function(config, root_dir)
            if cond(root_dir, config) then
                config.enabled = false
            end
        end
    )
end

return M
