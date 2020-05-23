set nocompatible " sorry vi

""" Vim-plug installation
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

""" Plugins
call plug#begin('~/.vim/bundle/')

" git integration
Plug 'tpope/vim-fugitive'

" autocomplete. need to start gvim / vim from a virtualenv for best results
Plug 'Valloric/YouCompleteMe', { 'for': 'python' }

" gruvbox colorscheme. edit gruvbox / colors / gruvbox.vim to customise
Plug 'gruvbox-community/gruvbox'

" file tree on the left
Plug 'preservim/nerdtree'

" fzf <3 <3 <3
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" vim cheatsheet - invoked with Leader + ?
Plug 'lifepillar/vim-cheat40'

" ALE asynchronous linting / formatting engine
Plug 'w0rp/ale' ", { 'on': 'ALEToggle' }

" vim startup screen
Plug 'mhinz/vim-startify'

" minds camelCase and snake_case separators when moving across words
Plug 'chaoren/vim-wordmotion'

" python indentation handled correctly
Plug 'vim-scripts/indentpython.vim', { 'for': 'python' }

" highlights pattern matches incrementally
Plug 'haya14busa/incsearch.vim'

" vcs signs (+, -, ~) in the gutter
Plug 'mhinz/vim-signify'

" amazing .rST toolset
Plug 'Rykka/riv.vim' " , { 'for': 'rst' } causes problems if not loaded initially

" automatically updating rST server
Plug 'Rykka/InstantRst', { 'for': 'rst' }

" Comment out lines with gcc / gc
Plug 'tpope/vim-commentary'

" close buffer but leave window open
Plug 'moll/vim-bbye'

" resizing mappings
Plug 'talek/obvious-resize'

" statusline plugins
Plug 'vim-airline/vim-airline'
" Plug 'itchyny/lightline.vim'
" Plug 'rbong/vim-crystalline'

" syntax highlighting
Plug 'cespare/vim-toml'               " toml
Plug 'raimon49/requirements.txt.vim'  " requirements.txt

" f but 2 characters
Plug 'justinmk/vim-sneak'

" easier parentheses movements
Plug 'tpope/vim-surround'

" ctags dashboard
Plug 'liuchengxu/vista.vim'
if !has('nvim')
    "Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
    "set runtimepath-=/home/sarunas/.vim/bundle/semshi
endif

call plug#end()


""" Non-plugin Options
set autoindent            " automatic identation
set autoread              " auto reload changed files
set background=dark       " dark theme
set belloff=all           " turn off the error bell
set cursorline            " highlights current line
set encoding=utf8         "
set expandtab             " tabs are converted to spaces
set foldmethod=indent     " fold by indents - it's python after all
set foldlevel=99          " fold level of a closed fold
set hlsearch              " highlight search results
set incsearch             " show search results as you type
set laststatus=2          " always show statusline
set lazyredraw            " do not redraw screen while macros are executing
set listchars=extends:→   " show arrow if line continues behind right window boundary
set listchars+=precedes:← " same
set mat=4               " how long to show the matching brackets for
set modifiable            " buffers are modifiable
set noequalalways         " split windows sizes always split in half
set nowritebackup         " do not backup - git is used anyways
set noshowmode            " get rid of --INSERT-- in the bottom
set noshowcmd             " do not display last command in the bottom
set nowrap                " don't wrap long lines
set noswapfile            " do not use swapfiles
set number relativenumber " displays hybrid line numbers
set signcolumn=yes        " always show sign column
set scrolloff=999         " keep the cursor centered
set shiftwidth=4          " < and > commands tab 4 spaces
set shortmess+=F          " get rid of the file name displayed in the command line bar
set showmatch             " show matching bracket for a bit
set splitbelow            " m:Lore intuitive adding of new splits
set splitright            " more intuitive adding of new splits
set t_vb=                 " remove terminal / vim visual bell connection
set ttyfast               " fast terminal boiiiii
set wildmenu              " tab autocomplete in command mode
set whichwrap+=<,>,h,l,b  " automatically move to the upper / lower line when hittint left / right
set wildignore=*.o,*~,*.pyc,*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store  " Ignore compiled files

if has("gui_running")
    set guioptions-=m         " remove menu
    set guioptions-=T         " remove toolbar
    set guioptions-=e         " remove tabpages
    set guioptions-=r         " remove righthand toolbar
    set guioptions-=L         " remove lefthand toolbar when split
endif

let mapleader = "\<Space>"

"let g:python3_host_prog='~/.local/share/dephell/venvs/.vim-pA95/bin/python3'

" vim distribution plugins
let g:loaded_matchparen = 1
let g:loaded_matchit = 1

highlight Comment cterm=italic gui=italic
" comments in italics

" sorts out visual mode selection colours
highlight Visual cterm=reverse ctermbg=NONE

" solves temp file must be edited... problem with crontab
au filetype crontab setlocal nobackup nowritebackup

set t_Co=256 " ensure gui colorschemes work in the terminal
"set termguicolors " same - some days one looks better than another
let g:gruvbox_contrast_dark='medium'
let g:gruvbox_sign_column='bg0'
let g:gruvbox_hls_highlight='blue'
colorscheme gruvbox

" speed up syntax highlighting - also fucks it up sometimes. Need to run
" :syntax on / syn on to solve
aug vimrc
    au!
    au BufWinEnter,Syntax * syn sync minlines=100 maxlines=100
aug END

" this beauty remembers wh;re I was the last time you edited the file, and returns to the same position
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

" recognise files
au BufNewFile,BufRead *.rest setlocal filetype=rst
au BufNewFile,BufRead *.ts setlocal filetype=typescript
au BufNewFile,BufRead *.tsx setlocal filetype=typescript
au BufNewFile,BufRead *.vue setf vue
au Filetype typescript setlocal ts=2 sw=2
au Filetype vue setlocal ts=2 sw=2
au Filetype vuejs setlocal ts=2 sw=2
au Filetype html setlocal ts=2 sw=2
au Filetype javascript setlocal ts=2 sw=2
au Filetype yml setlocal ts=2 sw=2
au Filetype yaml setlocal ts=2 sw=2

" disable syntax highlighting for html files
au! BufReadPost *.html set syntax=off

" remove trailing whitespaces on save
au BufWritePre * %s/\s\+$//e

""" Plugin: NERDTree
let NERDTreeWinSize=40
let NERDTreeMinimalUI=1
let NERDTreeDirArrows=1
" au vimenter * NERDTree " open nerdtree automatically on vim startup
" au vimenter * wincmd p " goes together with the above. If this line is
" enabled and the above is not, it will break macvim god knows why
let g:NERDTreeDirArrowExpandable = ''
let g:NERDTreeDirArrowCollapsible = ''

