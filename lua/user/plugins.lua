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
  use {
    "augtheo/pywal.nvim",
    as = "pywal",
    config = function()
      require "user.colorscheme"
    end,
  }
  use {
    "catppuccin/nvim",
    as = "catppuccin",
    config = function()
      require "user.colorscheme"
    end,
  }

  -- Icons
  use { "nvim-tree/nvim-web-devicons" }

  -- UI Niceties
  use {
    "nvim-tree/nvim-tree.lua",
    cmd = "NvimTreeToggle",
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
    after = "noice.nvim",
  }
  use {
    "nvim-telescope/telescope.nvim",
    requires = {
      { "debugloop/telescope-undo.nvim" },
      { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
    },
    config = function()
      require "user.plugins.telescope"
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

  use { "HiPhish/rainbow-delimiters.nvim" }
  -- Treesitter
  use {
    {
      "nvim-treesitter/nvim-treesitter",
      event = "BufRead",
      config = function()
        require "user.plugins.treesitter"
      end,
    },
    { "nvim-treesitter/playground", after = "nvim-treesitter", cmd = "TSPlaygroundToggle" },
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
    after = "nvim-treesitter",
    config = function()
      require "user.plugins.comment"
    end,
  }
  use {
    "kevinhwang91/nvim-ufo",
    requires = "kevinhwang91/promise-async",
    after = "nvim-treesitter",
    config = function()
      require "user.plugins.ufo"
    end,
  }

  use {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufRead",
    config = function()
      require "user.plugins.indentline"
    end,
  }

  use {
    "windwp/nvim-autopairs",
    event = "InsertCharPre",
    after = "nvim-cmp",
    config = function()
      require "user.plugins.autopairs"
    end,
  }

  -- cmp plugins
  use {
    {
      "hrsh7th/nvim-cmp",
      event = "InsertEnter",
      config = function()
        require "user.plugins.cmp"
      end,
      requires = {
        {
          "L3MON4D3/LuaSnip",
          event = "InsertEnter",
          config = function()
            require "user.plugins.luasnip"
          end,
          requires = {
            {
              "rafamadriz/friendly-snippets",
              event = "CursorHold",
            },
          },
        },
      },
    },
    { "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" },
    { "hrsh7th/cmp-path", after = "nvim-cmp" },
    { "hrsh7th/cmp-buffer", after = "nvim-cmp" },
    { "hrsh7th/cmp-nvim-lua", after = "nvim-cmp" },
    { "hrsh7th/cmp-cmdline", after = "nvim-cmp" },
    { "rcarriga/cmp-dap", after = "nvim-cmp" },
  }

  -- LSP
  use {
    "neovim/nvim-lspconfig",
    event = "BufRead",
    config = function()
      require "user.lsp.lspconfig"
    end,
    requires = {
      {
        "williamboman/mason.nvim",
        config = function()
          require("mason").setup {}
        end,
      },
      {
        -- WARN: Unfortunately we won't be able to lazy load this
        "hrsh7th/cmp-nvim-lsp",
      },
    },
  }

  use {
    "jose-elias-alvarez/null-ls.nvim",
    event = "BufRead",
    config = function()
      require "user.lsp.null-ls"
    end,
  }

  use {
    "RRethy/vim-illuminate",
    event = "BufRead",
    config = function()
      require "user.plugins.illuminate"
    end,
  }

  -- Git
  use {
    "lewis6991/gitsigns.nvim",
    event = "BufRead",
    config = function()
      require "user.plugins.gitsigns"
    end,
  }
  use { "tpope/vim-fugitive", cmd = "Git" }
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
    "mfussenegger/nvim-dap",
    config = function()
      require "user.plugins.dap"
    end,
    requires = {
      { "nvim-telescope/telescope-dap.nvim" },
      { "rcarriga/nvim-dap-ui" },
    },
  }

  -- Test
  use {
    { "nvim-neotest/neotest" },
    { "andy-bell101/neotest-java" },
    { "nvim-neotest/neotest-python" },
  }

  --Java
  use { "mfussenegger/nvim-jdtls", ft = { "java" } }
  use { "https://gitlab.com/schrieveslaach/sonarlint.nvim", as = "sonarlint.nvim", ft = { "java" } }
  use {
    "augtheo/gradle.nvim",
    run = "./gradlew install",
    cmd = { "GradleTasks", "GradleRun" },
  }

  --Python
  use {
    "mfussenegger/nvim-dap-python",
    config = function()
      require("dap-python").setup(vim.fn.expand "$MASON/packages/debugpy/venv/bin/python")
    end,
    ft = { "python" },
  }
  use { "AckslD/swenv.nvim" }

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
  use {
    "folke/which-key.nvim",
    event = "CursorHold",
    config = function()
      require "user.plugins.which-key"
    end,
  }

  --To do
  use {
    "folke/todo-comments.nvim",
    event = { "BufReadPost", "BufNewFile" },
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup {}
    end,
  }
  --Trouble
  use {
    "folke/trouble.nvim",
    cmd = { "Trouble", "TroubleToggle" },
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
    event = "VimEnter",
    requires = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require "user.plugins.noice"
    end,
  }

  use {
    event = "VimEnter",
    "folke/persistence.nvim",
    config = function()
      require("persistence").setup()
    end,
  }

  use {
    "folke/neodev.nvim",
  }
  -- end folke's plugins
  --
  -- begin echasnovski's plugins
  use {
    "echasnovski/mini.bracketed",
    config = function()
      require("mini.bracketed").setup()
    end,
  }
  -- end echasnovski's plugins
  --
  ---- Experimental
  -- use {
  --   "glacambre/firenvim",
  --   run = function()
  --     vim.fn["firenvim#install"](0)
  --   end,
  -- }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
