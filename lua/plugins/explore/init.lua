local Util = require("core.util")
return {
    -- 文件目录树
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        lazy = true,
        cmd = "Neotree",
        keys = {
            {
                "<leader>ng",
                function()
                    require("neo-tree.command").execute({ toggle = true, dir = Util.root() })
                end,
                desc = "Explorer NeoTree (root)",
            },
            {
                "<leader>nG",
                function()
                    require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
                end,
                desc = "Explorer NeoTree (cwd)",
            },
            {
                "<leader>ne",
                function()
                    require("neo-tree.command").execute({ source = "git_status", toggle = true })
                end,
                desc = "Git explorer",
            },
            {
                "<leader>nb",
                function()
                    require("neo-tree.command").execute({ source = "buffers", toggle = true })
                end,
                desc = "Buffer explorer",
            },
            {
                "<leader>nd",
                function()
                    require("neo-tree.command").execute({ source = "document_symbols", toggle = true })
                end,
                desc = "Document Symbols Explorer",
            },
        },
        deactivate = function()
            vim.cmd([[Neotree close]])
        end,
        init = function()
            if vim.fn.argc(-1) == 1 then
                local stat = vim.loop.fs_stat(vim.fn.argv(0))
                if stat and stat.type == "directory" then
                    require("neo-tree")
                end
            end
        end,
        dependencies = {
            { "nvim-web-devicons" },
            { "plenary.nvim" },
            { "nui.nvim" },
        },
        opts = {
            sources = { "filesystem", "buffers", "git_status", "document_symbols" },
            open_files_do_not_replace_types = {
                "terminal",
                "toggleterm",
                "Trouble",
                "trouble",
                "qf",
                "Outline",
                "aerial",
                "sagaoutline",
            },
            default_component_configs = {
                indent = {
                    with_expander = true,
                    expander_collapsed = "",
                    expander_expanded = "",
                    expander_highlight = "NeoTreeExpander",
                },
            },
            window = {
                mappings = {
                    ["<space>"] = "none",
                },
            },
            filesystem = {
                bind_to_cwd = false,
                follow_current_file = { enable = true },
                use_libuv_file_watcher = true,
            },
            source_selector = {
                winbar = true,
                statusline = true,
            },
        },
        config = function(_, opts)
            local function on_move(data)
                Util.lsp.on_rename(data.source, data.destination)
            end

            local events = require("neo-tree.events")
            opts.event_handlers = opts.event_handlers or {}
            vim.list_extend(opts.event_handlers, {
                { event = events.FILE_MOVED, handler = on_move },
                { event = events.FILE_RENAMED, handler = on_move },
            })
            require("neo-tree").setup(opts)
            vim.api.nvim_create_autocmd("TermClose", {
                pattern = "*lazygit",
                callback = function()
                    if package.loaded["neo-tree.sources.git_status"] then
                        require("neo-tree.sources.git_status").refresh()
                    end
                end,
            })
        end,
    },
    -- 更多文件浏览器
    {
        import = "plugins.extras.browser",
    },
}
