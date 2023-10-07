return {
    {
        "mfussenegger/nvim-dap",
        lazy = true,
        keys = {
            {
                "<leader>dc",
                function()
                    require("dap").continue()
                end,
                desc = "Start Debug Or Gogo Next Continue",
            },
            {
                "<leader>di",
                function()
                    require("dap").step_into()
                end,
                desc = "Single Step And Into",
            },
            {
                "<leader>do",
                function()
                    require("dap").step_over()
                end,
                desc = "Single Step And Over",
            },
            {
                "<leader>ds",
                function()
                    require("dap").step_out()
                end,
                desc = "Step Out of Current Function",
            },
            {
                "<leader>dR",
                function()
                    require("dap").run_to_cursor()
                end,
                desc = "Run to Cursor",
            },
            {
                "<leader>dr",
                function()
                    require("dap").run_last()
                end,
                desc = "Restart Debug",
            },
            {
                "<leader>db",
                function()
                    require("dap").toggle_breakpoint()
                end,
                desc = "Toggle Break Point",
            },
            {
                "<leader>dm",
                function()
                    require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
                end,
                desc = "Log Point Message",
            },
            {
                "<leader>da",
                function()
                    require("dap").terminate()
                end,
                desc = "Dap Terminate",
            },
            {
                "<leader>dh",
                function()
                    require("dap").session()
                end,
                desc = "Dap Session",
            },
            {
                "<leader>dt",
                function()
                    require("dap").repl.toggle()
                end,
                desc = "Toggle Repl",
            },

            { "<leader>de", ":DapSetLogLevel", desc = "Dap Setting Log Level" },
            { "<leader>dk", "<cmd>DapRestartFrame<CR>", desc = "Dap Restart Frame" },
            { "<leader>dj", "<cmd>DapLoadLaunchJSON<CR>", desc = "Direct Load Json File Debug" },
            { "<leader>dg", "<cmd>DapShowLog<CR>", desc = "Show Debug Log" },

            -- 小部件UI
            { "<leader>dwh", mode = { "n", "v" }, desc = "dap.ui.widgets hover" },
            { "<Leader>dwp", mode = { "n", "v" }, desc = "dap.ui.widgets preview" },
            { "<Leader>dwc", desc = "dap.ui.widgets float centered frames" },
            { "<Leader>dws", desc = "dap.ui.widgets float centered scopes" },
        },
        dependencies = {
            {
                "jay-babu/mason-nvim-dap.nvim",
                lazy = true,
                cmd = { "DapInstall", "DapUninstall" },
                dependencies = { "mason.nvim" },
                config = function()
                    require("mason-nvim-dap").setup({
                        ensure_installed = { "bash" },
                        automatic_installation = false,
                    })
                end,
            },
            { "nvim-dap-ui" },
            { "nvim-dap-virtual-text" },
            { "telescope.nvim" },
        },
        config = function()
            require("debugger.dapsettings")
            require("debugger.dapstartup")
            -- 小部件UI
            vim.keymap.set({ "n", "v" }, "<Leader>dwh", function()
                require("dap.ui.widgets").hover()
            end)
            vim.keymap.set({ "n", "v" }, "<Leader>dwp", function()
                require("dap.ui.widgets").preview()
            end)
            vim.keymap.set("n", "<Leader>dwc", function()
                local widgets = require("dap.ui.widgets")
                widgets.centered_float(widgets.frames)
            end)
            vim.keymap.set("n", "<Leader>dws", function()
                local widgets = require("dap.ui.widgets")
                widgets.centered_float(widgets.scopes)
            end)
        end,
    },
    -- 调试UI界面
    {
        "rcarriga/nvim-dap-ui",
        lazy = true,
        keys = {
            {
                "<leader>du",
                function()
                    require("dapui").toggle({})
                end,
                desc = "Toggle DapUI",
            },
            {
                "<leader>dx",
                function()
                    require("dapui").eval()
                end,
                mode = { "n", "v" },
                desc = "Eval DapUI",
            },
        },
        config = function()
            local dap, dapui = require("dap"), require("dapui")

            dapui.setup()
            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.disconnect["dapui_config"] = function()
                dapui.close()
            end
        end,
    },
    -- 显示虚拟文本
    {
        "theHamsta/nvim-dap-virtual-text",
        lazy = true,
        opts = {
            commented = true,
            all_frames = true,
            virt_lines = true,
        },
    },
    ------ 特定语言调试需要用到的插件 ------
    -- lua
    {
        import = "plugins.extras.dap.luadap",
    },
}
