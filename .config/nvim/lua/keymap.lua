local map = require'utils'.map
local cmd = vim.cmd

map('n', '<up>', '<nop>')
map('n', '<down>', '<nop>')
map('n', '<left>', '<nop>')
map('n', '<right>', '<nop>')

map('n', '<c-h>', '<c-w>h')
map('n', '<c-j>', '<c-w>j')
map('n', '<c-k>', '<c-w>k')
map('n', '<c-l>', '<c-w>l')

map('n', '<c-p>', ':Files!<cr>')

cmd [[inoremap <silent><expr> <C-Space> compe#complete()]]
cmd [[inoremap <silent><expr> <Tab>     compe#confirm('<Tab>')]]
cmd [[inoremap <silent><expr> <C-e>     compe#close('<C-e>')]]
cmd [[inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })]]
cmd [[inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })]]
