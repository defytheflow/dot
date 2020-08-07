
" File:     init.vim
" Created:  30.12.2019
" Author:   Artyom Danilov (@defytheflow)


" vars {{{
let g:mapleader = '\'
let g:python3_host_prog = '/usr/bin/python3'
let &path = '/usr/include/,/usr/lib/gcc/x86_64-linux-gnu/8/include'
"}}}

" plugins {{{

" vim-plug {{{
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  au VimEnter * PlugInstall --sync | source $MYVIMRC
endif
"}}}

call plug#begin($HOME . '/.config/nvim/plugged/')

" airline {{{
Plug 'vim-airline/vim-airline'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#hunks#non_zero_only = 1
Plug 'vim-airline/vim-airline-themes'
let g:airline_theme='luna'
"}}}

" ale {{{
Plug 'dense-analysis/ale'
let g:ale_linters = {
\  'c': ['ccls', 'clang'],
\  'python': ['pyls', 'flake8'],
\}
let g:ale_fixers = {
\ 'c': ['clang-format'],
\ 'html': ['prettier'],
\ 'javascript': ['prettier'],
\ 'python': ['isort', 'yapf'],
\}
let g:ale_fix_on_save = 1
let g:ale_python_auto_pipenv = 1
"}}}

" better-whitespace {{{
Plug 'ntpeters/vim-better-whitespace'
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1
let g:strip_whitespace_confirm=0
"}}}

" camel-case-motion {{{
Plug 'bkad/CamelCaseMotion'
let g:camelcasemotion_key = '<leader>'
"}}}

" closetag {{{
Plug 'alvan/vim-closetag'
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.jsx,*.tsx,*js'
let g:closetag_filetypes = 'html,xhtml,phtml,jsx,tsx'
"}}}

" ctrlp {{{
Plug 'ctrlpvim/ctrlp.vim'
let g:ctrlp_show_hidden = 1
let g:ctrlp_custom_ignore = {
\ 'dir':  '\v[\/]\.(git|hg|svn|venv)$',
\ 'file': '\v\.(exe|so|dll)$',
\ 'link': 'some_bad_symbolic_links',
\ }
"}}}

" deoplete {{{
Plug 'shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
let g:deoplete#enable_at_startup = 1
"}}}

" indentline {{{
Plug 'Yggdroot/indentLine'
let g:indentLine_char =  '¦'
let g:indentLine_leadingSpaceChar='·'
let g:indentLine_leadingSpaceEnabled='1'
"}}}

" nerdtree {{{
Plug 'preservim/nerdtree'
let NERDTreeShowHidden = 1
let NERDTreeMinimalUI  = 1  " Disable '?' help at the top
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeIgnore=['__pycache__', '.git', '.mypy_cache', '.idea']
let NERDTreeBookmarksFile = stdpath('data') . '/NERDTreeBookmarks'
Plug 'jistr/vim-nerdtree-tabs'
let g:nerdtree_tabs_open_on_console_startup = 2
let g:nerdtree_tabs_autoclose = 0
Plug 'ryanoasis/vim-devicons'
let g:WebDevIconsUnicodeDecorateFolderNodes = v:true
"}}}

" snippets {{{
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
let g:UltiSnipsExpandTrigger = '<tab>'
"}}}

" text-object {{{
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-entire'
Plug 'michaeljsmith/vim-indent-object'
"}}}

" tpope {{{
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-fugitive'
"}}}

" miscellaneous {{{
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/goyo.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'unblevable/quick-scope'
Plug 'inkarkat/vim-ReplaceWithRegister'
Plug 'sheerun/vim-polyglot'
Plug 'vim-scripts/a.vim'
Plug 'miyakogi/seiya.vim'
Plug 'majutsushi/tagbar'
Plug 'kshenoy/vim-signature'
Plug 'ThePrimeagen/vim-be-good', {'do': './install.sh'}
"}}}

call plug#end()
"}}}

" settings {{{

" backup {{{
set noswapfile
set backup
set backupdir=${XDG_DATA_HOME}/nvim/backup
if !isdirectory(&backupdir)
  call mkdir(&backupdir, 'p', 0700)
endif
set undofile
set undodir=${XDG_DATA_HOME}/nvim/undo
if !isdirectory(&undodir)
  call mkdir(&undodir, 'p', 0700)
endif
"}}}

" colors {{{
" set termguicolors
set background=dark
try
  colo codedark
catch /^Vim\%((\a\+)\)\=:E185/
  colo koehler
endtry
"}}}

