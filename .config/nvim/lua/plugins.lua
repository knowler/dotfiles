vim.pack.add({
	-- common deps
	"https://github.com/nvim-lua/popup.nvim",
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/nvim-tree/nvim-web-devicons",

	-- colors
	"https://github.com/cocopon/iceberg.vim",

  "https://github.com/tpope/vim-surround",
  "https://github.com/tpope/vim-abolish",
  "https://github.com/tpope/vim-commentary",
  "https://github.com/tpope/vim-eunuch",
  "https://github.com/tpope/vim-fugitive",

  "https://github.com/junegunn/vim-peekaboo",
  "https://github.com/junegunn/vim-slash",

  "https://github.com/AndrewRadev/splitjoin.vim",

  "https://github.com/pbrisbin/vim-mkdir",

  "https://github.com/nacro90/numb.nvim",

	"https://github.com/Raimondi/delimitMate",

  "https://github.com/editorconfig/editorconfig-vim",

  "https://github.com/christoomey/vim-tmux-navigator",


	"https://github.com/nvim-telescope/telescope.nvim",

	"https://github.com/junegunn/fzf",
	"https://github.com/junegunn/fzf.vim",

	-- neo-tree deps
	"https://github.com/MunifTanjim/nui.nvim",
	"https://github.com/saifulapm/neotree-file-nesting-config",

	{
    src = "https://github.com/nvim-neo-tree/neo-tree.nvim",
    version = vim.version.range("3"),
	},

	"https://github.com/nvim-treesitter/nvim-treesitter",

	"https://github.com/lewis6991/gitsigns.nvim",

	"https://github.com/romgrk/barbar.nvim",
	"https://github.com/itchyny/lightline.vim",

	"https://github.com/winston0410/cmd-parser.nvim",
	"https://github.com/winston0410/range-highlight.nvim",

  "https://github.com/williamboman/mason.nvim",
  "https://github.com/williamboman/mason-lspconfig",
  "https://github.com/neovim/nvim-lspconfig",


	"https://github.com/L3MON4D3/LuaSnip",
	"https://github.com/rafamadriz/friendly-snippets",

	"https://github.com/hrsh7th/cmp-nvim-lsp",
	"https://github.com/hrsh7th/cmp-buffer",
	"https://github.com/hrsh7th/cmp-path",
	"https://github.com/hrsh7th/cmp-cmdline",
	"https://github.com/petertriho/cmp-git",
	"https://github.com/lukas-reineke/cmp-rg",
	"https://github.com/hrsh7th/nvim-cmp",
})

--treesitter
vim.api.nvim_create_autocmd('FileType', {
  pattern = { '<filetype>' },
  callback = function() vim.treesitter.start() end,
})

-- neo-tree
require('neo-tree').setup({
	window = {
		position = "right",
	},
	nesting_rules = require("neotree-file-nesting-config").nesting_rules,
})

--delimitMate
vim.g.delimitMate_expand_space = 1
vim.g.delimitMate_expand_cr = 2
--vim.g.delimitMate_autoclose = 0

-- lightline
vim.g.lightline = {
	colorscheme = "iceberg",
}

-- lsp

require("completion")

require("mason").setup()
require("mason-lspconfig").setup()

vim.lsp.config('*', {
  root_markers = { '.git' },
})

vim.lsp.enable('html')
vim.lsp.enable('ts_ls')
