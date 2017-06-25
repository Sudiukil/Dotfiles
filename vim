" --- Modules ---

" -- Vundle --

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'        	"Plugin installer

Plugin 'ctrlpvim/ctrlp.vim'             "FuzzyFinder
Plugin 'Yggdroot/indentLine'            "Indentation guides
Plugin 'itchyny/lightline.vim'          "Status line
Plugin 'scrooloose/nerdcommenter'       "Easy commenting
Plugin 'scrooloose/nerdtree'            "Tree file explorer
Plugin 'scrooloose/syntastic'           "Syntax checking
Plugin 'majutsushi/tagbar'              "Tags browser

Plugin 'alvan/vim-closetag'             "Autoclose HTML tags
Plugin 'xolox/vim-easytags'             "Easy tags highlighting
Plugin 'airblade/vim-gitgutter'         "Git diff integration
Plugin 'xolox/vim-misc'                 "Vim misc
Plugin 'tomasr/molokai'					"Monokai colorscheme
Plugin 'matze/vim-move'                 "vim-move
Plugin 'terryma/vim-multiple-cursors'   "Multiple cursors
Plugin 'sheerun/vim-polyglot'           "Language pack
Plugin 'tpope/vim-surround'             "Surround text with symbols
Plugin 'vim-scripts/vim-svngutter'      "SVN diff integration
Plugin 'rdnetto/YCM-Generator'          "YouCompleteMe extra config generator
Plugin 'Valloric/YouCompleteMe'         "Code completion

" Plugin dependencies (Debian):
" - git
" - build-essential
" - cmake
" - python-dev
" - clang
" - ctags

call vundle#end()

" -- Modules config --

" - IndentLine -

let g:indentLine_char = '|'
let g:indentLine_enabled = 0

" - LightLine -

set laststatus=2 "Always visible

" - Syntastic

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_python_python_exec = '/usr/bin/python3'
let g:syntastic_php_php_exec = '/opt/lampp/bin/php'
let g:syntastic_javascript_closurecompiler_path = '/usr/share/java/closure-compiler.jar'
let g:syntastic_javascript_checkers = ["closurecompiler"]

" Required for checking:
" - GCC + Clang (C/C++)
" - Python 2.x and/or 3.x (Python)
" - JDK (Java)
" - Tidy (HTML)
" - PHP (PHP)
" - Closure Compiler (JavaScript)
" - LaCheck (LaTeX)

" - Tagbar -

let g:tagbar_type_c = {
			\ 'kinds' : [
			\ 'd:macros:1:0',
			\ 'p:prototypes:1:0',
			\ 'g:enums',
			\ 'e:enumerators:0:0',
			\ 't:typedefs:0:0',
			\ 's:structs',
			\ 'u:unions',
			\ 'm:members:0:0',
			\ 'v:variables:0:0',
			\ 'f:functions',
			\ 'l:locals',
			\ ],
			\ }

" - YCM -

let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 0
let g:ycm_auto_trigger = 1
let g:ycm_autoclose_preview_window_after_insertion = 1

" - vim-closetag -

let g:closetag_filenames = "*.html,*.xhtml,*.md,*.php,*.ctp,*.xml,*.opml,*.nml"

" - vim-easytags -

autocmd FileType * set cpoptions+=d; "Creates tags file in working dir, not next to file
let g:easytags_async = 1 "Generate tags asynchronously
let g:easytags_events = ['BufReadPost', 'BufWritePost'] "Trigger tags generation on read and write
let g:easytags_resolve_links = 1

set tags=./.tags; "Tags file path for dynamic tags files
let g:easytags_dynamic_files = 1 "Use per working dir tags files
let g:easytags_by_filetype = '~/.vim/tags' "Use global per language tags files

" - vim-move -

let g:move_key_modifier = 'S'

" --- General ---

set nocp "Vim mode only
set bs=2 "Backspace available in insert mode
set mouse=n "Enable mouse in normal mode
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
set shiftwidth=4

set noexpandtab "Hard tabs
set tabstop=4 "Hard tabs size

"set expandtab "No hard tabs
"set softtabstop=4 "Soft tabs size

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

nmap <Space> :NERDTreeToggle<CR>
nmap <C-t> :TagbarToggle<CR>:wincmd w<CR>
nmap <C-g> :GitGutterToggle<CR>
nmap <C-i> :IndentLinesToggle<CR>
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
