set nocompatible " sorry vi

""" Vundle and plugins
filetype off " required for Vundle
set rtp+=~/.vim/bundle/Vundle.vim " set the runtime path to include Vundle and initialize
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'tpope/vim-fugitive'           " git integration
Plugin 'Valloric/YouCompleteMe'       " autocompletion
Plugin 'morhetz/gruvbox'              " gruvbox theme
Plugin 'preservim/nerdtree'       " file explorer
Plugin 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plugin 'junegunn/fzf.vim'             " intelligent fuzzy file search
Plugin 'junegunn/vim-easy-align'      " align columns around a char
Plugin 'itchyny/lightline.vim'        " bottom info banner
Plugin 'lifepillar/vim-cheat40'       " cheatsheet: <leader>?
Plugin 'w0rp/ale'                     " linter
Plugin 'vim-python/python-syntax'     " python syntax highlighting
Plugin 'mhinz/vim-startify'           " vim startup screen
Plugin 'chaoren/vim-wordmotion'       " correctly moves across camelCase and snake_case words
Plugin 'vim-scripts/indentpython.vim' " python indentation handled correctly
Plugin 'haya14busa/incsearch.vim'     " highlights pattern matches incrementally
Plugin 'mhinz/vim-signify'            " vcs signs (+, -, ~) in the gutter
Plugin 'Rykka/riv.vim'                " .rST toolset
Plugin 'Rykka/InstantRst'             " .rST server
"Plugin 'posva/vim-vue'                " Vue.js syntax highlighting
Plugin 'tpope/vim-commentary'               " Comment out lines with gcc / gc


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
syntax on         " syntax colouring
" To ignore plugin indent changes, instead use:
"filetype plugin on

""" Options
set autoread              " auto reload changed files
set wildmenu              " tab autocomplete in command mode
set nowrap                " don't wrap long lines
set listchars=extends:→   " Show arrow if line continues rightwards
set listchars+=precedes:← " Show arrow if line continues leftwards
set hlsearch              " highlight search results
set incsearch             " show search results as you type
set cursorline            " highlights current line
set modifiable            " buffers are modifiable
set autoindent            " automatic identation
set shiftwidth=4          " < and > commands tab 4 spaces
set tabstop=4             " indent is 4 spaces
set term=ansi             " fixes some arrowkey navigation problems
set number relativenumber " displays hybrid line numbers
set expandtab             " tabs are converted to spaces
set splitbelow            " more intuitive adding of new splits
set splitright            " more intuitive adding of new splits
set scrolloff=999         " keep the cursor centered
set foldmethod=indent
set foldlevel=99
set guioptions=           " remove scrollbars
set background=dark
set ttyfast
set re=1

" Comments in italics
highlight Comment cterm=italic gui=italic
"
" visual mode selection colours sorted
highlight Visual cterm=reverse ctermbg=NONE

" solve temp file must be edited... problem with crontab
au filetype crontab setlocal nobackup nowritebackup

colorscheme gruvbox
set t_Co=256 " ensure gui colorscheme works in the terminal

" Speed up syntax highlighting
aug vimrc
  au!
  au BufWinEnter,Syntax * syn sync minlines=100 maxlines=100
aug END

" Disable syntax highlighting for html files
au! BufReadPost *.html set syntax=off
" This beauty remembers where you were the last time you edited the file, and returns to the same position.
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

" identation according to filetype
au Filetype html setlocal ts=2 sw=2 expandtab
au Filetype htmldjango setlocal ts=2 sw=2 expandtab
au Filetype javascript setlocal ts=2 sw=2 expandtab
au Filetype yml setlocal ts=2 sw=2 expandtab
au Filetype yaml setlocal ts=2 sw=2 expandtab

" recognise typescript files
au BufNewFile,BufRead *.ts setlocal filetype=typescript
au BufNewFile,BufRead *.tsx setlocal filetype=typescript
au Filetype typescript setlocal ts=2 sw=2 expandtab
"
" recognise vue files
au BufNewFile,BufRead *.vue setf vue
au Filetype vue setlocal ts=2 sw=2 expandtab
au Filetype vuejs setlocal ts=2 sw=2 expandtab

" make sure vue syntax highlighting doesn't confuse itself
au Filetype vue syntax sync fromstart
au Filetype vuejs syntax sync fromstart
"
" Remove trailing whitespaces
au BufWritePre * %s/\s\+$//e


""" Key remaps
" nicer navigation between splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

let mapleader = "\<Space>"

""" Plugin: python-syntax
"let g:python_highlight_all = 1
let g:python_highlight_builtins = 1
let g:python_highlight_exceptions = 1
"let g:python_highlight_func_calls = 1
let g:python_highlight_class_vars = 1
"let g:python_highlight_string_formatting = 1
"let g:python_highlight_string_format = 1
"let g:python_highlight_string_templates = 1
"let g:python_highlight_indent_errors = 1
"let g:python_highlight_space_errors = 1
"let g:python_highlight_doctests = 1
"let g:python_highlight_operators = 1


