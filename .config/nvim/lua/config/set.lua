-- add line numbers
vim.opt.nu = true
vim.opt.relativenumber = true

-- set tab size to 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- automatically indent into blocks
vim.opt.smartindent = true

-- disable text wrap
vim.opt.wrap = false

-- backup to file
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- dynamically highlight text during search
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- use terminal colors
vim.opt.termguicolors = true

-- keep cursor 8 lines above and below top and bottom
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

-- fast update time
vim.opt.updatetime = 50

-- add column 80 characters to the right
vim.opt.colorcolumn = "80"

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
