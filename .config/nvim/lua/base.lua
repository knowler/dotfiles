local utils = require'utils'
local opt = utils.opt
local buffer = utils.buffer
local window = utils.window
local autocmd = utils.autocmd
local cmd = vim.cmd

opt('compatible', false)

cmd [[filetype plugin indent on]]
cmd [[syntax on]]
cmd [[syntax enable]]

opt('title', true)
opt('mouse', 'n')
opt('ruler', true)
opt('showmode', false)
opt('clipboard', 'unnamed,unnamedplus')
opt('splitbelow', true)
opt('splitright', true)
opt('smarttab', true)
opt('smartindent', true)
opt('joinspaces', false)
opt('ttyfast', true)
opt('updatetime', 250)
opt('hidden', true)
opt('backup', false)
opt('writebackup', false)
opt('completeopt', 'menuone,noselect')

opt('number', true, window)
opt('signcolumn', 'yes', window)

opt('tabstop', 2, buffer)
opt('softtabstop', 0, buffer)
opt('shiftwidth', 0, buffer)
opt('expandtab', true, buffer)
opt('textwidth', 80, buffer)

autocmd('zettelkasten', 'BufWritePost ~/.zettelkasten/*.md silent !cd %:h && git update %:t &')
autocmd('plugins', 'BufWritePost plugins.lua PackerCompile')
