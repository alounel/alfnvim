return {
    -- 文件目录树
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        lazy = true,
        cmd = "Neotree",
        keys = {
            { "<leader>nt", "<cmd>Neotree<CR>", desc = "Open Neo Tree" },
            { "<leader>nc", "<cmd>Neotree close<CR>", desc = "Close Neo Tree" },
            { "<leader>nf", "<cmd>Neotree float<CR>", desc = "Open Float Tree" },
            { "<leader>ng", "<cmd>Neotree toggle<CR>", desc = "Toggle Tree" },
            { "<leader>nb", "<cmd>Neotree buffers<CR>", desc = "Show Buffers Tree" },
            { "<leader>ns", "<cmd>Neotree filesystem reveal right<CR>", desc = "Select Right Open Tree" },
        },
        deactivate = function()
            vim.cmd([[Neotree close]])
        end,
        init = function()
            if vim.fn.argc() == 1 then
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
                follow_current_file = {
                    enable = true,
                },
                use_libuv_file_watcher = true,
            },
            source_selector = {
                winbar = true,
                statusline = true,
            },
        },
        config = function(_, opts)
            opts.event_handlers = opts.event_handlers or {}

            local function on_move(data)
                local clients = vim.lsp.get_active_clients()
                for _, client in ipairs(clients) do
                    if client:supports_method("workspace/willRenameFiles") then
                        local resp = client.request_sync("workspace/willRenameFiles", {
                            files = {
                                {
                                    oldUri = vim.uri_from_fname(data.source),
                                    newUri = vim.uri_from_fname(data.destination),
                                },
                            },
                        }, 1000)
                        if resp and resp.result ~= nil then
                            vim.lsp.util.apply_workspace_edit(resp.result, client.offset_encoding)
                        end
                    end
                end
            end

            local events = require("neo-tree.events")
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
    -- 在悬浮窗中运行ranger
    {
        "kevinhwang91/rnvimr",
        lazy = true,
        keys = {
            { "<leader>nr", "<cmd>RnvimrToggle<CR>", desc = "Toggle Ranger in Float Window" },
            { "<leader>nz", "<cmd>RnvimrResize<CR>", desc = "Resize Ranger in Window" },
        },
    },
}
