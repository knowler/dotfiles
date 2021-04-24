return require'packer'.startup(function () 
  --Packer
  use 'wbthomason/packer.nvim'

  --Essentials
  use 'AndrewRadev/splitjoin.vim'         -- Easily switch between single and multi line format for stuff (split: gS | join: gJ)
  use 'airblade/vim-gitgutter'            -- Show git status for lines in gutter
  use 'pbrisbin/vim-mkdir'                -- Automatically create any non-existant directories before writing the buffer
  use 'christoomey/vim-tmux-navigator'
  use 'cocopon/iceberg.vim'               -- Colour scheme
  use 'editorconfig/editorconfig-vim'
  use 'junegunn/vim-peekaboo'             -- Show the contens of registers
  use 'junegunn/vim-slash'                -- Automatically clears search highlight when cursor is moved (and more)
  use 'junegunn/fzf'                      -- Fuzzy find stuff
  use 'junegunn/fzf.vim'
  use 'junegunn/goyo.vim'
  use 'junegunn/limelight.vim'
  use 'Raimondi/delimitMate'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-surround'
  use 'vim-airline/vim-airline'
  use 'wakatime/vim-wakatime'             -- Personal time tracking

  --LSP
  use { 
    'neovim/nvim-lspconfig',
    config = function () require'lsp-config' end
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    run = function () vim.cmd [[TSUpdate]] end,
    config = function () require'treesitter-config' end
  }

  --Completion
  use {
    'hrsh7th/nvim-compe',
    config = function () require'completion' end
  }
end)
