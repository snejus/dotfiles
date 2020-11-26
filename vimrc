set encoding=utf8
scriptencoding utf-8

" {{{ Vim-plug installation
if empty(glob('$HOME/.vim/autoload/plug.vim'))
  silent !curl -fLo "$HOME/.vim/autoload/plug.vim" --create-dirs "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  au pluginstall VimEnter * PlugInstall --sync | source $MYVIMRC
endif
"}}}
" {{{ Plugins, sorted by how much worse my life would be without them
call plug#begin('~/.vim/bundle/')

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'w0rp/ale' ", { 'on': 'ALEToggle' }
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'chaoren/vim-wordmotion'
Plug 'Valloric/YouCompleteMe', { 'for': 'python' }
Plug 'tpope/vim-commentary'
Plug 'preservim/nerdtree'
Plug 'tpope/vim-surround'

Plug 'cespare/vim-toml', { 'for': 'toml' }
Plug 'aklt/plantuml-syntax', { 'for': 'plantuml' }
Plug 'raimon49/requirements.txt.vim', { 'for': 'requirements' }
Plug 'martinda/Jenkinsfile-vim-syntax', { 'for': 'Jenkinsfile' }

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'moll/vim-bbye' " close buffer but leave window open

Plug 'snejus/black', { 'for': 'python' }
Plug 'vim-scripts/indentpython.vim', { 'for': 'python' }
Plug 'ervandew/supertab'
Plug 'talek/obvious-resize'

Plug 'snejus/vim-deus'

Plug 'godlygeek/tabular', { 'for': 'markdown' }
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'mzlogin/vim-markdown-toc', { 'for': 'markdown' }

Plug 'chrisbra/unicode.vim'   " Unicode explorer
Plug 'wakatime/vim-wakatime'  " Stats

Plug 'itchyny/calendar.vim'

call plug#end()
" }}}

" {{{ Options: if has
if has('nvim')
  let g:python3_host_prog = '~/.local/pipx/venvs/black/bin/python'
  let g:loaded_python_provider = 0
else
  set ttyfast
  set noesckeys
  set t_Co=256              " the number of colours used
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  let &t_Co=256
endif

if has('gui_running')
  set guioptions-=m         " remove menu
  set guioptions-=M         " remove menu
  set guioptions-=g         " remove menu
  set guioptions-=t         " remove menu
  set guioptions-=T         " remove toolbar
  set guioptions-=e         " remove tabpages
  set guioptions-=r         " remove righthand toolbar
  set guioptions-=L         " remove lefthand toolbar when split
  set guioptions+=c         " console diags instead of popups
  set guifont=IBM\ Plex\ Mono\ Thin\ 12
endif

if has('persistent_undo')
  silent ! [[ -d ~/.cache/vimundo ]] || mkdir ~/.cache/vimundo
  set undodir=~/.cache/vimundo
  set undofile
endif

if has('autocmd')
  filetype plugin indent on
endif
" }}}
" {{{ Options: :options
set autoindent
set autoread
set background=dark
set backspace=eol,indent,start
set belloff=all
set clipboard=unnamedplus
set cursorline
set expandtab
set fillchars=stl:\ ,stlnc:\ ,vert:\ ,fold:-
set foldmethod=marker
set foldlevel=0
set history=1000
set hlsearch
set incsearch
set laststatus=2
set listchars=tab:>\ ,trail:-,extends:→,precedes:←,nbsp:+
set modifiable
set noshowmode
set noshowcmd
set noswapfile
set nowrap
set nowritebackup
set scrolloff=999
set shiftwidth=4
set shortmess+=F
set sidescroll=1          " in nowrap mode, scroll horizontally by 1 char, not half of the screen
set spelllang=en_gb
set splitbelow
set splitright
set synmaxcol=1000
set tabstop=4
set termguicolors
set termencoding=utf-8
set timeoutlen=500
set updatetime=100        " update faster asynchronously
set wildmenu              " tab autocomplete in command mode
set wildignore=*.o,*~,*.pyc,*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store  " Ignore compiled files
" }}}
" {{{ Options: misc

