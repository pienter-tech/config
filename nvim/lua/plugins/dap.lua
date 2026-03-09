return {
    {
        "mfussenegger/nvim-dap",
        config = function()
            local dap = require("dap")
            local mason_settings = require("mason.settings")

            local php_debug_adapter = vim.fn.exepath("php-debug-adapter")
            if php_debug_adapter == "" then
                php_debug_adapter = mason_settings.current.install_root_dir .. "/bin/php-debug-adapter"
            end
            if vim.fn.executable(php_debug_adapter) == 1 then
                dap.adapters.php = {
                    type = "executable",
                    command = php_debug_adapter,
                }
            end

        end,
        keys = {
            {
                "<leader>dB",
                function()
                    require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
                end,
                desc = "Breakpoint Condition",
            },
            {
                "<leader>db",
                function()
                    require("dap").toggle_breakpoint()
                end,
                desc = "Toggle Breakpoint",
            },
            {
                "<leader>dc",
                function()
                    require("dap").continue()
                end,
                desc = "Continue",
            },
            {
                "<leader>dC",
                function()
                    require("dap").run_to_cursor()
                end,
                desc = "Run to Cursor",
            },
            {
                "<leader>dg",
                function()
                    require("dap").goto_()
                end,
                desc = "Go to line (no execute)",
            },
            {
                "<leader>di",
                function()
                    require("dap").step_into()
                end,
                desc = "Step Into",
            },
            {
                "<leader>dj",
                function()
                    require("dap").down()
                end,
                desc = "Down",
            },
            {
                "<leader>dk",
                function()
                    require("dap").up()
                end,
                desc = "Up",
            },
            {
                "<leader>dl",
                function()
                    require("dap").run_last()
                end,
                desc = "Run Last",
            },
            {
                "<leader>do",
                function()
                    require("dap").step_out()
                end,
                desc = "Step Out",
            },
            {
                "<leader>dO",
                function()
                    require("dap").step_over()
                end,
                desc = "Step Over",
            },
            {
                "<leader>dp",
                function()
                    require("dap").pause()
                end,
                desc = "Pause",
            },
            {
                "<leader>dr",
                function()
                    require("dap").repl.toggle()
                end,
                desc = "Toggle REPL",
            },
            {
                "<leader>ds",
                function()
                    require("dap").session()
                end,
                desc = "Session",
            },
            {
                "<leader>dt",
                function()
                    require("dap").terminate()
                end,
                desc = "Terminate",
            },
            {
                "<leader>dw",
                function()
                    require("dap.ui.widgets").hover()
                end,
                desc = "Widgets",
            },
        },
    },
    {
        "theHamsta/nvim-dap-virtual-text",
        dependencies = {
            "mfussenegger/nvim-dap",
        },
        opts = {},
    },
    {
        "igorlfs/nvim-dap-view",
        dependencies = {
            "mfussenegger/nvim-dap",
        },
        keys = {
            {
                "<leader>du",
                "<cmd>DapViewToggle<CR>",
                desc = "Toggle DAP View",
                mode = "n",
            },
            {
                "<leader>de",
                "<cmd>DapEval<CR>",
                desc = "Eval",
                mode = { "n", "v" },
            },
            {
                "<leader>dE",
                "<cmd>DapViewWatch<CR>",
                desc = "Watch Expression",
                mode = { "n", "v" },
            },
        },
        opts = {
            auto_toggle = true,
        },
    },
}
