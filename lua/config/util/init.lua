local uv = vim.loop or vim.uv
local LazyUtil = require("lazy.core.util")

local M = {}

local deprecated = {
    get_clients = "lsp",
    on_attach = "lsp",
    on_rename = "lsp",
    root_patterns = { "root", "patterns" },
    get_root = { "root", "get" },
    float_term = { "terminal", "open" },
    toggle_diagnostics = { "toggle", "diagnostics" },
    toggle_number = { "toggle", "number" },
    fg = "ui",
}

setmetatable(M, {
    __index = function(t, k)
        if LazyUtil[k] then
            return LazyUtil[k]
        end
        local dep = deprecated[k]
        if dep then
            local mod = type(dep) == "table" and dep[1] or dep
            local key = type(dep) == "table" and dep[2] or k
            M.deprecate([[require("config.util").]] .. k, [[require("config.util").]] .. mod .. "." .. key)
            t[mod] = require("config.util." .. mod)
            return t[mod][key]
        end
        t[k] = require("config.util." .. k)
        return t[k]
    end,
})

function M.is_win()
    return uv.os_uname().sysname:find("Windows") ~= nil
end

function M.has(plugin)
    return require("lazy.core.config").spec.plugins[plugin] ~= nil
end

function M.on_very_lazy(fn)
    vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
            fn()
        end,
    })
end

function M.opts(name)
    local plugin = require("lazy.core.config").plugins[name]
    if not plugin then
        return {}
    end
    local Plugin = require("lazy.core.plugin")
    return Plugin.values(plugin, "opts", false)
end

function M.deprecate(old, new)
    M.warn(("`%s` is deprecated. Please use `%s` instead"):format(old, new), {
        title = "Alfnvim",
        once = true,
        stacktrace = true,
        stacklevel = 6,
    })
end

function M.lazy_notify()
    local notifs = {}
    local function temp(...)
        table.insert(notifs, vim.F.pack_len(...))
    end

    local orig = vim.notify
    vim.notify = temp

    local timer = uv.new_timer()
    local check = assert(uv.new_check())

    local replay = function()
        timer:stop()
        check:stop()
        if vim.notify == temp then
            vim.notify = orig
        end
        vim.schedule(function()
            for _, notif in ipairs(notifs) do
                vim.notify(vim.F.unpack_len(notif))
            end
        end)
    end

    check:start(function()
        if vim.notify ~= temp then
            replay()
        end
    end)
    timer:start(500, 0, replay)
end

function M.on_load(name, fn)
    local Config = require("lazy.core.config")
    if Config.plugins[name] and Config.plugins[name]._.loaded then
        fn(name)
    else
        vim.api.nvim_create_autocmd("User", {
            pattern = "LazyLoad",
            callback = function(event)
                if event.data == name then
                    fn(name)
                    return true
                end
            end,
        })
    end
end

function M.safe_keymap_set(mode, lhs, rhs, opts)
    local keys = require("lazy.core.handler").handlers.keys
    local modes = type(mode) == "string" and { mode } or mode

    modes = vim.tbl_filter(function(m)
        return not (keys.have and keys:have(lhs, m))
    end, modes)

    if #modes > 0 then
        opts = opts or {}
        opts.silent = opts.silent ~= false
        if opts.remap then
            opts.remap = nil
        end
        vim.keymap.set(modes, lhs, rhs, opts)
    end
end

return M
