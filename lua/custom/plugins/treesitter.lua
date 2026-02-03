return {
  {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    --tag = "v0.9.2",
    lazy = false,
    config = function()
      require("custom.treesitter").setup()
    end,
  },
}
