-- Install Packer if not installed
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require'packer'.startup({function(use)
  --Packer
  use 'wbthomason/packer.nvim'

  -- Quality of Life
  use 'AndrewRadev/splitjoin.vim'         -- Easily switch between single and multi line format for stuff (split: gS | join: gJ)
  use 'tpope/vim-eunuch'
  use 'tpope/vim-surround'
  use 'Raimondi/delimitMate'
  use 'pbrisbin/vim-mkdir'                -- Automatically create any non-existant directories before writing the buffer
  use 'junegunn/vim-peekaboo'             -- Show the contens of registers
  use 'junegunn/vim-slash'                -- Automatically clears search highlight when cursor is moved (and more)
  use {
    'nacro90/numb.nvim',
    config = function () require('numb').setup() end,
  }
  use {
    'winston0410/range-highlight.nvim',
    requires = 'winston0410/cmd-parser.nvim',
    config = function () require'range-highlight'.setup{} end,
  }

  -- Colours
  use 'cocopon/iceberg.vim'

  -- Fuzzy search
  use 'junegunn/fzf'                      -- Fuzzy find stuff
  use 'junegunn/fzf.vim'

  -- Writing
  use 'junegunn/goyo.vim'
  use 'junegunn/limelight.vim'

  -- Tmux
  use 'christoomey/vim-tmux-navigator'

  -- Git
  use 'tpope/vim-fugitive'
  use {
    'lewis6991/gitsigns.nvim',
    requires = {'nvim-lua/plenary.nvim'},
    config = function () require'gitsigns'.setup{} end,
  }

  -- Syntax
  use 'sheerun/vim-polyglot'

  -- Code style
  use 'editorconfig/editorconfig-vim'

  use 'wakatime/vim-wakatime'             -- Personal time tracking

  -- Tab bar
  use {
    'romgrk/barbar.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
  }

  -- Status line
  use 'itchyny/lightline.vim'

  -- File tree
  use {
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function ()
      require'nvim-tree'.setup {
        disable_netrw       = true,
        hijack_netrw        = true,
        open_on_setup       = false,
        ignore_ft_on_setup  = {},
        auto_close          = true,
        open_on_tab         = false,
        update_to_buf_dir   = {
          enable = true,
          auto_open = true,
        },
        hijack_cursor       = false,
        update_cwd         = false,
        update_focused_file = {
          enable      = false,
          update_cwd  = false,
          ignore_list = {}
        },
        system_open = {
          cmd  = nil,
          args = {}
        },

        view = {
          width = 45,
          height = 30,
          side = 'right',
          auto_resize = true,
          mappings = {
            custom_only = false,
            list = {}
          }
        }
      }
    end,
  }

  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-lua/popup.nvim',
      'nvim-lua/plenary.nvim',
    },
  }

  --LSP
  use {
    'neovim/nvim-lspconfig',
    requires = {
      'williamboman/nvim-lsp-installer',
      'folke/lsp-colors.nvim',
    },
    config = function () require'lsp-config' end
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    run = function () vim.cmd [[TSUpdate]] end,
    requires = {
      'romgrk/nvim-treesitter-context',
    },
    config = function () require'treesitter-config' end
  }

  use 'L3MON4D3/LuaSnip'

  --Completion
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
    },
    config = function() require'completion' end
  }

  use 'famiu/nvim-reload'

  use 'tpope/vim-projectionist'

  use { "beauwilliams/focus.nvim", config = function() require("focus").setup() end }

  use { 'cormacrelf/dark-notify', config = function() require('dark_notify').run() end }

  use 'jose-elias-alvarez/null-ls.nvim'
  use 'b0o/schemastore.nvim'

  -- If bootstrapping, setup plugins.
  if packer_bootstrap then
    require('packer').sync()
  end
end,
  config = {
    display = {
      open_fn = function()
        return require('packer.util').float({ border = 'single' })
      end,
    },
  }
})
