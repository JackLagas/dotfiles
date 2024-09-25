return {
    "Mythos-404/xmake.nvim",
    branch = "v2",
    lazy = true,
    event = "BufReadPost xmake.lua",
    keys = {
        {'<leader>xm', "<cmd> XmakeSetMenu <CR>", mode = 'n'},
        {'<leader>xb', "<cmd> XmakeBuildTarget <CR>", mode = 'n'},
        {'<leader>xba', "<cmd> XmakeBuildAll <CR>", mode = 'n'},
        {'<leader>xc', "<cmd> XmakeCleanTarget <CR>", mode = 'n'},
        {'<leader>xca', "<cmd> XmakeCleanAll <CR>", mode = 'n'},
    },
    config = function()
        require("xmake").setup({
            files_path = vim.fn.stdpath("cache") .."xmake_",
            compile_command = {
                lsp = "clangd",
                dir = ".",
            },
            menu = {
                size = { width = 25, height = 20 },
                bottom_text_format = "%s(%s)",
                border_style = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
            },
            debug = false,
            work_dir = vim.fn.getcwd(),
        })
    end,
    dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
}
