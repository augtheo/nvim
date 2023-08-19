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

return packer.startup(function(use)
  use { "wbthomason/packer.nvim" } -- Have packer manage itself
  use { "nvim-lua/plenary.nvim" } -- Useful lua functions used by lots of plugins

  -- Colorschemes
  use { "AlphaTechnolog/pywal.nvim", as = "pywal" }
  use { "catppuccin/nvim", as = "catppuccin" }

  -- Icons
  use { "nvim-tree/nvim-web-devicons" }

  -- UI Niceties
  use {
    "nvim-tree/nvim-tree.lua",
    config = function()
      require "user.plugins.nvim-tree"
    end,
  }
  use {
    "goolord/alpha-nvim",
    event = "VimEnter",
    config = function()
      require "user.plugins.alpha"
    end,
  }
  use {
    "nvim-lualine/lualine.nvim",
    config = function()
      require "user.plugins.lualine"
    end,
  }
  use {
    "nvim-telescope/telescope.nvim",
    config = function()
      require "user.plugins.telescope"
    end,
  }
  use {
    "ahmedkhalf/project.nvim",
    requires = {
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require "user.plugins.project"
    end,
  }
  use {
    "stevearc/dressing.nvim",
    config = function()
      require "user.plugins.dressing"
    end,
  }
  use {
    "akinsho/toggleterm.nvim",
    config = function()
      require "user.plugins.toggleterm"
    end,
  }

  -- Treesitter
  use {
    {
      "nvim-treesitter/nvim-treesitter",
      config = function()
        require "user.plugins.treesitter"
      end,
    },
    { "nvim-treesitter/playground", after = "nvim-treesitter" },
    { "nvim-treesitter/nvim-treesitter-textobjects", after = "nvim-treesitter" },
    {
      "nvim-treesitter/nvim-treesitter-context",
      after = "nvim-treesitter",
      config = function()
        require "user.plugins.context"
      end,
    },
    { "JoosepAlviste/nvim-ts-context-commentstring", after = "nvim-treesitter", ft = { "typescript" } },
  }

  -- Editing
  use {
    "numToStr/Comment.nvim",
    event = "BufRead",
    config = function()
      require "user.plugins.comment"
    end,
  }
  use { "windwp/nvim-autopairs" } -- Autopairs, integrates with both cmp and treesitter
  use {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufRead",
    config = function()
      require "user.plugins.indentline"
    end,
    requires = {
      "nvim-treesitter/nvim-treesitter",
    },
  }
  use {
    "kevinhwang91/nvim-ufo",
    requires = "kevinhwang91/promise-async",
    after = "nvim-treesitter",
    config = function()
      require "user.plugins.ufo"
    end,
  }

  -- cmp plugins
  use { "hrsh7th/nvim-cmp" } -- The completion plugin
  use { "hrsh7th/cmp-buffer" } -- buffer sources
  use { "hrsh7th/cmp-path" } -- path sources
  use { "hrsh7th/cmp-nvim-lsp" }
  use { "hrsh7th/cmp-nvim-lua" }
  use { "hrsh7th/cmp-cmdline" }
  use { "saadparwaiz1/cmp_luasnip" } -- snippet completions

  -- snippets
  use { "L3MON4D3/LuaSnip" } --snippet engine
  use { "rafamadriz/friendly-snippets" } -- a bunch of snippets to use

  -- LSP
  -- TODO: Setup LSP lazily
  use { "neovim/nvim-lspconfig" } -- enable LSP
  use { "williamboman/mason.nvim" }
  use { "williamboman/mason-lspconfig.nvim" }
  use { "jose-elias-alvarez/null-ls.nvim" } -- for formatters and linters
  use { "RRethy/vim-illuminate" }

  -- Git
  use {
    "lewis6991/gitsigns.nvim",
    event = "BufRead",
    config = function()
      require "user.plugins.gitsigns"
    end,
  }
  use { "tpope/vim-fugitive", event = "BufRead" }
  use {
    "ThePrimeagen/git-worktree.nvim",
    requires = {
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require "user.plugins.git-worktree"
    end,
  }
  use {
    "ruifm/gitlinker.nvim",
    requires = "nvim-lua/plenary.nvim",
    event = "BufRead",
    config = function()
      require "user.plugins.gitlinker"
    end,
  }

  -- DAP
  use {
    "rcarriga/nvim-dap-ui",
    -- ft = { "java", "python" },
  }
  use {
    "rcarriga/cmp-dap", -- nvim-cmp source for nvim-dap REPL and nvim-dap-ui buffers
    -- ft = { "java", "python" },
  }
  use {
    "mfussenegger/nvim-dap",
    requires = {
      "nvim-telescope/telescope.nvim",
      "nvim-telescope/telescope-dap.nvim",
    },
    config = function()
      require "user.plugins.dap"
    end,
    -- ft = { "java", "python" },
  }

  -- Test
  use {
    "nvim-neotest/neotest",
    config = function()
      require "user.plugins.neotest"
    end,
  }

  --Java
  use { "mfussenegger/nvim-jdtls", ft = { "java" } }
  use { "https://gitlab.com/schrieveslaach/sonarlint.nvim", as = "sonarlint.nvim", ft = { "java" } }
  use {
    "augtheo/gradle.nvim",
    run = "./gradlew install",
    cond = function()
      local file = vim.fn.glob "build.gradle"
      if file and #file > 0 then
        return true
      end
      return false
    end,
  }
  use { "andy-bell101/neotest-java" }

  --Python
  use {
    "mfussenegger/nvim-dap-python",
    config = function()
      require("dap-python").setup(vim.fn.expand "$MASON/packages/debugpy/venv/bin/python")
    end,
    ft = { "python" },
  }
  use { "AckslD/swenv.nvim" }
  use { "nvim-neotest/neotest-python" }

  -- Markdown
  use {
    "iamcco/markdown-preview.nvim",
    run = function()
      vim.fn["mkdp#util#install"]()
    end,
    ft = { "markdown" },
  }

  -- begin folke's plugins
  -- Which key
  use { "folke/which-key.nvim" }

  --To do
  use {
    "folke/todo-comments.nvim",
    event = { "BufReadPost", "BufNewFile" },
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require "user.plugins.todo"
    end,
  }
  --Trouble
  use {
    "folke/trouble.nvim",
    config = function()
      require "user.plugins.trouble"
    end,
  }
  -- Noice
  use {
    "rcarriga/nvim-notify",
    config = function()
      require "user.plugins.notify"
    end,
  }
  use {
    "folke/noice.nvim",
    requires = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require "user.plugins.noice"
    end,
  }
  -- end folke's plugins
  use {
    "glacambre/firenvim",
    run = function()
      vim.fn["firenvim#install"](0)
    end,
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
