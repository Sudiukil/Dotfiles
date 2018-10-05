" Colors config
colorscheme gruvbox
syntax on " Syntax highlighting

" Tabs/spaces config
set expandtab " Spaces as tab, as it should be
set tabstop=2 " Tab width shown
set shiftwidth=2 " Tab width inserted

" UI
set number " Line numbering
set cursorline " Highlight current line
filetype plugin on " Filetype detection
filetype indent on " Filetype detection
set wildmenu " Command menu autocompletion
set lazyredraw " Redraw UI less often
set showmatch " Show matching brackets and such

" Search
set incsearch " Incremental search (while typing)
set hlsearch " Highlight search matches
set ignorecase " Ignore case when searching
set smartcase " Use smart case when searching

" Backup config (disable backups)
set nobackup
set nowritebackup
set noswapfile

" Indent
set autoindent " Automatic indent
set smartindent " Smart indent

" Other
set mouse=a " Enable mouse
set backspace=2 " Allow backspace in insert mode
set colorcolumn=80 " Draw vertical line at 80 chars
set updatetime=100 " Update time
set autoread " Reload if file is modified from outside
set pastetoggle=<F12> " Toggle paste mode
set splitright " Put new window on the right when splitting vertically
set splitbelow " Same but bellow for horizontal

" Mappings
source ~/.vimrc.mappings

" fzf config
set rtp+=~/.vim/pack/git-plugins/start/fzf
" let g:fzf_action = {
"   \ 'return': 'tab split',
" \ }

" Airline config
let g:airline_theme = 'gruvbox'

" ALE
let b:ale_fixers = {
\ 'ruby': ['rubocop'],
\ }
let g:ale_completion_enabled = 1

" Plugins and help
packloadall
silent! helptags ALL
