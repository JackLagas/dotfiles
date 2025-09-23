-- set map leader to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- open netrw menu
-- vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- allow moving selected text with auto-indenting
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- stop cursor from jumping around during various actions
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzb")


-- paste without yanking
vim.keymap.set("x", "<leader>p", "\"_dP")

-- copy to system clipboard
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

-- use ctrl+c to exit insert mode normally
vim.keymap.set("i", "<C-c>", "<Esc>")

-- disable Q
vim.keymap.set("n", "Q", "<nop>")


-- buffers
vim.keymap.set("n", "<leader>sj", vim.cmd.vsplit)
vim.keymap.set("n", "<leader>sh", vim.cmd.split)
vim.keymap.set("n", "<leader>bd", vim.cmd.bd)

