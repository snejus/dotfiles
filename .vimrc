set nocompatible " sorry vi

""" Vim-plug installation
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

""" Plugins, sorted by how much worse my life would be without it
call plug#begin('~/.vim/bundle/')

" fzf <3
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" asynchronous linting / formatting engine
Plug 'w0rp/ale' ", { 'on': 'ALEToggle' }

" git. Manage with :G
Plug 'tpope/vim-fugitive'

" minds camelCase and snake_case separators when moving across words
Plug 'chaoren/vim-wordmotion'

" autocomplete. Need to open vim from venv for project-specific setup
Plug 'Valloric/YouCompleteMe', { 'for': 'python' }

" Comment out lines with gcc / gc
Plug 'tpope/vim-commentary'

" tree explorer
Plug 'preservim/nerdtree'

" python indentation handled correctly
Plug 'vim-scripts/indentpython.vim', { 'for': 'python' }

" easier handling of parentheses / curly brackets etc.
Plug 'tpope/vim-surround'

" vcs signs (+, -, ~) in the gutter
Plug 'mhinz/vim-signify'

" close buffer but leave window open
Plug 'moll/vim-bbye'

" f but 2 characters
Plug 'justinmk/vim-sneak'

" amazing .rST toolset - a bit heavy on keymaps so needs some custom patching
Plug 'Rykka/riv.vim' " , { 'for': 'rst' } causes problems if not loaded initially

" automatically updating rST server
Plug 'Rykka/InstantRst', { 'for': 'rst' }

" window resize mappings
Plug 'talek/obvious-resize'

" extra syntax highlighting
Plug 'cespare/vim-toml'               " toml
Plug 'raimon49/requirements.txt.vim'  " requirements.txt

" ctags dashboard
Plug 'liuchengxu/vista.vim'

" statusline plugins
Plug 'vim-airline/vim-airline'
" Plug 'itchyny/lightline.vim'
" Plug 'rbong/vim-crystalline'

" pattern matches highlighted incrementally
Plug 'haya14busa/incsearch.vim'

" gruvbox colourscheme. Edit gruvbox/colors/gruvbox.vim to customise
Plug 'gruvbox-community/gruvbox'

" vim cheatsheet - invoked with Leader + ?
Plug 'lifepillar/vim-cheat40'

Plug 'martinda/Jenkinsfile-vim-syntax'

" notes
Plug 'vimwiki/vimwiki'

Plug 'majutsushi/tagbar'

call plug#end()

