set nocompatible

""" Vim-plug installation
if empty(glob("$HOME/.vim/autoload/plug.vim"))
  silent !curl -fLo "$HOME/.vim/autoload/plug.vim" --create-dirs "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

""" Plugins, sorted by how much worse my life would be without them
call plug#begin('~/.vim/bundle/')

" fzf <3
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" asynchronous linting / formatting engine
Plug 'w0rp/ale' ", { 'on': 'ALEToggle' }

" git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'


" minds camelCase and snake_case separators when moving across words
Plug 'chaoren/vim-wordmotion'

" autocomplete. Need to open vim from venv for project-specific setup
Plug 'Valloric/YouCompleteMe', { 'for': 'python' }

" Comment out lines with gcc / gc
Plug 'tpope/vim-commentary'

" tree explorer
Plug 'preservim/nerdtree'

" easier handling of parentheses / curly brackets etc.
Plug 'tpope/vim-surround'

Plug 'vim-scripts/indentpython.vim', { 'for': 'python' }

" close buffer but leave window open
Plug 'moll/vim-bbye'

" f but 2 characters
Plug 'justinmk/vim-sneak'

" amazing .rST toolset - a bit heavy on keymaps so needs some custom patching
" Plug 'Rykka/riv.vim' " , { 'for': 'rst' } causes problems if not loaded initially

" window resize mappings
Plug 'talek/obvious-resize'

" extra syntax highlighting
Plug 'cespare/vim-toml', { 'for': 'toml' }
Plug 'aklt/plantuml-syntax', { 'for': 'plantuml' }
Plug 'raimon49/requirements.txt.vim', { 'for': 'requirements' }
Plug 'martinda/Jenkinsfile-vim-syntax', { 'for': 'Jenkinsfile' }

" ctags dashboard
" Plug 'liuchengxu/vista.vim'

" statusline plugins
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Plug 'itchyny/lightline.vim'
" Plug 'rbong/vim-crystalline'

" pattern matches highlighted incrementally
Plug 'haya14busa/incsearch.vim'

" notes
" Plug 'vimwiki/vimwiki'

" quick black
Plug 'psf/black', { 'for': 'python' }

Plug 'ervandew/supertab'

" Colourschemes
" Plug 'gruvbox-community/gruvbox'
Plug 'ajmwagar/vim-deus'

" Markdown support
Plug 'godlygeek/tabular', { 'for': 'markdown' }
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'mzlogin/vim-markdown-toc', { 'for': 'markdown' }

" Unicode explorer
Plug 'chrisbra/unicode.vim'

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Stats
Plug 'wakatime/vim-wakatime'

call plug#end()

""" Options: if has
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
  set guifont=IBM\ Plex\ Mono\ Medium\ 11
  " set guifont=ProFont\ For\ Powerline\ 13
  " set guifont=\Source\ Code\ Pro\ for\ Powerline\ 11
endif

if has('persistent_undo')
  silent ! [[ -d ~/.vim/backups ]] || mkdir ~/.vim/backups
  set undodir=~/.vim/backups
  set undofile
endif

if has('autocmd')
  filetype plugin indent on
endif

""" Options: 'set' defaults
set autoindent            " automatic identation
set autoread              " auto reload changed files
set background=dark       " dark theme
set backspace=eol,indent,start
set belloff=all           " turn off the error bell
set clipboard=unnamedplus " use clipboard as the primary register
set cursorline            " highlights current line
set encoding=utf8
set expandtab             " tabs are converted to spaces
set fillchars=stl:\ ,stlnc:\ ,vert:\ ,fold:- " don't add fillchars
set foldmethod=indent     " fold by indents - that's python specific
set foldlevel=99          " fold level of a closed fold
set history=1000
set hlsearch              " highlight search results
set incsearch             " show search results as you type
set laststatus=2          " always show statusline
set listchars=tab:>\ ,trail:-,extends:→,precedes:←,nbsp:+
set modifiable            " buffers are modifiable
set noequalalways         " split windows sizes always split in half
set noshowmode            " get rid of --INSERT-- in the bottom
set noshowcmd             " do not display last command in the bottom
set noswapfile            " do not use swapfiles
set nowrap                " don't wrap long lines
set nowritebackup         " do not backup - git is used anyways
" set number relativenumber " displays hybrid line numbers
" set signcolumn=no        " always show sign column
set scrolloff=999         " keep the cursor centered
set shiftwidth=4          " use 'tabstop' value for this
set shortmess+=F          " get rid of the file name displayed in the command line bar
set sidescroll=1          " in nowrap mode, scroll by horizontally by 1 char, not half of the screen
set spelllang=en_gb
set splitbelow            " consistent :sp
set splitright            " consistent :vs
set synmaxcol=1000        " only syntax-highlight the first 1000 characters in a line
set t_Co=256              " the number of colours used
set t_vb=                 " remove terminal / vim visual bell connection
set tabstop=4             " 4 space tabs by default
set termguicolors         " in reality, increases the contrast a bit
set ttyfast               " fast terminal vrummmmmmm
set updatetime=500        " update faster asynchronously
set wildmenu              " tab autocomplete in command mode
set wildignore=*.o,*~,*.pyc,*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store  " Ignore compiled files

