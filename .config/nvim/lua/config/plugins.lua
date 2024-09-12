-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
--
local plugin_path
local lsp_path
if vim.g.vscode then
    plugin_path = 'plugins.vscode'
else
    plugin_path = 'plugins.nvim'
    lsp_path = 'plugins.nvim.lsp'
end

-- Setup lazy.nvim
require("lazy").setup({
    { import = plugin_path },
        { import = lsp_path },
},
{
    checker = {
        enabled = true,
        notify = false,
    },
    change_detection = {
        notify = false,
    }
})