""" Non-plugin Options
set autoindent            " automatic identation
set autoread              " auto reload changed files
set background=dark       " dark theme
set backspace=eol,indent,start
set belloff=all           " turn off the error bell
set cursorline            " highlights current line
set encoding=utf8
set expandtab             " tabs are converted to spaces
set foldmethod=indent     " fold by indents - that's python specific
set foldlevel=99          " fold level of a closed fold
set hlsearch              " highlight search results
set incsearch             " show search results as you type
set laststatus=2          " always show statusline
set listchars=extends:→   " show arrow if line continues behind right window boundary
set listchars+=precedes:← " same
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
set splitbelow            " m:Lore intuitive adding of new splits
set splitright            " more intuitive adding of new splits
set synmaxcol=200         " only syntax-highlight the first 100 characters in a line
set t_Co=256              " the amount of colours used
set t_vb=                 " remove terminal / vim visual bell connection
set tabstop=4             " 4 space tabs by default
set termguicolors         " in reality, increases the contrast a bit
set ttyfast               " fast terminal vrummmmmmm
set wildmenu              " tab autocomplete in command mode
set wildignore=*.o,*~,*.pyc,*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store  " Ignore compiled files

if has("gui_running")
    set guioptions-=m         " remove menu
    set guioptions-=T         " remove toolbar
    set guioptions-=e         " remove tabpages
    set guioptions-=r         " remove righthand toolbar
    set guioptions-=L         " remove lefthand toolbar when split
endif

let mapleader = "\<Space>"

" set this if want to run vim from its own venv
"let g:python3_host_prog='~/.local/share/dephell/venvs/.vim-pA95/bin/python3'

" vim distribution plugins
let g:loaded_matchparen = 1
let g:loaded_matchit = 1

" comments in italics
highlight Comment cterm=italic gui=italic

" colourscheme - options must be set before loading it
let g:gruvbox_contrast_dark='medium'
let g:gruvbox_sign_column='bg0'
let g:gruvbox_hls_highlight='blue'
colorscheme gruvbox

" speed up syntax highlighting. A bit hacky but some glitches are fine with me
" aug vimrc
"     au!
"     au BufWinEnter,Syntax * syn sync minlines=1 maxlines=1
" aug END

" this beauty remembers where the cursor was when file was closed and returns to the same position
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

" filetype specific stuff
au BufNewFile,BufRead *.rest setlocal filetype=rst
au BufNewFile,BufRead *.ts setlocal filetype=typescript
au BufNewFile,BufRead *.tsx setlocal filetype=typescript
au BufNewFile,BufRead *.vue setf vue
"au BufNewFile,BufRead *.wiki setf wiki
au Filetype typescript setlocal ts=2 sw=2
au Filetype vue setlocal ts=2 sw=2
au Filetype vuejs setlocal ts=2 sw=2
au Filetype html setlocal ts=2 sw=2
au Filetype javascript setlocal ts=2 sw=2
au Filetype yml setlocal ts=2 sw=2
au Filetype yaml setlocal ts=2 sw=2
au Filetype vimwiki setlocal ts=2 sw=2

" disable syntax highlighting for html files
au! BufReadPost *.html set syntax=off

" remove trailing whitespace on save
au BufWritePre * %s/\s\+$//e

""" Plugin: NERDTree

" au vimenter * NERDTree " open on startup
" au vimenter * wincmd p " goes together with the above, at least in macvim
let NERDTreeWinSize=40
let NERDTreeMinimalUI=1
let g:NERDTreeDirArrowExpandable = ''
let g:NERDTreeDirArrowCollapsible = ''

" Remap: nerdtree toggle
nmap <Leader>ng :NERDTreeToggleVCS<CR>
nmap <Leader>nt :NERDTreeToggle<CR>

""" Plugin: fzf

" Remap:
" Files in project repo
nmap <silent> <Leader>o :Files<CR>
nmap <silent> <Leader>O :Files!<CR>

" Files across all projects
nmap <silent> \ :Files ~/Documents/projects<CR>

" In-file search (project files)
nmap <silent> <Leader>; :Ag<CR>

" Commits
nmap <silent> <Leader>cs :Commits<CR>

" Tags - need to have them generated firstly though
nmap <silent> <Leader>i :Tags<CR>

""" Plugin: ALE

" vale needs some additional external setup
call ale#linter#Define('text', {
\   'name': 'vale',
\   'executable': 'vale',
\   'command': 'vale --config ~/Documents/misc/vale/.vale.ini --output=JSON %t',
\   'callback': 'ale#handlers#vale#Handle',
\})

let g:ale_linters = {
\    'dockerfile': ['hadolint'],
\    'javascript': ['eslint'],
\    'markdown':   ['vale'],
\    'php':        ['phpstan', 'phpcs'],
\    'python':     ['flake8', 'mypy', 'pylint', 'vale', 'vulture'],
\    'rst':        ['rstcheck', 'vale'],
\    'text':       ['vale'],
\    'vue':        ['eslint'],
\}
let g:ale_fixers = {
\    'htmldjango': ['prettier'],
\    'javascript': ['eslint'],
\    'json':       ['fixjson'],
\    'python':     ['black', 'isort'],
\    'vue':        ['eslint'],
\}

let g:ale_linters_explicit=1

