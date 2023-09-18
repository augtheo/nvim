require("lspconfig.ui.windows").default_options = { border = "single" }

require "user.lsp.mason"
require("user.lsp.handlers").setup_diagnostics()
require "user.lsp.null-ls"