""" Plugin: vim-easy-align
" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

""" Plugin: riv
"let g:riv_python_rst_hl=1

""" Plugin: NERDTree
let NERDTreeWinSize=40
let NERDTreeMinimalUI=1
let NERDTreeDirArrows=1
" au vimenter * NERDTree " open nerdtree automatically upon vim startup
" au vimenter * wincmd p " goes together with the above. If this line is
" enabled and the above is not, it will break macvim god knows why

" Remap: nerdtree toggle
nmap <C-J><C-K> :NERDTreeToggleVCS<CR>


""" Plugin: fzf
" clicking ; intelligently recursively searches for files from the dir vim is
" opened
" clicking \ intelligently recursively searches for files across all the
" project directories
" Remaps:
map ; :Files<CR>
map \ :Files /home/sarunas/Documents/projects<CR>
map <Leader>; :Ag<CR>


""" Plugin: ALE
" Remap: navigate between errors
nmap <silent> <C-m> <Plug>(ale_previous_wrap)
nmap <silent> <C-n> <Plug>(ale_next_wrap)

let g:ale_linters = {
\    'php': ['phpstan', 'phpcs'],
\    'python': ['mypy', 'flake8', 'pylint', 'pycodestyle'],
\    'vue': ['eslint'],
\    'javascript': ['eslint']
\}

let g:ale_fixers = {
\    'python': ['black', 'isort'],
\    'javascript': ['eslint'],
\    'vue': ['eslint'],
\    'htmldjango': ['prettier'],
\}

let g:ale_fix_on_save=1

" Only run specified linters
let g:ale_linters_explicit=1

"let g:ale_python_mypy_executable=1

"let g:ale_lint_on_text_changed = 'never'
"let g:ale_lint_on_insert_leave = 0
"let g:ale_lint_on_enter = 0
"
""" Plugin: YouCompleteMe
"let g:ycm_filetype_specific_completion_to_disable = {
"      \ 'javascript': 1,
"      \}

" Python with virtualenv support
" Point YCM to the Pipenv created virtualenv, if possible
" At first, get the output of 'pipenv --venv' command.
let pipenv_venv_path = system('pipenv --venv')
" The above system() call produces a non zero exit code whenever
" a proper virtual environment has not been found.
" So, second, we only point YCM to the virtual environment when
" the call to 'pipenv --venv' was successful.
" Remember, that 'pipenv --venv' only points to the root directory
" of the virtual environment, so we have to append a full path to
" the python executable.
if shell_error == 0
  let venv_path = substitute(pipenv_venv_path, '\n', '', '')
  let g:ycm_python_binary_path = venv_path . '/bin/python'
else
  let g:ycm_python_binary_path = 'python'
endif

let g:ycm_autoclose_preview_window_after_completion=1

" Remap:
nnoremap <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>


""" Plugin: incsearch
let g:incsearch#auto_nohlsearch = 1
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)

""" Plugin: vim-signify
let g:signify_vcs_list=["git"]


""" Disable plugins for troubleshooting
"set runtimepath-=/home/sarunas/.vim/bundle/ale
"set runtimepath-=/home/sarunas/.vim/bundle/command-t
"set runtimepath-=/home/sarunas/.vim/bundle/fzf
"set runtimepath-=/home/sarunas/.vim/bundle/fzf.vim
"set runtimepath-=/home/sarunas/.vim/bundle/gruvbox
"set runtimepath-=/home/sarunas/.vim/bundle/incsearch.vim
"set runtimepath-=/home/sarunas/.vim/bundle/indentpython.vim
"set runtimepath-=/home/sarunas/.vim/bundle/lightline.vim
"set runtimepath-=/home/sarunas/.vim/bundle/nerdtree
set runtimepath-=/home/sarunas/.vim/bundle/python-syntax " disabled due to slow rendering
"set runtimepath-=/home/sarunas/.vim/bundle/sparkup
"set runtimepath-=/home/sarunas/.vim/bundle/vim-fugitive
"set runtimepath-=/home/sarunas/.vim/bundle/vim-signify
"set runtimepath-=/home/sarunas/.vim/bundle/vim-wordmotion
"set runtimepath-=/home/sarunas/.vim/bundle/YouCompleteMe

""" Folding

"""" vim:fdm=expr:fdl=0
"""" vim:fde=getline(v\:lnum)=~'^""'?'>'.(matchend(getline(v\:lnum),'""*')-2)\:'='
