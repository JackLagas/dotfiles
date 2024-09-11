return {
    "Mythos-404/xmake.nvim",
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
            compile_command = {
                lsp = "clangd",
                dir = "build",
            },
        })
    end,
    dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
}
