

return {
    "williamboman/mason.nvim",
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
        local on_attach = function(client, bufnr)
			local opts = { buffer = bufnr, silent = true, remap = false }
			vim.keymap.set("n", "gd", function()
				vim.lsp.buf.definition()
			end, opts)
			vim.keymap.set("n", "K", function()
				vim.lsp.buf.hover()
			end, opts)
			vim.keymap.set("n", "<leader>vws", function()
				vim.lsp.buf.workspace_symbol()
			end, opts)
			vim.keymap.set("n", "<leader>vd", function()
				vim.diagnostic.open_float()
			end, opts)
			vim.keymap.set("n", "[d", function()
				vim.diagnostic.goto_next()
			end, opts)
			vim.keymap.set("n", "]d", function()
				vim.diagnostic.goto_prev()
			end, opts)
			vim.keymap.set("n", "<leader>vca", function()
				vim.lsp.buf.code_action()
			end, opts)
			vim.keymap.set("n", "<leader>vrr", function()
				vim.lsp.buf.reference()
			end, opts)
			vim.keymap.set("n", "<leader>vrn", function()
				vim.lsp.buf.rename()
			end, opts)
			vim.keymap.set("i", "<C-h>", function()
				vim.lsp.buf.signature_help()
			end, opts)
			if client.server_capabilities.documentFormattingProvider then
				vim.keymap.set("n", "<leader>ff", function()
						vim.lsp.buf.format({async = true})
                    end, opts)
			end
		end

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
            },
        })
        mason_tool_installer.setup({
            ensure_installed = {
                "prettier",
                "stylua",
                "codelldb",
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
					on_attach = on_attach,
					capabilities = capabilities,
				})
			end,
		})


	end,
}
