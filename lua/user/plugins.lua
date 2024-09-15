require("lazy").setup {
  -----------------------------------------------------------------------------------------------
  --[[
             _ 
       __ __(_)
      / // / / 
      \_,_/_/  
  --]]
  {
    "catppuccin/nvim",
    as = "catppuccin",
    config = function()
      require "user.plugins.colors.catppuccin"
    end,
    lazy = false,
    priority = 1000,
  },
  {
    "sainnhe/everforest",
  },
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
  },

  {
    "NvChad/nvim-colorizer.lua",
    config = function()
      require "user.plugins.colorizer"
    end,
    event = "BufRead",
  },

  {
    "rcarriga/nvim-notify",
    config = function()
      require "user.plugins.notify"
    end,
    event = "VeryLazy",
  },

  {
    "folke/noice.nvim",
    config = function()
      require "user.plugins.noice"
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
      "nvim-telescope/telescope.nvim",
    },
    event = "VimEnter",
  },

  {
    "goolord/alpha-nvim",
    config = function()
      -- require'alpha'.setup(require'alpha.themes.theta'.config)
      require "user.plugins.alpha"
    end,
    event = "VimEnter",
  },

  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require "user.plugins.lualine"
    end,
    event = "VimEnter",
  },

  {
    branch = "alpha",
    "nvim-zh/colorful-winsep.nvim",
    config = function()
      require "user.plugins.colorful-winsep"
    end,
    dependencies = "lualine.nvim",
    event = "WinNew",
  },

  {
    "stevearc/dressing.nvim",
    config = function()
      require "user.plugins.dressing"
    end,
    dependencies = "telescope.nvim",
    event = "VeryLazy",
  },

  {
    "HiPhish/rainbow-delimiters.nvim",
    event = "BufRead",
  },

  {
    "RRethy/vim-illuminate",
    event = "BufRead",
    config = function()
      require "user.plugins.illuminate"
    end,
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {},
    -- dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
    -- dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" }, -- if you use standalone mini plugins
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
  },
  -----------------------------------------------------------------------------------------------
  --[[
           __  _ __
     __ __/ /_(_) /
    / // / __/ / / 
    \_,_/\__/_/_/  
  --]]
  {
    "nvim-tree/nvim-tree.lua",
    config = function()
      require "user.plugins.nvim-tree"
    end,
    event = "VimEnter",
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
    event = "VimEnter",
  },

  {
    "folke/which-key.nvim",
    config = function()
      require "user.plugins.which-key"
    end,
    event = "CursorHold",
  },

  {
    "folke/persistence.nvim",
    config = function()
      require("persistence").setup()
    end,
    event = "VimEnter",
  },

  {
    "folke/todo-comments.nvim",
    config = function()
      require("todo-comments").setup {}
    end,
    dependencies = "nvim-lua/plenary.nvim",
    event = { "BufReadPost", "BufNewFile" },
  },
  {
    import = "user.plugins.trouble",
  },
  -----------------------------------------------------------------------------------------------
  --[[
             ___ __ 
     ___ ___/ (_) /_
    / -_) _  / / __/
    \__/\_,_/_/\__/ 
                  
  --]]
  -- {
  --   import = "user.plugins.mini",
  -- },

  {
    -- dir = "~/projects/augtheo/bracketed",
    "augtheo/bracketed",
    config = function()
      require("mini.bracketed").setup()
    end,
    event = "BufRead",
  },

  {
    "echasnovski/mini.surround",
    config = function()
      require("mini.surround").setup()
    end,
    event = "BufRead",
  },

  {
    "echasnovski/mini.align",
    config = function()
      require("mini.align").setup()
    end,
    event = "BufRead",
  },

  {
    "echasnovski/mini.files",
    config = function()
      require "user.plugins.files"
    end,
    event = "BufRead",
  },

  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require "user.plugins.treesitter"
      require "user.plugins.context"
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "nvim-treesitter/nvim-treesitter-context",
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    event = "BufRead",
  },

  {
    "numToStr/Comment.nvim",
    config = function()
      require "user.plugins.comment"
    end,
    dependencies = "nvim-treesitter",
    event = "BufRead",
  },

  {
    "kevinhwang91/nvim-ufo",
    config = function()
      require "user.plugins.ufo"
    end,
    dependencies = {
      "kevinhwang91/promise-async",
    },
    event = "BufRead",
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("ibl").setup()
    end,
    event = "BufRead",
  },

  {
    "windwp/nvim-autopairs",
    config = function()
      require "user.plugins.autopairs"
    end,
    dependencies = { "nvim-cmp" },
    event = "InsertCharPre",
  },

  {
    "b0o/schemastore.nvim",
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

  -----------------------------------------------------------------------------------------------
  --[[ 
       __   _______ 
      / /  / __/ _ \
     / /___\ \/ ___/
    /____/___/_/    
  --]]
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "user.lsp.lspconfig"
      require "user.lsp.null-ls"
    end,
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "jose-elias-alvarez/null-ls.nvim",
    },
    event = "BufRead",
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
    config = function()
      require "user.plugins.gitsigns"
    end,
    event = "BufRead",
  },

  { "tpope/vim-fugitive", cmd = "Git" },

  {
    "ruifm/gitlinker.nvim",
    config = function()
      require("gitlinker").setup()
    end,
    event = "BufRead",
  },

  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
  },

  {
    "ThePrimeagen/vim-be-good",
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
      "nvim-telescope/telescope.nvim",
      "nvim-telescope/telescope-dap.nvim",
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
    },
    event = "VeryLazy",
  },

  -----------------------------------------------------------------------------------------------
  --[[ 
      __          __ 
     / /____ ___ / /_
    / __/ -_|_-</ __/
    \__/\__/___/\__/ 
  --]]
  {
    "nvim-neotest/neotest",
    config = function()
      require "user.plugins.neotest"
    end,
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "andy-bell101/neotest-java",
      "nvim-neotest/neotest-python",
    },
    event = "BufRead",
  },
}