let mapleader = "\<Space>"
" comments in italics
" highlight Comment cterm=italic
let g:deus_italic=1
let g:deus_sign_column='bg0'  " same colour as the primary bg - potentially move to the theme
let g:deus_termcolors=256
colorscheme deus

" colourscheme - options must be set before loading it
" let g:gruvbox_contrast_dark='medium'
" let g:gruvbox_sign_column='bg0'
" let g:gruvbox_hls_highlight='blue'
" colorscheme gruvbox

" this beauty remembers where the cursor was when file was closed and returns to the same position
" }}}
" {{{ Options: automation groups
" Remap:
function! g:Set_format_options()
  if &filetype ==# 'python'
    nnoremap <Leader>f :ALEFix<CR> :Black<CR>
  else
    nnoremap <Leader>f :ALEFix<CR>
  endif
endfunction

augroup automator
  au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif
  au BufWritePre * %s/\s\+$//e
  au BufEnter * call g:Set_format_options()
augroup END

augroup sudowrite
  au FileChangedRO * setlocal buftype=acwrite noreadonly
augroup END

augroup missingft
  au BufNewFile,BufRead *.rest setlocal filetype=rst
  au BufNewFile,BufRead *.conf setlocal filetype=conf
  au Filetype html setlocal ts=2
  au Filetype markdown setlocal ts=2 sw=2 spell wrap lbr tw=80 foldlevel=99
  au FileType requirements setlocal commentstring=#\ %s
  au Filetype Jenkinsfile setlocal ts=2 sw=2
  au Filetype vim setlocal ts=2 sw=2
  au FileType xdefaults setlocal commentstring=!%s
  au Filetype yml setlocal ts=2 sw=2
  au Filetype yaml setlocal ts=2 sw=2
augroup END

" }}}

" {{{ Plugin: NERDTree

let NERDTreeWinSize=40
let NERDTreeMinimalUI=1
let g:NERDTreeDirArrowExpandable = ''
let g:NERDTreeDirArrowCollapsible = ''

" Remap: nerdtree toggle
nmap <Leader>ng :NERDTreeToggleVCS<CR>
nmap <Leader>nt :NERDTreeToggle<CR>
" }}}
" {{{ Plugin: fzf
let g:fzf_preview_window = ''
let g:fzf_buffers_jump = 1

" Remap:
nmap <silent> <Leader>o  :Files<CR>
nmap <silent> <Leader>;  :Ag<CR>
nmap <silent> <Leader>i  :Buffers<CR>
nmap <silent> <Leader>u  :History<CR>
nmap <silent> <Leader>cs :Commits<CR>
nmap <silent> <Leader>cb :BCommits<CR>
" nmap <silent>         \  :Files ~/Documents/projects<CR>
" nmap <silent> <Leader>\  :Files ~/Documents/misc<CR>
" nmap <silent> <Leader>=  :Files ~/stubs<CR>
" nmap <silent> <Leader>+  :Files ~/.ref/puml/stdlib<CR>
" }}}
" {{{ Plugin: ALE

let g:ale_linters = {
\   'ansible':    ['ansible-lint'],
\   'bash':       ['shellcheck'],
\   'dockerfile': ['hadolint'],
\   'html':       ['tidy'],
\   'javascript': ['eslint'],
\   'json':       ['jsonlint'],
\   'lua':        ['luacheck'],
\   'markdown':   ['mdl'],
\   'php':        ['phpstan', 'phpcs'],
\   'python':     ['flake8', 'mypy', 'pylint'],
\   'rst':        ['rstcheck', 'vale'],
\   'sh':         ['shellcheck'],
\   'text':       ['vale'],
\   'yaml':       ['yamllint'],
\   'vim':        ['vint'],
\   'vue':        ['eslint'],
\   'zsh':        ['shellcheck'],
\}
let g:ale_fixers = {
\   'htmldjango': ['prettier'],
\   'html':       ['tidy'],
\   'javascript': ['eslint'],
\   'json':       ['fixjson', 'prettier'],
\   'python':     ['isort'],
\   'markdown':   ['prettier'],
\   'vue':        ['eslint'],
\}
let g:ale_python_flake8_options = '--jobs 2'
let g:ale_python_pylint_options = '--jobs 2'
" let g:ale_javascript_prettier_options = '--tab-width 4'

