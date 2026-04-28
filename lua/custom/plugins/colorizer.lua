return {
  {
    "catgoose/nvim-colorizer.lua",
    event = "BufReadPre",
    opts = {},
    config = function()
      local colorizer = require "colorizer"

      colorizer.setup {
        options = { parsers = { css = true } },
      }
    end,
  },
}
