vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.expandtab = true

if not vim.g.roslyn_enabled then
  vim.g.roslyn_enabled = true
  require("custom.roslyn").enable()
end
