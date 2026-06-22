local jdtls = require "jdtls"
local home = os.getenv "HOME"
local workspace_dir = home .. "/.cache/jdtls-workspace/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local mason_path = home .. "/.local/share/nvim/mason/packages/jdtls"
local lombok_path = mason_path .. "/lombok.jar"

-- fallback if Mason didn't bundle it
if vim.fn.filereadable(lombok_path) == 0 then
  lombok_path = home .. "/.local/share/lombok/lombok.jar"
end

local config = {
  cmd = { "jdtls", "-data", workspace_dir, "--jvm-arg=-javaagent:" .. lombok_path },
  root_dir = require("jdtls.setup").find_root { "pom.xml", "build.gradle", ".git" },
  settings = {
    java = {
      configuration = { runtimes = {} }, -- list JDKs here if you have multiple
    },
  },
}

jdtls.start_or_attach(config)

local augroup = vim.api.nvim_create_augroup("jdtls-keymaps", { clear = true })
vim.api.nvim_create_autocmd("LspAttach", {
  group = augroup,
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client or client.name ~= "jdtls" then
      return
    end

    vim.keymap.set("n", "<leader>io", jdtls.organize_imports, { buffer = args.buf, desc = "Organize imports" })
    vim.keymap.set("n", "<leader>ie", jdtls.extract_variable, { buffer = args.buf, desc = "Extract variable" })
    vim.keymap.set("n", "<leader>im", jdtls.extract_method, { buffer = args.buf, desc = "Extract method" })
    vim.keymap.set("n", "<leader>ic", jdtls.extract_constant, { buffer = args.buf, desc = "Extract constant" })
    vim.keymap.set("n", "gS", jdtls.super_implementation, { buffer = args.buf, desc = "Super implementation" })
  end,
})
