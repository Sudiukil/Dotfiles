" --- Modules ---

" -- Vundle --

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'        	"Plugin installer

Plugin 'tomasr/molokai'					"Monokai colorscheme
Plugin 'itchyny/lightline.vim'          "Status line

Plugin 'scrooloose/nerdcommenter'       "Easy commenting
Plugin 'terryma/vim-multiple-cursors'   "Multiple cursors

Plugin 'wakatime/vim-wakatime'			"WakaTime integration

call vundle#end()

" -- Modules config --

" - LightLine -

set laststatus=2 "Always visible

" --- General ---

set nocp "Vim mode only
set bs=2 "Backspace available in insert mode
set mouse=a "Enable mouse in normal mode
set wildmenu "Better command completion
set scrolloff=5 "Line scrolling offset

" -- Display, colors, syntax --

set nu "Line numbering

set t_Co=256 "Terminal colors
colorscheme molokai

syntax on "Syntax highlighting

set showmatch "Show matching braces

set pastetoggle=<F12> "Toggle paste mode

" -- Indent --

filetype indent on "Auto indent
set autoindent
set shiftwidth=2

set expandtab "Spaces as tabs
set tabstop=2 "Tabs size

" -- Search options --

set incsearch "Dynamic cursor while searching
set ignorecase
set smartcase

" -- Completion options --

filetype plugin on "Completion support
set omnifunc=syntaxcomplete#Complete "Omni completion

" -- Mapping (normal mode) --

" - Global -

nmap j gj
nmap k gk

let mapleader = ","

" - Tabs management -

map <ESC>[a <S-up>
map <ESC>[b <S-down>
map <ESC>[c <S-right>
map <ESC>[d <S-left>

nmap <S-down> :tabnew<CR>
nmap <S-right> gt
nmap <S-left> gT
nmap <S-up><S-left> :tabmove -1<CR>
nmap <S-up><S-right> :tabmove +1<CR>

" - Windows management -

map <ESC>Oa <C-up>
map <ESC>Ob <C-down>
map <ESC>Oc <C-right>
map <ESC>Od <C-left>

nmap <C-v> :vsplit<CR>
nmap <C-h> :split<CR>
nmap <C-w> :close<CR>
nmap <C-up> :wincmd k<CR>
nmap <C-down> :wincmd j<CR>
nmap <C-left> :wincmd h<CR>
nmap <C-right> :wincmd l<CR>

nmap W+ :wincmd ><CR>
nmap W- :wincmd <<CR>
nmap W= :wincmd =<CR>

" - Modules -

nmap <C-e> :lopen<CR>

" - Edit and reload Vim config

nmap <leader>vc :vsplit ~/.vimrc<CR>
nmap <leader>vr :source ~/.vimrc<CR>

" -- Spell checking --

autocmd FileType text setlocal spell spelllang=fr
autocmd FileType markdown setlocal spell spelllang=fr
autocmd FileType tex setlocal spell spelllang=fr

" --- Other ---

autocmd FileType tex map <F5> :w<CR>:!buildtex %<CR><CR>
autocmd FileType markdown map <F5> :w<CR>:!gimli %<CR><CR>