let g:ale_warn_about_trailing_whitespace=0
let g:ale_warn_about_trailing_blank_lines=0

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

let g:ale_sign_error = 'Ϟ'
let g:ale_sign_warning = '×'

" Remap: navigate between errors
nmap <silent> <Leader>k <Plug>(ale_previous_wrap)
nmap <silent> <Leader>j <Plug>(ale_next_wrap)

nmap <Leader>t :ALEToggle<CR>
nmap <Leader>rs :ALEReset<CR>
nmap <Leader>a :ALELint<CR>
nmap <Leader>f :ALEFix<CR>

""" Plugin: YouCompleteMe

let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_min_num_of_chars_for_completion = 2

" Remap:
nmap <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>

""" Plugin: incsearch
let g:incsearch#auto_nohlsearch = 1

" Remap:
nmap /  <Plug>(incsearch-forward)
nmap ?  <Plug>(incsearch-backward)
nmap g/ <Plug>(incsearch-stay)
nmap n  <Plug>(incsearch-nohl-n)
nmap N  <Plug>(incsearch-nohl-N)
nmap *  <Plug>(incsearch-nohl-*)
nmap #  <Plug>(incsearch-nohl-#)
nmap g* <Plug>(incsearch-nohl-g*)
nmap g# <Plug>(incsearch-nohl-g#)

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

" Remap:
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

" Remap:
map f <Plug>Sneak_s
map F <Plug>Sneak_S

""" Plugin: Vista

" Remap:
nmap <Leader>v :Vista!!<CR>

let g:vista_fzf_preview = ['right:50%']


""" Plugin: Vimwiki

hi VimwikiHeader2 guifg=#b16286 gui=bold
hi VimwikiHeader1 guifg=#cc241d gui=bold
hi VimwikiHeader3 guifg=#d65d0e gui=bold

let g:vimwiki_key_mappings =
\ {
\   'all_maps': 1,
\   'global': 0,
\   'headers': 1,
\   'text_objs': 1,
\   'table_format': 1,
\   'table_mappings': 1,
\   'lists': 1,
\   'links': 0,
\   'html': 0,
\   'mouse': 0,
\ }
let g:vimwiki_hl_cb_checked = 1

let g:vimwiki_list = [{
\   'auto_export': 1,
\   'auto_toc': 1,
\   'auto_tags': 1,
\   'path': '$HOME/vimwiki',
\   'template_path': '$HOME/vimwiki/templates',
\   'template_default': 'def_template',
\   'template_ext': '.html'}]

let g:vimwiki_valid_html_tags = 'b,i,s,u,sub,sup,kbd,br,hr, pre, script'
"let g:vimwiki_listsyms = '✗○◐●✓'

" Remap:
nmap <Leader>1 <Plug>VimwikiIndex
nmap <Leader>2 <Plug>VimwikiTabIndex
nmap <Leader>3 <Plug>VimwikiUISelect
nmap <Leader>4 <Plug>VimwikiGoto
nmap <Leader>9 <Plug>Vimwiki2HTMLBrowse
nmap <Leader>0 <Plug>VimwikiAll2HTML

""" Plugin: tagbar

let g:tagbar_type_vimwiki = {
          \   'ctagstype':'vimwiki'
          \ , 'kinds':['h:header']
          \ , 'sro':'&&&'
          \ , 'kind2scope':{'h':'header'}
          \ , 'sort':1
          \ , 'ctagsbin':'~/vimwiki/vwtags.py'
          \ , 'ctagsargs': 'default'
          \ }

""" Key remaps

" match parens with backspace
xmap <BS> %
nmap <BS> %

" more easier accessible search
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

" new line from any position while typing - doesn't work in terminal vim
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

""" vimrc folding setup

set mle
"""" vim:fdm=expr:fdl=0
"""" vim:fde=getline(v\:lnum)=~'^""'?'>'.(matchend(getline(v\:lnum),'""*')-2)\:'='
