local M = {}

M.setup = function()
  require("nvim-treesitter").setup {
    ensure_install = { "core", "stable" },
  }

  local group = vim.api.nvim_create_augroup("custom-treesitter", { clear = true })
  local syntax_on = { "c_sharp", "go" }

  vim.api.nvim_create_autocmd("FileType", {
    group = group,
    callback = function(args)
      local bufnr = args.buf
      local ft = vim.bo[bufnr].filetype
      pcall(vim.treesitter.start)

      if syntax_on[ft] then
        vim.bo[bufnr].syntax = "on"
      end
    end,
  })
end

M.setup()

return M
