return {
  { "williamboman/mason.nvim", opts = {} },
  { "williamboman/mason-lspconfig", opts = {} },
  { "neovim/nvim-lspconfig", config = function() require("lsp-config") end },

  "cocopon/iceberg.vim",

  "tpope/vim-surround",
  "tpope/vim-abolish",
  "tpope/vim-commentary",
  "tpope/vim-eunuch",
  "tpope/vim-fugitive",

  "junegunn/vim-peekaboo",
  "junegunn/vim-slash",

  "AndrewRadev/splitjoin.vim",

  "pbrisbin/vim-mkdir",

  { "nacro90/numb.nvim", opts = {} },

  {
    "Raimondi/delimitMate",
    init = function()
      vim.g.delimitMate_expand_space = 1
      vim.g.delimitMate_expand_cr = 2
      --vim.g.delimitMate_autoclose = 0
    end
  },

  {
    "winston0410/range-highlight.nvim",
    opts = {},
    dependencies = { "winston0410/cmd-parser.nvim" },
  },

  "editorconfig/editorconfig-vim",
  "christoomey/vim-tmux-navigator",

  -- Syntax-y things

  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require'nvim-treesitter.configs'.setup {
        highlight = { enable = true },
      }
    end,
  },

  {
    "AckslD/nvim-FeMaco.lua",
    opts = {
      post_open_float = function(winnr)
        vim.api.nvim_win_set_option(winnr, "winblend", 10)
      end
    },
  },

  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
  },

  {
    -- TODO: figure this out
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
      "petertriho/cmp-git",
      "lukas-reineke/cmp-rg",
    },
    config = function()
      require("completion")
    end,
  },

  -- UI
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/popup.nvim",
      "nvim-lua/plenary.nvim",
    },
  },
  {
    "junegunn/fzf.vim",
    dependencies = "junegunn/fzf"
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    opts = {
      window = { position = "right" },
    },
    config = function(_, opts)
      -- Adding rules from plugin
      opts.nesting_rules = require("neotree-file-nesting-config").nesting_rules
      require("neo-tree").setup(opts)
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
      "saifulapm/neotree-file-nesting-config",
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = {},
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  {
    "romgrk/barbar.nvim",
    dependencies = { "kyazdani42/nvim-web-devicons" },
  },
  {
    "itchyny/lightline.vim",
    init = function()
      vim.g.lightline = {
        colorscheme = "iceberg",
      }
    end,
  },

  ----TODO: 
  --{
  --  "nvim-focus/focus.nvim",
  --  opts = {},
  --},
}
