local ls = require "luasnip"
local t = ls.text_node
local s = ls.snippet
local i = ls.insert_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt

-- Clear existing C++ snippets if any
require("luasnip.session.snippet_collection").clear_snippets "cpp"

local function copy(args)
  return args[1]
end

-- Add C++ snippets
ls.add_snippets("cpp", {
  -- Example snippet: main function
  s(
    "main",
    fmt(
      [[
    int main() {{
        {}
        return 0;
    }}
  ]],
      { i(1, "// code here") }
    )
  ),
})
