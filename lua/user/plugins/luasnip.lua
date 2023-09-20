require("luasnip").setup()
require("luasnip/loaders/from_vscode").lazy_load()
require("luasnip").filetype_extend("java", { "javadoc", "java-testing" })
require("luasnip").filetype_extend("javascript", { "javascriptreact", "typescriptreact" })
require("luasnip/loaders/from_vscode").lazy_load { paths = { "~/.config/nvim/snippets" } }