""" Options: misc

let mapleader = "\<Space>"

" comments in italics
highlight Comment cterm=italic gui=italic

let g:deus_italic=1
let g:deus_sign_column='bg0'  " same colour as the primary bg - potentially move to the theme
colorscheme deus
let g:deus_termcolors=256

" colourscheme - options must be set before loading it
" let g:gruvbox_contrast_dark='medium'
" let g:gruvbox_sign_column='bg0'
" let g:gruvbox_hls_highlight='blue'
" colorscheme gruvbox

" this beauty remembers where the cursor was when file was closed and returns to the same position
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

""" Options: filetype-specific
" Remap:
function! g:Set_format_mapping()
  if &filetype ==# 'python'
    nnoremap <Leader>f :Black<CR>
  else
    nnoremap <Leader>f :ALEFix<CR>
  endif
endfunction

au BufEnter * call g:Set_format_mapping()
au BufNewFile,BufRead *.rest setlocal filetype=rst
au BufNewFile,BufRead *.ts setlocal filetype=typescript
au BufNewFile,BufRead *.tsx setlocal filetype=typescript
au BufNewFile,BufRead *.vue setf vue
au Filetype html setlocal ts=2
au Filetype javascript setlocal ts=2
au Filetype Jenkinsfile setlocal ts=2
au Filetype markdown setlocal ts=2 sw=2 spell wrap lbr tw=80
" au Filetype markdown setlocal wrap et lbr sw
au Filetype typescript setlocal ts=2
au Filetype vimwiki setlocal ts=2
au Filetype vue setlocal ts=2
au Filetype vim setlocal ts=2
au Filetype vuejs setlocal ts=2
au Filetype yml setlocal ts=2
au Filetype yaml setlocal ts=2
au FileType xdefaults setlocal commentstring=!%s
au FileType requirements setlocal commentstring=#\ %s

au FileChangedRO * setlocal buftype=acwrite noreadonly

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
let g:fzf_preview_window = ''
let g:fzf_buffers_jump = 1

" Remap:
nmap <silent> <Leader>o  :Files<CR>
nmap <silent> <Leader>;  :Ag<CR>
nmap <silent> <Leader>i  :Buffers<CR>
nmap <silent> <Leader>u  :History<CR>
nmap <silent> <Leader>cs :Commits<CR>
nmap <silent> <Leader>cb :BCommits<CR>
nmap <silent>         \  :Files ~/Documents/projects<CR>
nmap <silent> <Leader>\  :Files ~/Documents/misc<CR>
nmap <silent> <Leader>=  :Files ~/stubs<CR>
nmap <silent> <Leader>+  :Files ~/.ref/puml/stdlib<CR>

