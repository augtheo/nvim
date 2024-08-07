require("nvim-treesitter.configs").setup {
  ensure_installed = {
    "bash",
    "c",
    "cpp",
    "css",
    "html",
    "java",
    "javascript",
    "lua",
    "markdown",
    "markdown_inline",
    "python",
    "query",
    "query",
    "rust",
    "tsx",
    "typescript",
  }, -- put the language you want in this array
  auto_install = true,
  ignore_install = { "" }, -- List of parsers to ignore installing
  sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)

  highlight = {
    enable = true, -- false will disable the whole extension
    additional_vim_regex_highlighting = false,
    disable = { "css" }, -- list of language that will be disabled
  },
  autopairs = {
    enable = true,
  },
  indent = { enable = true, disable = { "python", "css" } },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,

      keymaps = {
        ["al"] = "@loop.outer",
        ["il"] = "@loop.inner",

        ["af"] = "@function.outer",
        ["if"] = "@function.inner",

        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",

        ["aa"] = "@parameter.outer",
        ["ia"] = "@parameter.inner",

        ["av"] = "@variable.outer",
        ["iv"] = "@variable.inner",
      },
    },
  },
  query_linter = {
    enable = true,
    use_virtual_text = true,
    lint_events = { "BufWrite", "CursorHold" },
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<C-n>",
      node_incremental = "<C-n>",
      scope_incremental = "<C-s>",
      node_decremental = "<C-r>",
    },
  },
  -- indentation = {
  --   enable = true,
  -- },
}
