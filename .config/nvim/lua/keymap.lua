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

map('n', '<c-p>', '<cmd>lua require\'telescope-config\'.project_files()<cr>')

cmd [[inoremap <silent><expr> <c-space> compe#complete()]]
cmd [[inoremap <silent><expr> <tab>     compe#confirm('<tab>')]]
cmd [[inoremap <silent><expr> <c-e>     compe#close('<c-e>')]]
cmd [[inoremap <silent><expr> <c-f>     compe#scroll({ 'delta': +4 })]]
cmd [[inoremap <silent><expr> <c-d>     compe#scroll({ 'delta': -4 })]]

cmd [[nnoremap <c-n> :NvimTreeToggle<cr>]]