" Remap: nerdtree toggle
nmap <Leader>ng :NERDTreeToggleVCS<CR>
nmap <Leader>nt :NERDTreeToggle<CR>


""" Plugin: fzf


" Remaps:
" Search for files in project repo
nmap <silent> <Leader>o :Files<CR>
nmap <silent> <Leader>O :Files!<CR>
nmap <silent> <Leader>cs :Commits<CR>
nmap <silent> <Leader>b :Buffers<CR>
nmap <silent> <Leader>i :Tags<CR>

" Search for files across all projects
map \ :Files /home/sarunas/Documents/projects<CR>

" Search for matches within files in the project
map <Leader>; :Ag<CR>


""" Plugin: ALE

" call ale#linter#Define('text', {
" \   'name': 'vale',
" \   'executable': 'vale',
" \   'command': 'vale
" \       --config /home/sarunas/Documents/misc/vale/.vale.ini
" \       --output=JSON %t',
" \   'callback': 'ale#handlers#vale#Handle',
" \})
let g:ale_warn_about_trailing_whitespace=0
let g:ale_warn_about_trailing_blank_lines=0

let g:ale_linters = {
\    'php': ['phpstan', 'phpcs'],
\    'python': ['mypy', 'flake8', 'pylint'],
\    'vue': ['eslint'],
\    'javascript': ['eslint'],
\    'rst': ['rstcheck', 'vale'],
\    'markdown': ['vale'],
\    'text': ['vale'],
\}

let g:ale_fixers = {
\    'python': ['black', 'isort'],
\    'javascript': ['eslint'],
\    'vue': ['eslint'],
\    'htmldjango': ['prettier'],
\}
let g:ale_linters_explicit=1

let g:ale_fix_on_save=0
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter=0
let g:ale_lint_on_save=0
let g:ale_lint_on_insert_leave=0
let g:ale_lint_on_enter=0
let g:ale_lint_on_filetype_changed=0

let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %code%: %s [%severity%]'

let g:ale_set_loclist=0
let g:ale_set_quickfix=0

" Remap: navigate between errors
nmap <silent> <Leader>k <Plug>(ale_previous_wrap)
nmap <silent> <Leader>j <Plug>(ale_next_wrap)