" commandline {{{
set history=1000                    " history size.
set wildmode=longest,list,full      " autocompletion.
"}}}

" indent {{{
filetype plugin indent on
set expandtab          " convert tabs to spaces.
set softtabstop=4      " number of spaces inserted per tab.
set shiftwidth=4       " number of columns to shift with << and >>.
set smartindent        " indent on braces and previous indentation level.
au BufNewFile,BufRead *.html,*.css,*.js,*.jsx,*.ts,*.tsx setlocal shiftwidth=2 softtabstop=2
au FileType sh  setlocal shiftwidth=2 softtabstop=2
au FileType vim setlocal shiftwidth=2 softtabstop=2
" }}}

" textwidth {{{
set nowrap
set textwidth=90
set formatoptions+=t   " wrap text using &textwidth.
set colorcolumn=+0     " display a color-column to indicate textwidth.
"}}}

" search {{{
set hlsearch           " highlight search matches.
set incsearch          " highlight while typing search pattern.
set smartcase          " ignore case if search pattern is lowercase.
"}}}

" statusline {{{
set ruler              " show the line and column number of cursor.
set showcmd            " show last typed command.
set noshowmode         " do not display mode in status line.
set laststatus=2       " always display a status line.
"}}}

" miscellaneous {{{
syntax enable
set foldmethod=marker
set clipboard+=unnamedplus          " use system clipboard.
set cursorline                      " show cursorline.
set number relativenumber           " show relative line numbers.
set mouse=a                         " enable mouse in all modes.
set splitbelow splitright           " change splits position.
set list listchars=tab:>-,trail:-   " display tabs and trailing whitespace.
"}}}

"}}}

" functions {{{

" AutoCommentToggle {{{
fun! AutoCommentToggle()
  if matchstr(&formatoptions, 'cro') == 'cro'
    setlocal formatoptions-=cro
  else
    setlocal formatoptions+=cro
  endif
endfun
"}}}

" ColorColumnToggle {{{
fun! ColorColumnToggle()
  if &cc == ''
    set colorcolumn=+1  " Highlight column after 'textwidth'
  else
    set colorcolumn=
  endif
endfun
"}}}

" CursorColumnToggle {{{
fun! CursorColumnToggle()
  if &cuc == 1
    set nocursorcolumn
  else
    set cursorcolumn
  endif
endfun
"}}}

" CursorLineToggle {{{
fun! CursorLineToggle()
  if &cul == 1
    set nocursorline
  else
    set cursorline
  endif
endfun
"}}}

"}}}

" mappings {{{

" ale {{{
nmap <silent> gd :ALEGoToDefinition<CR>
nmap <silent> gf :ALEFindReferences<CR>
nmap <silent> ]g :ALEPrevious<CR>
nmap <silent> [g :ALENext<CR>
nmap <silent> K  :ALEHover<CR>
"}}}

" buffers {{{
nnoremap <silent> <tab>   :bnext<CR>
nnoremap <silent> <S-tab> :bprev<CR>
"}}}

" functions {{{
nnoremap <silent> <leader>x  :call AutoCommentToggle()<CR>
nnoremap <silent> <leader>cc :call ColorColumnToggle()<CR>
nnoremap <silent> <leader>cl :call CursorLineToggle()<CR>
nnoremap <silent> <leader>ck :call CursorColumnToggle()<CR>
"}}}

" plugins {{{
nnoremap <silent> <leader>f :Goyo<CR>
nnoremap <silent> <leader>t :TagbarToggle<CR>
nnoremap <silent> <leader>T :NERDTreeTabsToggle<CR>
"}}}

" shift {{{
vnoremap < <gv
vnoremap > >gv
"}}}

" vim {{{
nnoremap <silent> <leader>ev :edit   $MYVIMRC<CR>
nnoremap <silent> <leader>sv :source $MYVIMRC<CR>
"}}}

" miscellaneous {{{
nnoremap <silent> <C-n> :nohl<CR>
nnoremap <silent> <C-s> :w<CR>
nnoremap S :%s//g<Left><Left>
nnoremap Y y$
nnoremap <Space> za
tnoremap <Esc> <C-\><C-n>
"}}}

"}}}

" autocmds {{{
" jump to the last position when reopening a file.
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
" disable highlighting matching parentheses.
au VimEnter * :NoMatchParen
" disable auto-commenting.
au BufEnter * set fo-=c fo-=r fo-=o
" install pluggins.
au VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)')) | PlugInstall --sync | q | endif
"}}}
