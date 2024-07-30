local ls = require "luasnip"
local t = ls.text_node
local s = ls.snippet
local i = ls.insert_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt

-- Clear existing C++ snippets if any
require("luasnip.session.snippet_collection").clear_snippets "c"

local function copy(args)
  return args[1]
end

-- Add C++ snippets
ls.add_snippets("c", {
  s("class", {
    t "class ",
    i(1, "ClassName"),
    t { " {", "public:", "\t" },
    i(2, "public_members"),
    t { "", "private:", "\t" },
    i(3, "private_members"),
    t { "", "};" },
  }),

  s("dupa", {
    i "#ifndef POTATO_",
    i(1, "MODULE"),
    t "_H",
    t "#define POTATO_",
    f(copy, { 1 }),
    t "_H",
    t [[

namespace potato_bucket {
  // TODO Code or somethin

}

#endif
            ]],
  }),
})
