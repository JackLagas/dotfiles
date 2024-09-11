return {
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    opts = {
        open_for_directories = true,
    },
    keys = {
        {
            "<leader>pv",
            "<cmd>Yazi<cr>",
            desc = "Open yazi at current file"
        },
        {
            "<leader>pd",
            "<cmd>Yazi cwd<cr>",
            desc = "Open yazi at current working directory"
        },
    }
}


