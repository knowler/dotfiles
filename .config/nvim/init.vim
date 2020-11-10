" Plugins like this
set nocompatible

" Use vim-plug for plugin management (install first)
" install with :PlugInstall
" update with :PlugUpdate
call plug#begin(stdpath('data') . '/plugged')

" Essentials
Plug 'neoclide/coc.nvim', {'branch': 'release'}       " LSP aka Intellisense for vim (extensions are installed with :CocInstall)
Plug 'sheerun/vim-polyglot'                           " The only syntax highlighting package you will ever need
Plug 'AndrewRadev/splitjoin.vim'                      " Easily switch between single and multi line format for stuff (split: gS | join: gJ)
Plug 'tpope/vim-fugitive'                             " Git for vim
Plug 'tpope/vim-surround'                             " Surround stuff
Plug 'editorconfig/editorconfig-vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }   " Fuzzy find stuff
Plug 'junegunn/fzf.vim'

" Tmux essentials
Plug 'christoomey/vim-tmux-navigator'

" Cosmetic
Plug 'cocopon/iceberg.vim'

" Helpful cosmetic
Plug 'airblade/vim-gitgutter'                         " Show git status for lines in gutter
Plug 'vim-airline/vim-airline'

" Helpful
Plug 'junegunn/vim-slash'                             " Automatically clears search highlight when cursor is moved (and more)
Plug 'Raimondi/delimitMate'                           " Auto-close parans, brackets, quotes, etc.
Plug 'alvan/vim-closetag'                             " Auto-close XML-like tags

" Additional Syntax
Plug 'neoclide/jsonc.vim'

" Personal time tracking
Plug 'wakatime/vim-wakatime'

" Writing
Plug 'vimwiki/vimwiki'

call plug#end()

" Allow filetype plugins
filetype plugin on

" Enable syntax
syntax on
syntax enable

" tmux + alacritty + color scheme related
set t_Co=256
if &term =~ '256color' | set t_ut= | endif
if (has("nvim"))
	let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
if (has("termguicolors"))
	set termguicolors
endif

" Colorscheme in dark mode [iceberg.vim]
colorscheme iceberg
set background=dark

" For terminal title
set title

" Cosmetic
set number
set ruler
set signcolumn=yes

" Split behaviour
set splitbelow
set splitright

" Tabs (default width 2, style spaces)
set tabstop=2
set softtabstop=0
set shiftwidth=0
set expandtab
set smarttab
set smartindent
set nojoinspaces

" Wrap at 80 for text
set textwidth=80

" Allow mouse
set mouse=n

" Use system clipboard
set clipboard+=unnamedplus

" Perf
set ttyfast
set updatetime=250

" Blink the cursor (doesn’t work)
set guicursor=a:blinkon100

" LSP plugins like this
set hidden
set nobackup
set nowritebackup

" Highlight tweaks (pairs well with terminal transparency)
highlight NonText guibg=NONE ctermbg=NONE
highlight Normal guibg=NONE ctermbg=NONE
highlight EndOfBuffer guibg=NONE ctermbg=NONE
highlight LineNr guibg=NONE ctermbg=NONE

" Disable arrow keys for navigation
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" Easier split navigation (aligns with Tmux)
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Fuzzy find files [fzf.vim]
nnoremap <C-p> :Files!<CR>

" Show LSP completion [coc.nvim]
inoremap <silent><expr> <c-space> coc#refresh()

" Use enter to confirm completion menu item [coc.nvim]
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"

" Use tab + shift-tab for navigating through completion [coc.nvim]
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Italicize word [vim-surround]
nmap <Leader>i T<Space>veS_
let g:surround_{char2nr('i')} = "_\r_"

" Embolden word [vim-surround]
nmap <Leader>b T<Space>veS*gvS*
let g:surround_{char2nr('b')} = "**\r**"

" Show LSP actions menu for selected [coc.nvim]
function! s:cocActionsOpenFromSelected(type) abort
  execute 'CocCommand actions.open ' . a:type
endfunction
xmap <silent> <leader>a :<C-u>execute 'CocCommand actions.open ' . visualmode()<CR>
nmap <silent> <leader>a :<C-u>set operatorfunc=<SID>cocActionsOpenFromSelected<CR>g@

nmap <Leader>d :CocCommand docthis.documentThis<CR>

" Close XML-like tags in JS and JSX files (i.e. for React) [closetag]
let g:closetag_filenames = '*.js,*.jsx'

" vimwiki config [vimwiki]
let g:vimwiki_list = [
  \ { 'path': '~/content', 'syntax': 'markdown', 'ext': '.md', 'index': 'main'}
\]
let g:vimwiki_global_ext = 0    " Do not use vimwiki for every Markdown file
let g:vimwiki_auto_header = 1   " Add a header to new files
let g:vimwiki_header_type = '#' " Use Markdown headers

" Avoid truncation in Git commit message subject lines + improve body readability
autocmd FileType gitcommit set tw=72 cc=51,+1

" Auto-source this file it’s written
augroup vimrc
  autocmd!
  autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END

" Improve auto closing of stuff for files with JSX [delimitMate]
autocmd FileType javascript,javascriptreact,typescript,typescriptreact let b:delimitMate_matchpairs = "(:),[:],{:}"

" Format code when leaving insert mode [coc.nvim]
autocmd InsertLeave * call CocActionAsync('format') " The wildcard might be a bad idea. Uses prettier if installed, also respects editorconfig

" Highlight symbol when idling cursor on a word [coc.nvim]
autocmd CursorHold * silent call CocActionAsync('highlight')

" Use JSONC for config files that support it [jsonc]
autocmd BufNewFile,BufRead {.eslintrc,tsconfig}.json set syntax=json filetype=jsonc

" Use Ripgrep + FZF for fuzzy searching code (source: FZF plugin README) [fzf.vim + ripgrep]
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction
command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)
