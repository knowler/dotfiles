local utils = require'utils'
local autocmd = utils.autocmd
local opt = vim.opt
local cmd = vim.cmd

opt.compatible = false

cmd [[filetype plugin indent on]]
cmd [[syntax on]]
cmd [[syntax enable]]

opt.title = true
opt.mouse = 'n'
opt.ruler = true
opt.showmode = false
opt.clipboard = 'unnamed,unnamedplus'
opt.splitbelow = true
opt.splitright = true
opt.smarttab = true
opt.smartindent = true
opt.joinspaces = false
opt.ttyfast = true
opt.updatetime = 250
opt.hidden = true
opt.backup = false
opt.writebackup = false
opt.swapfile = false
opt.completeopt = 'menuone,noselect'

opt.number = true
opt.signcolumn = 'yes'

opt.tabstop = 2
opt.softtabstop = 0
opt.shiftwidth = 0
opt.expandtab = true
opt.textwidth = 80

autocmd('zettelkasten', 'BufWritePost ~/.zettelkasten/*.md silent !cd %:h && git update %:t &')
autocmd('plugins', 'BufWritePost plugins.lua PackerCompile')