""" Plugin: ALE

let g:ale_linters = {
\   'ansible':    ['ansible-lint'],
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
\   'vue':        ['eslint'],
\   'zsh':        ['shellcheck'],
\}
let g:ale_fixers = {
\   'htmldjango': ['prettier'],
\   'html':       ['tidy'],
\   'javascript': ['eslint'],
\   'json':       ['fixjson', 'prettier'],
\   'vue':        ['eslint'],
\}
let g:ale_python_flake8_options = '--jobs 8'
let g:ale_python_pylint_options = '--jobs 8'
let g:ale_javascript_prettier_options = '--tab-width 4'

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
" Ϟ×
let g:ale_sign_error = '༒'
let g:ale_sign_warning = '൝ '

" Remap: navigate between errors
nmap <silent> <Leader>ek <Plug>(ale_previous_wrap)
nmap <silent> <Leader>ej <Plug>(ale_next_wrap)
nmap <Leader>y :execute "let g:ale_linters_ignore = ['pylint']"
nmap <Leader>Y :execute "let g:ale_linters_ignore = []"

nmap <Leader>at :ALEToggle<CR>
nmap <Leader>ai :ALEInfo<CR>
nmap <Leader>aj :ALELint<CR>


""" Plugin: Black

let g:black_virtualenv='~/.local/pipx/venvs/black/'

""" Plugin: YouCompleteMe

let g:ycm_server_python_interpreter='python3'
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_min_num_of_chars_for_completion = 2
let g:ycm_auto_hover = 'CursorHold'

" Remap:
nmap <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>
nmap <leader>ht :YcmCompleter GetType<CR>
nmap <leader>hg <plug>(YCMHover)

""" Plugin: incsearch
let g:incsearch#auto_nohlsearch = 1

" Remap:
nmap /  <Plug>(incsearch-forward)
nmap n  <Plug>(incsearch-nohl-n)
nmap N  <Plug>(incsearch-nohl-N)
nmap *  <Plug>(incsearch-nohl-*)
nmap #  <Plug>(incsearch-nohl-#)

""" Plugin: lightline / airline

if has("gui_running")
    let g:airline_powerline_fonts = 1
else
    let g:airline_powerline_fonts = 0
    let g:airline_symbols_ascii = 1
endif

let g:airline_theme='deus'
let g:airline_symbols_ascii = 1
let g:airline_highlighting_cache = 1
let g:airline_skip_empty_sections = 1
let g:airline#extensions#fzf#enabled = 1

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

" hi VimwikiHeader2 guifg=#b16286 gui=bold
" hi VimwikiHeader1 guifg=#cc241d gui=bold
" hi VimwikiHeader3 guifg=#d65d0e gui=bold

function! s:paths(root, name)
    let s:wiki_root = a:root.'/'.a:name
    return {'path': s:wiki_root.'/wiki', 'path_html': s:wiki_root.'/html'}
endfunction

let s:wikis_root = '~/wikis'
let s:wiki_settings = {
\ 'auto_toc': 1,
\ 'auto_tags': 1,
\ 'auto_export': 1,
\ 'auto_diary_index': 1,
\ 'auto_generate_tags': 1,
\ 'auto_generate_links': 1,
\ 'template_ext': '.html',
\ 'template_default': 'default',
\ 'template_path': s:wikis_root.'/html_templates'
\}
let s:wiki_1 = extend(deepcopy(s:wiki_settings), s:paths(s:wikis_root, 'main'))
let s:wiki_2 = extend(deepcopy(s:wiki_settings), s:paths(s:wikis_root, 'music'))
let g:vimwiki_list = [s:wiki_1, s:wiki_2]
let g:vimwiki_auto_chdir = 1
let g:vimwiki_global_ext = 0
let g:vimwiki_hl_cb_checked = 1
let g:vimwiki_key_mappings = {
\ 'html': 0,
\ 'links': 0,
\ 'mouse': 0,
\ 'lists': 1,
\ 'global': 0,
\ 'headers': 1,
\ 'all_maps': 1,
\ 'text_objs': 1,
\ 'table_format': 1,
\ 'table_mappings': 1
\}
let g:vimwiki_valid_html_tags = 'b,i,s,u,sub,sup,kbd,br,hr, pre, script'

" Remap:
nmap <Leader>1 <Plug>VimwikiIndex
nmap <Leader>2 <Plug>VimwikiTabIndex
nmap <Leader>3 <Plug>VimwikiUISelect
nmap <Leader>4 <Plug>VimwikiGoto
nmap <Leader>7 <Plug>Vimwiki2HTMLBrowse
nmap <Leader>8 <Plug>Vimwiki2HTML
nmap <Leader>9 <Plug>VimwikiAll2HTML
" nmap <C-N> <Plug>VimwikiFollowLink
nmap + <Plug>VimwikiNormalizeLink
vmap + <Plug>VimwikiNormalizeLinkVisual

vmap <Leader>vc <Plug>VimwikiCheckLinks
nmap <Leader>vr <Plug>VimwikiRebuildTags
nmap <Leader>vg <Plug>VimwikiGenerateTagLinks
nmap <Leader>vs <Plug>VimwikiSearchTags

nmap <Leader>dd <Plug>VimwikiMakeDiaryNote
nmap <Leader>dg <Plug>VimwikiGenerateTagLinks

""" Plugin: plantuml-syntax

