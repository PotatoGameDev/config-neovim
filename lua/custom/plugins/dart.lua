return {
  "dart-lang/dart-vim-plugin",
  {
    {
      "akinsho/flutter-tools.nvim",
      lazy = false,
      dependencies = {
        "nvim-lua/plenary.nvim",
        "stevearc/dressing.nvim", -- optional for vim.ui.select
      },
      config = true,
    },
  },
  config = function()
    vim.api.nvim_create_autocmd("BufWritePost", {
      pattern = "*.dart",
      command = "FlutterReload",
    })
  end,
}
