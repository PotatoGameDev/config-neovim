return {
  {
    "nvim-telescope/telescope.nvim",
    --tag = "0.1.8",
    version = "*",
    dependencies = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-smart-history.nvim",
      "kkharji/sqlite.lua",
      "nvim-telescope/telescope-ui-select.nvim",
    },
    config = function()
      require "custom.telescope"
    end,
  },
}
