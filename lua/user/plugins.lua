local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "single" }
    end,
  },
  git = {
    clone_timeout = 300, -- Timeout, in seconds, for git clones
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use { "wbthomason/packer.nvim" } -- Have packer manage itself
  use { "nvim-lua/plenary.nvim" } -- Useful lua functions used by lots of plugins
  use { "windwp/nvim-autopairs" } -- Autopairs, integrates with both cmp and treesitter

  -- Comments
  use { "numToStr/Comment.nvim" }
  use { "JoosepAlviste/nvim-ts-context-commentstring" }

  use { "kyazdani42/nvim-web-devicons" }
  use { "kyazdani42/nvim-tree.lua" }
  use { "akinsho/bufferline.nvim" }
  use { "moll/vim-bbye" }
  use { "nvim-lualine/lualine.nvim" }
  use { "akinsho/toggleterm.nvim" }
  use { "ahmedkhalf/project.nvim" }
  use { "lukas-reineke/indent-blankline.nvim" }
  use { "goolord/alpha-nvim" }
  use { "kevinhwang91/nvim-ufo", requires = "kevinhwang91/promise-async" }

  -- Colorschemes
  use { "catppuccin/nvim", as = "catppuccin" }

  -- cmp plugins
  use { "hrsh7th/nvim-cmp" } -- The completion plugin
  use { "hrsh7th/cmp-buffer" } -- buffer completions
  use { "hrsh7th/cmp-path" } -- path completions
  use { "saadparwaiz1/cmp_luasnip" } -- snippet completions
  use { "hrsh7th/cmp-nvim-lsp" }
  use { "hrsh7th/cmp-nvim-lua" }
  use { "hrsh7th/cmp-cmdline" }

  -- snippets
  use { "L3MON4D3/LuaSnip" } --snippet engine
  use { "rafamadriz/friendly-snippets" } -- a bunch of snippets to use

  -- LSP
  use { "neovim/nvim-lspconfig" } -- enable LSP
  use { "williamboman/mason.nvim" }
  use { "williamboman/mason-lspconfig.nvim" }
  use { "jose-elias-alvarez/null-ls.nvim" } -- for formatters and linters

  use { "RRethy/vim-illuminate" }

  -- Telescope
  use { "nvim-telescope/telescope.nvim" }

  -- Treesitter
  use { "nvim-treesitter/nvim-treesitter" }
  use { "nvim-treesitter/playground" }

  -- Context
  use {
    "nvim-treesitter/nvim-treesitter-context",
  }
  -- Git
  use { "lewis6991/gitsigns.nvim" }
  use { "tpope/vim-fugitive" }

  -- DAP
  use { "mfussenegger/nvim-dap" }
  use { "rcarriga/nvim-dap-ui" }
  use { "rcarriga/cmp-dap" }
  use { "ravenxrz/DAPInstall.nvim" }

  -- Test
  use { "nvim-neotest/neotest" }

  --Java
  use { "mfussenegger/nvim-jdtls" }
  use { "https://gitlab.com/schrieveslaach/sonarlint.nvim", as = "sonarlint.nvim" }
  use { "augtheo/gradle.nvim", run = "./gradlew install" }
  -- use { "andy-bell101/neotest-java" }

  --Python
  use { "mfussenegger/nvim-dap-python" }
  use { "AckslD/swenv.nvim" }
  use { "stevearc/dressing.nvim" }
  use { "nvim-neotest/neotest-python" }

  -- Markdown
  use {
    "iamcco/markdown-preview.nvim",
    run = function()
      vim.fn["mkdp#util#install"]()
    end,
  }

  -- begin folke's plugins
  -- Which key
  use { "folke/which-key.nvim" }

  --To do
  use {
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
  }
  --Trouble
  use {
    "folke/trouble.nvim",
  }
  -- Noice
  use { "folke/noice.nvim", requires = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  } }
  -- end folke's plugins

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
