local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

-- Clear existing C++ snippets if any
require("luasnip.session.snippet_collection").clear_snippets("cpp")

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