let g:ale_disable_lsp=1
let g:ale_sign_highlight_linenrs=1

let g:ale_linters_explicit=1
let g:ale_warn_about_trailing_whitespace=0
let g:ale_warn_about_trailing_blank_lines=0

let g:ale_set_loclist=0
let g:ale_set_quickfix=0
let g:ale_fix_on_save=0
let g:ale_lint_on_save=0
let g:ale_lint_on_enter=0
let g:ale_lint_on_text_changed=0
let g:ale_lint_on_insert_leave=0
let g:ale_lint_on_filetype_changed=0

let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %code%: %s [%severity%]'
let g:ale_sign_error = 'x'
let g:ale_sign_warning = '- '

" Remap: navigate between errors
nmap <silent> <Leader>ek <Plug>(ale_previous_wrap)
nmap <silent> <Leader>ej <Plug>(ale_next_wrap)
nmap <Leader>y :execute "let g:ale_linters_ignore = ['pylint']"
nmap <Leader>Y :execute "let g:ale_linters_ignore = []"

nmap <Leader>at :ALEToggle<CR>
nmap <Leader>ai :ALEInfo<CR>
nmap <Leader>aj :ALELint<CR>
" }}}
" {{{ Plugin: Black

let g:black_virtualenv='~/.local/pipx/venvs/black/'
" }}}
" {{{ Plugin: YouCompleteMe

let g:ycm_server_python_interpreter='python3'
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_min_num_of_chars_for_completion = 2
let g:ycm_auto_hover = 'CursorHold'

" Remap:
nmap <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>
nmap <leader>ht :YcmCompleter GetType<CR>
nmap <leader>hg <plug>(YCMHover)
" }}}
" {{{ Plugin: lightline / airline

let g:airline_theme='deus'
let g:airline_symbols_ascii = 1
let g:airline_powerline_fonts = 1
let g:airline_highlighting_cache = 1
let g:airline_skip_empty_sections = 1
let g:airline#extensions#fzf#enabled = 1
let g:airline#extensions#branch#enabled = 1
" }}}
" {{{ Plugin: obvious-resize
let g:obvious_resize_default = 2

" Remap:
map <silent> <C-Up> :<C-U>ObviousResizeUp<CR>
map <silent> <C-Down> :<C-U>ObviousResizeDown<CR>
map <silent> <C-Left> :<C-U>ObviousResizeLeft<CR>
map <silent> <C-Right> :<C-U>ObviousResizeRight<CR>
" }}}
" {{{ Plugin: Bbye
" Bdelete - closes, but leaves <C-O> available
" Bwipeout - closes properly
" Remap: close buffer, leave window open
nmap <Leader>bq :Bwipeout<CR>
" }}}
" {{{ Plugin: requirements.txt syntax
let g:requirements#detect_filename_pattern = 'requirementsfrompoetry'
" }}}
" {{{ Plugin: plantuml-syntax

let g:plantuml_executable_script='java -jar ~/.shed/puml/plantuml.jar $@'

" Remap:
nnoremap <F5> :w<CR> :make<CR>
" }}}
" {{{ Plugin: vim-gitgutter

nmap <Leader>hd <Plug>(GitGutterPreviewHunk)
nmap <Leader>hn <Plug>(GitGutterNextHunk)<Plug>(GitGutterPreviewHunk)
nmap <Leader>hp <Plug>(GitGutterPrevHunk)
nmap <Leader>ha <Plug>(GitGutterStageHunk)
nmap <Leader>hu <Plug>(GitGutterUndoHunk)

