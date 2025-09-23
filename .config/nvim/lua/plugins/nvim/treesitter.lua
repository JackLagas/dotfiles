return 	{
	'nvim-treesitter/nvim-treesitter',
    version = false,
    build = ":TSUpdate",
    event = {"VeryLazy"},
    lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline

    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    opts_extend = { "ensure_installed" },

    opts = {
        highlight = { enable = true },
        indent = { enable = true },
        ensure_installed = {
            "bash",
            "c",
            "diff",
            "dockerfile",
            "html",
            "javascript",
            "jsdoc",
            "json",
            "jsonc",
            "lua",
            "luadoc",
            "luap",
            "markdown",
            "markdown_inline",
            "printf",
            "python",
            "query",
            "regex",
            "toml",
            "tsx",
            "typescript",
            "vim",
            "vimdoc",
            "xml",
            "yaml",
            "zsh",
        },
    }
}
