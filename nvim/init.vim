scriptencoding utf-8

" File:     init.vim
" Created:  30.12.2019
" Author:   Artyom Danilov (@defytheflow)

let g:mapleader = '\'

if filereadable('/usr/bin/python3')
  let g:python3_host_prog = '/usr/bin/python3'
endif

let g:config_dir = has('nvim') ? stdpath('config') : glob('~/.vim')
let g:cache_dir  = has('nvim') ? stdpath('cache')  : glob('~/.vim')

let plug = config_dir . '/autoload/plug.vim'
if !filereadable(plug)
  let url = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  silent exec '!curl -fLo ' . plug . ' --create-dirs ' . url
endif

" plugins {{{
call plug#begin(config_dir . '/plugged')

Plug 'dense-analysis/ale'
runtime ale.vim

Plug 'bkad/CamelCaseMotion'
let g:camelcasemotion_key = '<leader>'

Plug 'alvan/vim-closetag'
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.jsx,*.tsx,*js'
let g:closetag_filetypes = 'html,xhtml,phtml,jsx,tsx'

Plug 'ctrlpvim/ctrlp.vim'
let g:ctrlp_show_hidden = 1
let g:ctrlp_custom_ignore = '.git\|.venv\|node_modules\|htmlcov\|plugged'
nnoremap <silent> gb :CtrlPBuffer<CR>

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
runtime deoplete.vim

Plug 'junegunn/vim-easy-align'
let g:easy_align_ignore_groups = []
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

Plug 'airblade/vim-gitgutter'
runtime gitgutter.vim

Plug 'junegunn/goyo.vim'
runtime goyo.vim

Plug 'machakann/vim-highlightedyank'
let g:highlightedyank_highlight_duration = 200

Plug 'Yggdroot/indentLine'
runtime lightline.vim

Plug 'itchyny/lightline.vim'

Plug 'preservim/nerdtree'
runtime nerdtree.vim

Plug 'frazrepo/vim-rainbow'
augroup vimrc_rainbow
  au!
  au FileType c,cpp,typescript,typescriptreact call rainbow#load()
augroup END

Plug 'vim-python/python-syntax'
let g:python_highlight_all = 1

Plug 'unblevable/quick-scope'
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

Plug 'vim-test/vim-test'
runtime test.vim

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsSnippetDirectories = ['UltiSnips', 'ultisnips']

Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-entire'
Plug 'michaeljsmith/vim-indent-object'
Plug 'jeetsukumaran/vim-pythonsense'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-fugitive'
Plug 'justinmk/vim-sneak'
Plug 'inkarkat/vim-ReplaceWithRegister'
Plug 'miyakogi/seiya.vim'
Plug 'chrisbra/Colorizer'
Plug 'jremmen/vim-ripgrep'
Plug 'cohama/lexima.vim'
Plug 'mboughaba/i3config.vim'
Plug 'tomasiser/vim-code-dark'
Plug 'tomasr/molokai'
Plug 'morhetz/gruvbox'
Plug 'chriskempson/base16-vim'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'MaxMEllon/vim-jsx-pretty'

call plug#end()
"}}}

" settings {{{
filetype plugin indent on
syntax enable

" backup.
set backup
set noswapfile
set backupdir=${HOME}/.local/share/nvim/backup
if !isdirectory(&backupdir)
  call mkdir(&backupdir, 'p', 0700)
endif

" colorscheme.
set termguicolors " use guifg/guibg instead of ctermfg/ctermfb in terminal.
set background=dark
try
  colorscheme base16-classic-dark
catch
  colorscheme koehler
endtry

" command-line.
set history=1000
set wildmenu
set wildmode=longest,list,full
set wildignore+=__pycache__,.mypy_cache,.pytest_cache
set wildignorecase

" fold.
set foldmethod=marker

" gui.
set guifont=FiraCode:h11

" indent.
set expandtab " convert <tab> key-presses to spaces.
set softtabstop=4
set shiftwidth=4
set autoindent
set smartindent

" search.
set hlsearch
set incsearch
set ignorecase
set smartcase

" splits.
set fillchars+=vert:┃
set splitbelow splitright

" status-line.
set ruler
set showcmd
set noshowmode
set laststatus=2 " always display status line.

" textwidth.
set nowrap
set textwidth=90
set formatoptions+=t " wrap text using &textwidth.
set colorcolumn=+0 " display a colorcolumn using &textwidth.
set scrolloff=10
set sidescrolloff=10

" undo.
set undofile
set undodir=${HOME}/.local/share/nvim/undo
if !isdirectory(&undodir)
  call mkdir(&undodir, 'p', 0700)
endif

" whitespace.
set list " show whitespace.
set listchars=tab:ᐅ-
set listchars+=trail:•
set listchars+=nbsp:⦸
set listchars+=extends:»
set listchars+=precedes:«

" miscellaneous.
set mouse=a
set hidden
set number relativenumber
set cursorline
set virtualedit=block " allow cursor to move where there is no text in visual block mode.
set clipboard+=unnamedplus " use system clipboard.
set lazyredraw " don't redraw while executing macros.
set timeoutlen=500
set noerrorbells visualbell t_vb=
"}}}
