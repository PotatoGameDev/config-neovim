return {
  {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    branch = "main",
    lazy = false,
    config = function()
      require("custom.treesitter").setup()
    end,
  },
}
