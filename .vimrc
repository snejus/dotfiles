set nocompatible  " be iMproved, required
filetype off      " required - no compatibility with the ol' vi
syntax on         " syntax colouring

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" My plugins:
Plugin 'https://github.com/Valloric/YouCompleteMe' " var-names autocompl
Plugin 'morhetz/gruvbox' " gruvbox theme
Plugin 'https://github.com/scrooloose/nerdtree.git' " file explorer
Plugin 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plugin 'junegunn/fzf.vim' " intelligent file search
Plugin 'itchyny/lightline.vim' " bottom info banner
Plugin 'lifepillar/vim-cheat40' " cheatsheet: <leader>?
Plugin 'w0rp/ale' " linter
Plugin 'vim-python/python-syntax' " python syntax highlighting
Plugin 'davidhalter/jedi-vim' " intelligent python autocompletion
Plugin 'posva/vim-vue' " Vue.js syntax highlighting
Plugin 'eugen0329/vim-esearch'
"Plugin 'Quramy/tsuquyomi' " TypeScript autocompletion
"Plugin 'leafgarland/typescript-vim' " TypeScript syntax highlighting
"Plugin 'mhinz/vim-startify'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

let g:python_highlight_all = 1 " python-syntax all highl features enabled

set autoread " auto reload changed files
set wildmenu " tab autocomplete in command mode
set nowrap " don't wrap long lines
set listchars=extends:→   " Show arrow if line continues rightwards
set listchars+=precedes:← " Show arrow if line continues leftwards
set hlsearch " highlight search results
set incsearch " show search results as you type
set cursorline " highlights current line
set modifiable " buffers are modifiable
set autoindent " automatic identation
set shiftwidth=4 " < and > commands tab 4 spaces
set tabstop=4 " indent is 4 spaces
set term=ansi " fixes some arrowkey navigation problems
set number " displays line numbers
set expandtab " tabs are converted to spaces
set splitbelow " more intuitive adding of new splits
set splitright " more intuitive adding of new splits

" Comments in italics
highlight Comment cterm=italic gui=italic

" identation according to filetype
autocmd Filetype html setlocal ts=2 sw=2 expandtab
autocmd Filetype vue setlocal ts=2 sw=2 expandtab
autocmd Filetype javascript setlocal ts=2 sw=2 expandtab
autocmd Filetype yml setlocal ts=2 sw=2 expandtab
autocmd Filetype yaml setlocal ts=2 sw=2 expandtab
autocmd BufNewFile,BufRead *.ts setlocal filetype=typescript
autocmd BufNewFile,BufRead *.tsx setlocal filetype=typescript
autocmd Filetype typescript setlocal ts=2 sw=2 expandtab
au BufNewFile,BufRead *.vue setf vue

" make sure vue syntax highlighting doesn't confuse itself
autocmd Filetype vue syntax sync fromstart
" visual mode selection colours sorted
highlight Visual cterm=reverse ctermbg=NONE

" solve temp file must be edited... problem with crontab
autocmd filetype crontab setlocal nobackup nowritebackup

colorscheme gruvbox
set t_Co=256 " ensure gui colorscheme work in the terminal

" autocmd vimenter * NERDTree " open nerdtree automatically upon vim startup
" autocmd vimenter * wincmd p " goes together with the above. If this line is
" enabled and the above is not, it will break macvim god knows why

" Key remaps
" nicer navigation between splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" leader remap
let mapleader = "\<Space>"

" toggles nerdtree split on the left (CTRL + JK)
nmap <C-J><C-K> :NERDTreeToggle<CR>

" Nerdtree settings
let NERDTreeWinSize=40
let NERDTreeMinimalUI=1
let NERDTreeDirArrows=1

" Remove trailing whitespaces
autocmd BufWritePre * %s/\s\+$//e

" fzf settings:
" clicking ; intelligently recursively searches for files from the dir vim is
" opened
" clicking \ intelligently recursively searches for files across all the
" project directories
map ; :Files<CR>
map \ :Files /Users/sarunasnejus/Documents/brainlabs<CR>


" ALE settings
let g:ale_linters = {
\    'php': ['phpstan', 'phpcs'],
\    'python': ['mypy', 'flake8']
\}
let g:ale_fixers = {
\    'python': ['black', 'add_blank_lines_for_python_control_statements', 'isort'],
\    'javascript': ['prettier'],
\    'vue': ['prettier', 'eslint'],
\}
let g:ale_fix_on_save=1
" Only run specified linters
let g:ale_linters_explicit=1
"let g:ale_python_mypy_executable=1

let g:ale_php_phpstan_executable="./vendor/bin/phpstan"
let g:ale_php_phpstan_level=7

let g:ale_php_phpcs_executable="/Users/sarunasnejus/.composer/vendor/bin/phpcs"
let g:ale_php_phpcs_standard="PSR2"

" ESearch settings
let g:esearch = {
\ 'adapter':          'ag',
\ 'backend':          'vimproc',
\ 'out':              'win',
\ 'batch_size':       1000,
\ 'use':              ['visual', 'hlsearch', 'last'],
\ 'default_mappings': 1,
\}

" YouCompleteMe settings
let g:ycm_filetype_specific_completion_to_disable = {
      \ 'javascript': 1,
      \ 'python': 1
      \}
