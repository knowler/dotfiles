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

cmd [[inoremap <silent><expr> <c-space> compe#complete()]]
cmd [[inoremap <silent><expr> <tab>     compe#confirm('<tab>')]]
cmd [[inoremap <silent><expr> <c-e>     compe#close('<c-e>')]]
cmd [[inoremap <silent><expr> <c-f>     compe#scroll({ 'delta': +4 })]]
cmd [[inoremap <silent><expr> <c-d>     compe#scroll({ 'delta': -4 })]]

cmd [[nnoremap <c-n> :NvimTreeToggle<cr>]]

--create a new note
map('n', 'gzn', '<cmd>lua require\'neuron/cmd\'.new_edit(require\'neuron\'.config.neuron_dir)<cr>')

--find your notes, click enter to create the note if there are not notes that match
map('n', 'gzz', '<cmd>lua require\'neuron/telescope\'.find_zettels()<cr>')

map('n', '<leader>r', 'lua require("telescope").extensions.live_grep_raw.live_grep_raw()<cr>')
