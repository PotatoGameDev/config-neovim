local port = os.getenv "GDScript_Port" or "6005"
local cmd = vim.lsp.rpc.connect("127.0.0.1", port)
local pipe = "/tmp/godotlsp.pipe"
vim.api.nvim_create_autocmd({ "BufEnter" }, {
  pattern = { "*.gd" },
  callback = function()
    -- Attach the LSP client to the current buffer if it's not already attached
    local bufnr = vim.api.nvim_get_current_buf()
    if not vim.lsp.buf_is_attached(bufnr) then
      vim.lsp.start {
        name = "Godot",
        cmd = cmd,
        root_dir = vim.fs.dirname(vim.fs.find({ "project.godot", ".git" }, { upward = true })[1]),
        on_attach = function(client, bufnr)
          if not vim.fn.exists "v:servername" then
            vim.api.nvim_command('echo serverstart("' .. pipe .. '")')
          end
        end,
      }
    end
  end,
})
