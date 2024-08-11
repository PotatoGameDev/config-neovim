local data = assert(vim.fn.stdpath "data") --[[@as string]]

--[[
require("telescope").setup {
  extensions = {
    wrap_results = true,

    fzf = {},
    history = {
      path = vim.fs.joinpath(data, "telescope_history.sqlite3"),
      limit = 100,
    },
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {},
    },
  },
}

--]]

pcall(require("telescope").load_extension, "fzf")
pcall(require("telescope").load_extension, "smart_history")
pcall(require("telescope").load_extension, "ui-select")

local builtin = require "telescope.builtin"

--TODO: Maybe change f to t like telescope?
--Also, leader instead of space.
vim.keymap.set("n", "<leader>td", builtin.find_files)
vim.keymap.set("n", "<leader>tt", builtin.git_files)
vim.keymap.set("n", "<leader>th", builtin.help_tags)
vim.keymap.set("n", "<leader>tg", builtin.live_grep)
vim.keymap.set("n", "<leader>/", builtin.current_buffer_fuzzy_find)

vim.keymap.set("n", "<leader>tw", builtin.grep_string)

vim.keymap.set("n", "<leader>ta", function()
  ---@diagnostic disable-next-line: param-type-mismatch
  builtin.find_files { cwd = vim.fs.joinpath(vim.fn.stdpath "data", "lazy") }
end)

--[[
vim.keymap.set("n", "<space>en", function()
  builtin.find_files { cwd = vim.fn.stdpath "config" }
end)

vim.keymap.set("n", "<space>eo", function()
  builtin.find_files { cwd = "~/.config/nvim-backup/" }
end)

vim.keymap.set("n", "<space>fp", function()
  builtin.find_files { cwd = "~/plugins/" }
end)
--]]
