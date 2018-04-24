call plug#begin()

" Track my time
Plug 'wakatime/vim-wakatime'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-peekaboo'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/seoul256.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'atelierbram/base2tone-vim'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'tpope/vim-obsession'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'
Plug 'honza/vim-snippets'
" tmux
Plug 'christoomey/vim-tmux-navigator'
" Git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
" Lang
"Plug 'lifepillar/vim-mucomplete'
Plug 'othree/yajs.vim', { 'for': 'javascript' }
Plug 'othree/es.next.syntax.vim'
Plug 'mxw/vim-jsx'
Plug 'plasticboy/vim-markdown'
Plug 'editorconfig/editorconfig-vim'
Plug 'captbaritone/better-indent-support-for-php-with-html'
Plug 'lumiliet/vim-twig'
" Colors
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'morhetz/gruvbox'
Plug 'cocopon/iceberg.vim'
" Lint
"Plug 'w0rp/ale'
Plug 'rizzatti/dash.vim'
Plug 'joonty/vdebug'

call plug#end()

if (has("termguicolors"))
  set termguicolors
endif

" SETTINGS
colorscheme iceberg
set background=dark
syntax on
syntax enable
set t_Co=256
set nu
set ru
set cc=80
set laststatus=2
set foldlevel=20
set nojs
set splitbelow
set splitright
set tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab smartindent
set updatetime=250
set clipboard=unnamed

set completeopt+=menuone
set completeopt+=noselect
set completeopt+=noinsert
let g:mucomplete#enable_auto_at_startup = 1

if exists('&signcolumn')  " Vim 7.4.2201
  set signcolumn=yes
else
  let g:gitgutter_sign_column_always = 1
endif

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

"Airline settings
let g:airline#extensions#tabline#enabled = 1

let g:ale_set_highlights = 1

" For Markdown
au FileType markdown,tex setlocal tw=64 cc=+2
au FileType markdown,tex hi ColorColumn ctermbg=white guibg=white
au FileType markdown,tex nn j jzz
au FileType markdown,tex nn k kzz
au FileType markdown,tex nn G Gzz
au FileType markdown,tex nn gg ggzz
" Align GitHub-flavored Markdown tables
vmap <Leader><Bslash> :EasyAlign*<Bar><Enter>
" For Git. Title 50. Body 72.
au FileType gitcommit set tw=72 cc=51,+1
" For JS
au FileType javascript,php setlocal tw=0 cc=""

" LEADERS
nn <silent> <Leader>d :'<,'>!>> ~/Dropbox/Notes/tasks/success/done.md<CR>
nn <silent> <Leader>v :!vmd % &<CR><CR>
nn <silent> <Leader>t :pu!=strftime('%A, %B, %e, %Y')<CR>

" KEYBINGINGS
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

map <C-p> :FZF<CR>

" Limelight
map <Leader>\ :Goyo<CR>
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_guifg = 'DarkGray'
let g:limelight_default_coefficient = 0.7
let g:limelight_priority = -1

au User GoyoEnter nn j jzz
au User GoyoEnter nn k kzz
au User GoyoEnter nn G Gzz
au User GoyoEnter nn gg ggzz
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

" Zoom – from junegunn/dotfiles
function! s:zoom()
  if winnr('$') > 1
    tab split
  elseif len(filter(map(range(tabpagenr('$')), 'tabpagebuflist(v:val + 1)'),
        \ 'index(v:val, '.bufnr('').') >= 0')) > 1
    tabclose
  endif
endfunction
nnoremap <silent> <leader>z :call <sid>zoom()<cr>

command! -bang -nargs=? -complete=dir GFiles
  \ call fzf#vim#gitfiles(<q-args>, fzf#vim#with_preview(), <bang>0)
