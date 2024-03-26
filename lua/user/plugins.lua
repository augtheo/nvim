require("lazy").setup {

  { "nvim-lua/plenary.nvim" },

  -----------------------------------------------------------------------------------------------
  --[[
             _ 
       __ __(_)
      / // / / 
      \_,_/_/  
  --]]
  {
    "catppuccin/nvim",
    lazy = false,
    priority = 1000,
    as = "catppuccin",
    config = function()
      require "user.plugins.colors.catppuccin"
      vim.cmd.colorscheme "catppuccin"
    end,
  },

  {
    "nvim-tree/nvim-web-devicons",
  },

  {
    "NvChad/nvim-colorizer.lua",
    config = function()
      require "user.plugins.colorizer"
    end,
  },

  {
    "rcarriga/nvim-notify",
    config = function()
      require "user.plugins.notify"
    end,
  },

  {
    "folke/noice.nvim",
    event = "VimEnter",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require "user.plugins.noice"
    end,
  },

  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    config = function()
      require "user.plugins.alpha"
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require "user.plugins.lualine"
    end,
  },

  {
    "nvim-zh/colorful-winsep.nvim",
    dependencies = "lualine.nvim",
    config = function()
      require "user.plugins.colorful-winsep"
    end,
  },

  {
    "stevearc/dressing.nvim",
    dependencies = "telescope.nvim",
    config = function()
      require "user.plugins.dressing"
    end,
  },

  -----------------------------------------------------------------------------------------------
  --[[
             _ 
       __ __(_)
      / // / / 
      \_,_/_/  
  --]]
  {
    "nvim-tree/nvim-tree.lua",
    event = "VimEnter",
    config = function()
      require "user.plugins.nvim-tree"
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    config = function()
      require "user.plugins.telescope"
    end,
  },
  {
    "akinsho/toggleterm.nvim",
    config = function()
      require "user.plugins.toggleterm"
    end,
  },
  { "HiPhish/rainbow-delimiters.nvim" },

  -----------------------------------------------------------------------------------------------
  --[[
             ___ __ 
     ___ ___/ (_) /_
    / -_) _  / / __/
    \__/\_,_/_/\__/ 
                  
  --]]

  {
    "echasnovski/mini.bracketed",
    config = function()
      require("mini.bracketed").setup()
    end,
  },
  {
    "echasnovski/mini.surround",
    config = function()
      require("mini.surround").setup()
    end,
  },

  {
    "echasnovski/mini.align",
    config = function()
      require("mini.align").setup()
    end,
  },

  {
    {
      "nvim-treesitter/nvim-treesitter",
      event = "BufRead",
      dependencies = {
        { "nvim-treesitter/nvim-treesitter-textobjects" },
        { "nvim-treesitter/nvim-treesitter-context" },
        { "JoosepAlviste/nvim-ts-context-commentstring" },
      },
      config = function()
        require "user.plugins.treesitter"
        require "user.plugins.context"
      end,
    },
  },

  {
    "numToStr/Comment.nvim",
    dependencies = "nvim-treesitter",
    config = function()
      require "user.plugins.comment"
    end,
  },
  {
    "kevinhwang91/nvim-ufo",
    event = "BufRead",
    dependencies = {
      { "kevinhwang91/promise-async" },
    },
    config = function()
      require "user.plugins.ufo"
    end,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufRead",
    config = function()
      require("ibl").setup()
    end,
  },

  {
    "windwp/nvim-autopairs",
    event = "InsertCharPre",
    dependencies = { "nvim-cmp" },
    config = function()
      require "user.plugins.autopairs"
    end,
  },

  -----------------------------------------------------------------------------------------------
  --[[ 
       ______ _  ___ 
      / __/  ' \/ _ \
      \__/_/_/_/ .__/
              /_/    
  --]]
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    config = function()
      require "user.plugins.cmp"
    end,
    dependencies = {
      {
        "L3MON4D3/LuaSnip",
        event = "InsertEnter",
        config = function()
          require "user.plugins.luasnip"
        end,
        dependencies = {
          {
            "rafamadriz/friendly-snippets",
            event = "CursorHold",
          },
        },
      },
      { "saadparwaiz1/cmp_luasnip" },
      { "hrsh7th/cmp-path" },
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-nvim-lua" },
      { "hrsh7th/cmp-cmdline" },
      { "rcarriga/cmp-dap" },
    },
  },

  -- LSP
  {
    "neovim/nvim-lspconfig",
    event = "BufRead",
    config = function()
      require "user.lsp.lspconfig"
    end,
    dependencies = {
      { "hrsh7th/cmp-nvim-lsp" },
    },
  },

  {
    "jose-elias-alvarez/null-ls.nvim",
    event = "BufRead",
    config = function()
      require "user.lsp.null-ls"
    end,
  },

  {
    "RRethy/vim-illuminate",
    event = "BufRead",
    config = function()
      require "user.plugins.illuminate"
    end,
  },

  -----------------------------------------------------------------------------------------------
  --[[ 
        ___ _(_) /_
       / _ `/ / __/
       \_, /_/\__/ 
      /___/        

  --]]

  {
    "lewis6991/gitsigns.nvim",
    event = "BufRead",
    config = function()
      require "user.plugins.gitsigns"
    end,
  },
  { "tpope/vim-fugitive", cmd = "Git" },
  {
    "ruifm/gitlinker.nvim",
    event = "BufRead",
    config = function()
      require("gitlinker").setup()
    end,
  },
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
  },

  -----------------------------------------------------------------------------------------------
  --[[ 
         __        
     ___/ /__ ____ 
    / _  / _ `/ _ \
    \_,_/\_,_/ .__/
            /_/    
  --]]
  {
    "mfussenegger/nvim-dap",
    config = function()
      require "user.plugins.dap"
    end,
    dependencies = {
      { "nvim-telescope/telescope-dap.nvim" },
      { "rcarriga/nvim-dap-ui" },
      { "nvim-neotest/nvim-nio" },
    },
  },

  -- Test
  {
    { "nvim-neotest/neotest" },
    { "andy-bell101/neotest-java" },
    { "nvim-neotest/neotest-python" },
  },

  --Java
  { "mfussenegger/nvim-jdtls", ft = { "java" } },
  { "https://gitlab.com/schrieveslaach/sonarlint.nvim", as = "sonarlint.nvim", ft = { "java" } },
  {
    "augtheo/gradle.nvim",
    run = "./gradlew install",
    cmd = { "GradleTasks", "GradleRun" },
  },

  --Python
  {
    "mfussenegger/nvim-dap-python",
    config = function()
      require("dap-python").setup(vim.fn.expand "$MASON/packages/debugpy/venv/bin/python")
    end,
    ft = { "python" },
  },
  { "AckslD/swenv.nvim" },

  -- Which key
  {
    "folke/which-key.nvim",
    config = function()
      require "user.plugins.which-key"
    end,
  },

  {
    "folke/todo-comments.nvim",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup {}
    end,
  },
  {
    "folke/trouble.nvim",
    cmd = { "Trouble", "TroubleToggle" },
    config = function()
      require("trouble").setup {}
    end,
  },

  {
    event = "VimEnter",
    "folke/persistence.nvim",
    config = function()
      require("persistence").setup()
    end,
  },
}
--   -- end echasnovski's plugins
