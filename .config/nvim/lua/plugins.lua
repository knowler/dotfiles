-- Install Packer if not installed
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require'packer'.startup(function (use)
  --Packer
  use 'wbthomason/packer.nvim'

  --Essentials
  use 'AndrewRadev/splitjoin.vim'         -- Easily switch between single and multi line format for stuff (split: gS | join: gJ)
  use 'pbrisbin/vim-mkdir'                -- Automatically create any non-existant directories before writing the buffer
  use 'christoomey/vim-tmux-navigator'
  use 'woodyZootopia/iceberg.vim'         -- Colour scheme
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
    'winston0410/range-highlight.nvim',
    requires = 'winston0410/cmd-parser.nvim',
    config = function () require'range-highlight'.setup{} end,
  }

  use {
    'romgrk/barbar.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
  }

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
      'nvim-telescope/telescope-live-grep-raw.nvim',
      'nvim-telescope/telescope-dap.nvim',
    },
    config = function () require'telescope'.load_extension('dap') end
  }

  use {
    'jvgrootveld/telescope-zoxide',
    requires = {
      'nvim-lua/popup.nvim',
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
    },
    config = function () require'telescope'.load_extension('zoxide') end
  }

  use {'sheerun/vim-polyglot'}

  --LSP
  use {
    'neovim/nvim-lspconfig',
    requires = {
      'williamboman/nvim-lsp-installer',
    },
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

  use 'vimwiki/vimwiki'

  use {
    'kristijanhusak/orgmode.nvim',
    config = function()
      local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
      parser_config.org = {
        install_info = {
          url = 'https://github.com/milisims/tree-sitter-org',
          revision = 'main',
          files = {'src/parser.c', 'src/scanner.cc'},
        },
        filetype = 'org',
      }
      require('orgmode').setup({
        org_agenda_files = {'~/Dropbox/org/*'},
        org_default_notes_file = '~/Dropbox/org/refile.org',
      })
    end,
  }

  use 'tpope/vim-projectionist'
  use 'tpope/vim-dispatch'

  use {'tzachar/compe-tabnine', run='./install.sh', requires = 'hrsh7th/nvim-compe'}

  use { "beauwilliams/focus.nvim", config = function() require("focus").setup() end }

  use { 'cormacrelf/dark-notify', config = function() require('dark_notify').run() end }

  use 'iamcco/markdown-preview.nvim'

  use 'lepture/vim-jinja'

  use 'mattn/emmet-vim'

  --use 'github/copilot.vim'

  use 'jose-elias-alvarez/nvim-lsp-ts-utils'
  use 'jose-elias-alvarez/null-ls.nvim'
  use 'b0o/schemastore.nvim'

  use 'windwp/nvim-spectre'

  use 'mfussenegger/nvim-dap'

  -- If bootstrapping, setup plugins.
  if packer_bootstrap then
    require('packer').sync()
  end
end)