nmap <Leader>hh :GitGutterLineHighlightsToggle<CR>
nmap <Leader>hf :GitGutterFold<CR>

let g:gitgutter_preview_win_floating = 1
let g:gitgutter_grep = 'ag --nocolor'
let g:gitgutter_git_executable = '/usr/bin/git'
let g:gitgutter_highlight_lines = 0
let g:gitgutter_map_keys = 0

" }}}
" {{{ Plugin: Supertab

let g:SuperTabDefaultCompletionType = 'context'
" }}}
" {{{ Plugin: Tabular and vim-markdown

inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction

" let g:vim_markdown_folding_style_pythonic = 1
let g:vim_markdown_strikethrough = 1
let g:vim_markdown_new_list_item_indent = 2
let g:vim_markdown_no_default_key_mappings = 1
" }}}
" {{{ Plugin: Calendar
let g:calendar_google_calendar = 1
let g:calendar_google_task = 0


let g:calendar_view = 'week'
let g:calendar_first_day = 'monday'

let g:calendar_google_api_key = '...'
let g:calendar_google_client_id = $CAL_CLIENT_ID
let g:calendar_google_client_secret = $CAL_CLIENT_SECRET
" }}}
" {{{ Plugin: Unicode
let g:Unicode_no_default_mappings = v:true
"}}}
"{{{ Syntax: rst
let g:rst_syntax_code_list = {
\ 'bash': ['bash'],
\ 'dockerfile': ['dockerfile'],
\ 'json': ['json'],
\ 'python': ['python'],
\ 'sh': ['sh', 'shell'],
\ 'sql': ['sql'],
\ 'vim': ['vim'],
\ 'xhtml': ['xhtml'],
\ }
" :%s/\(\<[^`" ]\([a-z.]\+_\)\+[a-z]\+\>\)[^"(`]\?$/``\1``/g  codify aaa_aaa

" }}}
" {{{ Key remaps
" unmap <Leader>un
" unmap q

nnoremap Q :q!<CR>
nnoremap q <Nop>

nnoremap <Leader>G :Git<CR>

" match parens with backspace
xmap <BS> %
nmap <BS> %

" easier navigation between splits
nmap <C-J> <C-W><C-J>
nmap <C-K> <C-W><C-K>
nmap <C-L> <C-W><C-L>
nmap <C-H> <C-W><C-H>

" Folds
nmap <Leader>- za
nmap <Leader><CR> zMzvzt

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

" open directory under the current buffer
map <Leader>cd :lcd %:p:h<CR>:pwd<CR>

" there's also <Leader>bq defined that shuts off buffer but leaves
" window open
nmap <Leader>w :write<CR>
nmap <Leader>W :w! !sudo tee %<CR>
nmap <Leader>q :quit<CR>

" put command output into new buffer
nmap g! :<C-u>put=execute('')<Left><Left>

" tab management
nmap <silent> tn :<C-U>tabnew<CR>
nmap <silent> gt :<C-U>tabnext<CR>
nmap <silent> gb :<C-U>tabprevious<CR>

" show highlighting group for a word under cursor
nmap <silent> <Leader>cc
  \ :echo 'hi<'.synIDattr(synID(line('.'), col('.'), 1), 'name')
  \ . '> trans<'.synIDattr(synID(line('.'), col('.'), 0), 'name') . '> lo<'
  \ . synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name') . '>'<CR>

" navigation in the quickfix window
nmap <Leader>ne :cn<CR>
nmap <Leader>np :cp<CR>

" nmap <silent> <leader>dd :exe \":profile start profile.log"<cr>:exe \":profile func *"<cr>:exe \":profile file *"<cr>
" nmap <silent> <leader>dp :exe \":profile pause"<cr>
" nmap <silent> <leader>dc :exe \":profile continue"<cr>
" nmap <silent> <leader>dq :exe \":profile pause"<cr>:noautocmd qall!<cr>
" }}}
