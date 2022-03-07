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

cmd [[nmap <c-p> <cmd>lua require'telescope.builtin'.find_files()<cr>]]

cmd [[nnoremap <c-n> :NvimTreeToggle<cr>]]
