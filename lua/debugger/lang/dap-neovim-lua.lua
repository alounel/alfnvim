local dap = require("dap")

dap.adapters.nlua = function(callback, config)
    callback({ type = "server", host = config.host or "127.0.0.0", port = config.port or 8086 })
end

dap.configurations.lua = {
    {
        type = "nlua",
        request = "attach",
        name = "Attach to running Neovim instance",
        program = function()
            pcall(require("osv").launch({ port = 8086 }))
        end,
    },
}
