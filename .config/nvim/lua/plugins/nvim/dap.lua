return {
    "mfussenegger/nvim-dap",
	dependencies = {
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio",
        "jay-babu/mason-nvim-dap.nvim",
        "theHamsta/nvim-dap-virtual-text",
    },
    keys = {
        { "<leader>dq", "<CMD>DapTerminate<CR>", desc = "DAP Terminate" },
        { "<leader>dr", "<CMD>DapContinue<CR>", desc = "DAP Continue" },
        { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
        { "<leader>dc", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
        { "<leader>dd", "<CMD>DapToggleBreakpoint<CR>", desc = "Toggle Breakpoint" },
        { "<leader>ddc", function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, desc = "Breakpoint Condition" },
        { "<leader>dn", "<CMD>DapStepOver<CR>", desc = "Step Over" },
        { "<leader>di", "<CMD>DapStepInto<CR>", desc = "Step Into" },
        { "<leader>do", "<CMD>DapStepOut<CR>", desc = "Step Out" },
    },
    config = function()
        local mason_dap = require("mason-nvim-dap")
        local dap = require("dap")
        local ui = require("dapui")
        local dap_virtual_text = require("nvim-dap-virtual-text")

        dap_virtual_text.setup()

        mason_dap.setup({
            ensure_installed = {"cppdbg"},
            automatic_installation = true,
            handlers = {
                function(config) require("mason-nvim-dap").default_setup(config) end,
            },
        })

        local dap_round_groups = { "DapBreakpoint", "DapBreakpointCondition", "DapBreakpointRejected", "DapLogPoint" }
        for _, group in pairs(dap_round_groups) do
            vim.fn.sign_define(group, { text = "●", texthl = group })
        end

        dap.configurations = {
            cpp = {
                {
                    name = "Launch file",
                    type = "cppdbg",
                    request = "launch",
                    program = function()
				        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                    end,
                    cwd = "${workspaceFolder}",
                    stopAtEntry = false,
                    MIMode = "lldb",
                },
                {
                    name = "Attach to lldbserver :1234",
			        type = "cppdbg",
			        request = "launch",
			        MIMode = "lldb",
			        miDebuggerServerAddress = "localhost:1234",
			        miDebuggerPath = "/usr/bin/lldb",
			        cwd = "${workspaceFolder}",
			        program = function()
				        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
			        end,
                }
            }
        }

        ui.setup()

        dap.listeners.before.attach.dapui_config = function()
	        ui.open()
        end
        dap.listeners.before.launch.dapui_config = function()
	        ui.open()
        end
        dap.listeners.before.event_terminated.dapui_config = function()
	        ui.close()
        end
        dap.listeners.before.event_exited.dapui_config = function()
	        ui.close()
        end


    end
}
