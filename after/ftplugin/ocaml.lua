local set = vim.opt_local

set.shiftwidth = 2

local has_ocaml, ocaml_mappings = pcall(require, "ocaml.mappings")
if has_ocaml then
  vim.keymap.set("n", "<space>cp", ocaml_mappings.dune_promote_file, { buffer = 0 })
  vim.keymap.set("n", "<space>cd", ocaml_mappings.destruct, { buffer = 0 })
end