let g:plantuml_executable_script='java -jar ~/.ref/puml/plantuml.jar $@'

" Remap:
nnoremap <F5> :w<CR> :make<CR>

""" Plugin: vim-gitgutter

let g:gitgutter_preview_win_floating=1
let g:gitgutter_grep = 'ag --nocolor'
let g:gitgutter_git_executable = '/usr/bin/git'

""" Plugin: Supertab

let g:SuperTabDefaultCompletionType = "context"


""" Plugin: Tabular and vim-markdown

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


""" Plugin: Ultisnips
let g:UltiSnipsExpandTrigger="<C-U>"
let g:UltiSnipsJumpForwardTrigger="<C-Y>"
let g:UltiSnipsJumpBackwardTrigger="<C-N>"
let g:UltiSnipsSnippetDirectories=["~/.vim/bundle/vim-snippets/UltiSnips"]

""" Syntax: rst

let g:rst_syntax_code_list = {
\ 'vim': ['vim'],
\ 'python': ['python'],
\ 'bash': ['bash'],
\ 'sh': ['sh', 'shell'],
\ 'xhtml': ['xhtml'],
\ }
""" Key remaps
" match parens with backspace
xmap <BS> %
nmap <BS> %

" more easily accessible search
nmap s /

" easier navigation between splits
nmap <C-J> <C-W><C-J>
nmap <C-K> <C-W><C-K>
nmap <C-L> <C-W><C-L>
nmap <C-H> <C-W><C-H>

" Folds
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

" open directory under the current buffer
map <Leader>cd :lcd %:p:h<CR>:pwd<CR>

" there's also <Leader>bq defined that shuts off buffer but leaves
" window open
nmap <Leader>w :write<CR>
nmap <Leader>fw :w! !sudo tee %<CR>
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

nmap <Leader>ne :cn<CR>
nmap <Leader>np :cp<CR>

" nmap <silent> <leader>dd :exe \":profile start profile.log"<cr>:exe \":profile func *"<cr>:exe \":profile file *"<cr>
" nmap <silent> <leader>dp :exe \":profile pause"<cr>
" nmap <silent> <leader>dc :exe \":profile continue"<cr>
" nmap <silent> <leader>dq :exe \":profile pause"<cr>:noautocmd qall!<cr>

""" vimrc folding setup

set mle
"""" vim:fdm=expr:fdl=0
"""" vim:fde=getline(v\:lnum)=~'^""'?'>'.(matchend(getline(v\:lnum),'""*')-2)\:'='
