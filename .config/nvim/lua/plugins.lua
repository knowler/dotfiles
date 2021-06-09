return require'packer'.startup(function (use)
  --Packer
  use 'wbthomason/packer.nvim'

  --Essentials
  use 'AndrewRadev/splitjoin.vim'         -- Easily switch between single and multi line format for stuff (split: gS | join: gJ)
  use 'pbrisbin/vim-mkdir'                -- Automatically create any non-existant directories before writing the buffer
  use 'christoomey/vim-tmux-navigator'
  use 'cocopon/iceberg.vim'               -- Colour scheme
  use 'folke/tokyonight.nvim'
  use 'editorconfig/editorconfig-vim'
  use 'junegunn/vim-peekaboo'             -- Show the contens of registers
  use 'junegunn/vim-slash'                -- Automatically clears search highlight when cursor is moved (and more)
  use 'junegunn/fzf'                      -- Fuzzy find stuff
  use 'junegunn/fzf.vim'
  use 'junegunn/goyo.vim'
  use 'junegunn/limelight.vim'
  use {
    'lewis6991/gitsigns.nvim',
    requires = {'nvim-lua/plenary.nvim'},
    config = function () require'gitsigns'.setup{} end,
  }

  use 'Raimondi/delimitMate'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-surround'
  use 'itchyny/lightline.vim'
  use 'wakatime/vim-wakatime'             -- Personal time tracking
  use {
    'nacro90/numb.nvim',
    config = function () require('numb').setup() end,
  }

  use {
    'akinsho/nvim-bufferline.lua',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function ()
      require'bufferline'.setup {
        options = {
          diagnostics = "nvim_lsp"
        },
      }
    end
  }

  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-lua/popup.nvim',
      'nvim-lua/plenary.nvim'
    }
  }

  use {
    'oberblastmeister/neuron.nvim',
    branch = 'unstable',
    requires = {
      'nvim-lua/popup.nvim',
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
    },
    config = function () require'neuron-config' end
  }

  use {'sheerun/vim-polyglot'}

  --LSP
  use {
    'neovim/nvim-lspconfig',
    requires = {'kabouzeid/nvim-lspinstall'},
    config = function () require'lsp-config' end
  }

  use 'folke/lsp-colors.nvim'
  use {
    'folke/trouble.nvim',
    requires = "kyazdani42/nvim-web-devicons",
    config = function() require("trouble").setup{} end
  }

  use {
    'onsails/lspkind-nvim',
    config = function () require'lspkind'.init({ preset = 'codicons' }) end
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    run = function () vim.cmd [[TSUpdate]] end,
    requires = {
      'romgrk/nvim-treesitter-context',
    },
    config = function () require'treesitter-config' end
  }

  --Completion
  use {
    'hrsh7th/nvim-compe',
    config = function () require'completion' end
  }

  use 'famiu/nvim-reload'
end)