nmap <Leader>t :ALEToggle<CR>
nmap <Leader>rs :ALEReset<CR>
nmap <Leader>a :ALELint<CR>
nmap <Leader>f :ALEFix<CR>
""" Plugin: YouCompleteMe

let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_min_num_of_chars_for_completion = 1

" Remap:
nmap <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>

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

""" Plugin: lightline / airline
"let g:lightline = {
"      \ 'active': {
"      \   'left': [ [ 'mode', 'paste' ],
"      \             [ 'gitbranch', 'readonly', 'filename', 'modified', 'commondir' ] ],
"      \ },
"      \ 'component_function': {
"      \   'gitbranch' : 'FugitiveHead',
"      \ },
"      \ }
"let g:airline#extensions#whitespace#enabled = 0
"let g:airline_highlighting_cache = 0

""" Plugin: obvious-resize
let g:obvious_resize_default = 2

" Remap: windows resizing
map <silent> <C-Up> :<C-U>ObviousResizeUp<CR>
map <silent> <C-Down> :<C-U>ObviousResizeDown<CR>
map <silent> <C-Left> :<C-U>ObviousResizeLeft<CR>
map <silent> <C-Right> :<C-U>ObviousResizeRight<CR>


""" Plugin: Bbye
" Bdelete - closes, but leaves <C-O> available
" Bwipeout - closes properly
" Remap: close buffer, leave window open
nmap <Leader>bq :Bwipeout<CR>

""" Plugin: requirements.txt syntax
let g:requirements#detect_filename_pattern = 'requirementsfrompoetry'

""" Plugin: Sneak

map f <Plug>Sneak_s
map F <Plug>Sneak_S

""" Plugin: Vista

nmap <Leader>v :Vista!!<CR>
let g:vista_fzf_preview = ['right:50%']
let g:vista#renderer#enable_icon = 1
let g:vista#renderer#icons = {
\   "function": "\uf794",
\   "variable": "\uf71b",
\  }

""" Key remaps

" match parens with backspace
xmap <BS> %
nmap <BS> %

nmap s /

" easier navigation between splits
nmap <C-J> <C-W><C-J>
nmap <C-K> <C-W><C-K>
nmap <C-L> <C-W><C-L>
nmap <C-H> <C-W><C-H>

" folds
nmap <CR> za
nmap <Space><CR> zMzvzt

" line-wise movement
nmap gh g0
nmap gl g$

" yank till the end of line
nmap Y y$

" re-select block after indenting in visual mode
xmap < <gv
xmap > >gv|

" actually gc and gcc aren't that convenient
vmap <C-c> gc
nmap <C-c> gcc

" drag lines vertically and indent
nmap <S-l> :m-2<CR>
nmap <S-h> :m+<CR>
vmap <S-l> :m'<-2<CR>gv=gv
vmap <S-h> :m'>+<CR>gv=gv

" open directory under the current buffer
map <Leader>cd :lcd %:p:h<CR>:pwd<CR>

" new line from any position - doesn't work in terminal vim
if has("gui_running")
    imap <S-CR> <C-o>o
endif

" there's also <Leader>bq defined that shuts off buffer but leaves
" window open
nmap <Leader>w :write<CR>
nmap <Leader>q :quit<CR>

" put command output into new buffer
nmap g! :<C-u>put=execute('')<Left><Left>

" tab management
nmap <silent> tn :<C-U>tabnew<CR>
nmap <silent> gt :<C-U>tabnext<CR>
nmap <silent> gb :<C-U>tabprevious<CR>

" clipboard you've been finally hacked
nmap <Leader>p "+p
vmap <Leader>y "+y

" show highlighting group for a word under cursor
nmap <silent> <Leader>h
	\ :echo 'hi<'.synIDattr(synID(line('.'), col('.'), 1), 'name')
	\ . '> trans<'.synIDattr(synID(line('.'), col('.'), 0), 'name') . '> lo<'
	\ . synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name') . '>'<CR>

" nmap <silent> <leader>dd :exe ":profile start profile.log"<cr>:exe ":profile func *"<cr>:exe ":profile file *"<cr>
" nmap <silent> <leader>dp :exe ":profile pause"<cr>
" nmap <silent> <leader>dc :exe ":profile continue"<cr>
" nmap <silent> <leader>dq :exe ":profile pause"<cr>:noautocmd qall!<cr>


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
"set runtimepath-=/home/sarunas/.vim/bundle/sparkup
"set runtimepath-=/home/sarunas/.vim/bundle/vim-fugitive
"set runtimepath-=/home/sarunas/.vim/bundle/vim-signify
"set runtimepath-=/home/sarunas/.vim/bundle/vim-wordmotion
"set runtimepath-=/home/sarunas/.vim/bundle/YouCompleteMe
"set runtimepath-=/usr/share/vim/vim80/syntax/rst.vim

""" Folding

"""" vim:fdm=expr:fdl=0
"""" vim:fde=getline(v\:lnum)=~'^""'?'>'.(matchend(getline(v\:lnum),'""*')-2)\:'='

