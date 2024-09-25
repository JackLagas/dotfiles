return {
    "rcarriga/nvim-dap-ui",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
        "jay-babu/mason-nvim-dap.nvim",
        "mfussenegger/nvim-dap",
        "nvim-neotest/nvim-nio",
        "williamboman/mason-lspconfig.nvim",
	    "neovim/nvim-lspconfig",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
		"williamboman/mason.nvim",
		"hrsh7th/cmp-nvim-lsp",
		{ "folke/neodev.nvim", opts = {} },
	},
	config = function()
		local nvim_lsp = require("lspconfig")
        local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")
        local mason_tool_installer = require("mason-tool-installer")
        local lspconfig = require("plugins.nvim.lsp.lspconfig_attach")
        local adapters = require("plugins.nvim.lsp.adapters")
        local dap = require("dap")
        local ui = require("dapui")

        mason.setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        })

        mason_lspconfig.setup({
            -- list of servers for mason to install
            ensure_installed = {
                "clangd",
                "rust-analyzer",
            },
        })
        mason_tool_installer.setup({
            ensure_installed = {
                "prettier",
                "stylua",
            },
        })

		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		mason_lspconfig.setup_handlers({
			function(server)
				nvim_lsp[server].setup({
					capabilities = capabilities,
				})
			end,
			["clangd"] = function()
				nvim_lsp["clangd"].setup({
					on_attach = lspconfig.on_attach,
					capabilities = capabilities,
				})
			end,
		})


        adapters.setup(dap)

        vim.fn.sign_define('DapBreakpoint', { text = '🐞' })

        local function dap_start_debugging()
            local has_dap_repl = false
            for _, buf in ipairs(vim.fn.tabpagebuflist()) do
                if vim.bo[buf].filetype == "dap-repl" then
                    has_dap_repl = true
                    break
                end
            end
            if not has_dap_repl then
                vim.cmd("tabedit %")
                vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-o>", false, true, true), "n", false)
                ui.toggle({})
            end
            dap.continue({})
        end
        vim.keymap.set("n", "<leader>ds", dap_start_debugging)

        local function dap_end_debug()
            dap.disconnect({terminateDebuggee = false}, function()
                require("notify")("Debugger detached", vim.log.levels.INFO)
            end)
        end
        vim.keymap.set("n", "<leader>de", dap_end_debug)

        local function dap_kill_debug_process()
            dap.clear_breakpoints()
            dap.terminate({}, { terminateDebuggee = true }, function()
                vim.cmd.bd()
                u.resize_vertical_splits()
                require("notify")("Debug process killed", vim.log.levels.WARN)
            end)
        end
        vim.keymap.set("n", "<leader>dk", dap_kill_debug_process)

        local function dap_clear_breakpoints()
            dap.clear_breakpoints()
            require("notify")("Breakpoints cleared", vim.log.levels.WARN)
        end

        vim.keymap.set("n", "<leader>dC", dap_clear_breakpoints)

        vim.keymap.set("n", "<leader>dl", require("dap.ui.widgets").hover)
        vim.keymap.set("n", "<leader>dc", dap.continue)
        vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint)
        vim.keymap.set("n", "<leader>dn", dap.step_over)
        vim.keymap.set("n", "<leader>di", dap.step_into)
        vim.keymap.set("n", "<leader>do", dap.step_out)
        vim.keymap.set("n", "<leader>dr", function() require("dap").run_last() end) -- Repeat last command, e.g. attach to PID

    
           -- UI Settings
        ui.setup({
            controls = {
                element = "repl",
                enabled = true,
                icons = {
                    disconnect = "",
                    pause = "",
                    play = "",
                    run_last = "",
                    step_back = "",
                    step_into = "",
                    step_out = "",
                    step_over = "",
                    terminate = ""
                }
            },
            element_mappings = {},
            expand_lines = true,
            floating = {
                border = "single",
                mappings = {
                    close = { "q", "<Esc>" }
                }
            },
            force_buffers = true,
            icons = {
                collapsed = "",
                current_frame = "",
                expanded = ""
            },
            layouts = {
                {
                    elements = {
                        "scopes"
                    },
                    size = 0.3,
                    position = "bottom",
                },
                {
                    elements = {
                        "repl",
                        "breakpoints"
                    },
                    size = 0.3,
                    position = "right"
                },
            },
            mappings = {
                edit = "e",
                expand = { "t", "<2-LeftMouse>" },
                open = "o",
                remove = "d",
                repl = "r",
                toggle = nil,
            },
            render = {
                indent = 1,
                max_value_lines = 100
            }
        })

	end,
}
