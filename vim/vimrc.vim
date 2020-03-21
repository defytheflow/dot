"                               _
"                        __   _(_)_ __ ___  _ __ ___
"                        \ \ / / | '_ ` _ \| '__/ __|
"                         \ V /| | | | | | | | | (__
"                          \_/ |_|_| |_| |_|_|  \___|
"
" ------------------------------------------------------------------------------
"  File: .vimrc
" ------------------------------------------------------------------------------
"  Modified: March 21, 2020
" ------------------------------------------------------------------------------
"  Author: Artyom Danilov
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
"                                   Pluggins
" ------------------------------------------------------------------------------

call plug#begin('~/.vim/plugged')

" Quotes, tags, parentheses
Plug 'tpope/vim-surround'
" Comments
Plug 'tpope/vim-commentary'
" File manipulation
Plug 'tpope/vim-eunuch'
" Git
Plug 'tpope/vim-fugitive'

" Parentheses
Plug 'frazrepo/vim-rainbow'
let g:rainbow_active = 1

" Colorschemes
Plug 'tomasr/molokai'
Plug 'gosukiwi/vim-atom-dark'
Plug 'drewtempelmeyer/palenight.vim'

" Status line
Plug 'itchyny/lightline.vim'
set laststatus=2

call plug#end()

" Man pages (Do not surround with quotes!)
runtime ftplugin/man.vim

" ------------------------------------------------------------------------------
"                               Global Variables
" ------------------------------------------------------------------------------

let g:mapleader = ';'

" ------------------------------------------------------------------------------
"                                 Indentation
" ------------------------------------------------------------------------------
" Overview:
"
" Each <Tab> is expanded into spaces (default - 4).
" Number of expanded spaces depends on the filetype.
" Text is wrapped at 80 characters.
"
" ------------------------------------------------------------------------------

" In Insert mode inserts spaces instead of <Tab>.
set expandtab

" Number of spaces inserted when <Tab> is pressed.
set softtabstop=4

" Does smart autoindenting when starting a new-line. Looks at the current line
" for braces and previous indentation level.
set smartindent

" Controls how many columns text is indented with the reindent operations
" (<< and >>) and automatic C-style indentation.  set shiftwidth=4
" Lines longer than the width of the window wrap and displaying continues
" on the next line.
set wrap

" Maximum width of the text that is being inserted.
set textwidth=80
set formatoptions+=t

augroup indentation
    " Assembly
    autocmd Filetype asm,s setlocal shiftwidth=4 softtabstop=4
    " Bash
    autocmd Filetype    sh setlocal shiftwidth=4 softtabstop=4
    " C
    autocmd Filetype     c setlocal shiftwidth=8 softtabstop=8
    " C++
    autocmd Filetype   cpp setlocal shiftwidth=4 softtabstop=4
    " HTML
    autocmd FileType  html setlocal shiftwidth=2 softtabstop=2
    " Python
    autocmd Filetype    py setlocal shiftwidth=4 softtabstop=4
augroup END

" ------------------------------------------------------------------------------
"                                 Highlighting
" ------------------------------------------------------------------------------
" Overview:
"
" Change terminal title.
" Highlight syntax.
" Display line numbers.
" Highlight matching brackets.
" Show trailing spaces and tabs.
" Highlight 81st column.
"
" ------------------------------------------------------------------------------

" Sets the terminal title (editing 'file')
" set title

" Compatibility with tmux colors
set t_Co=256
set background=dark

" Colorschemes
colo molokai
" colo atom-dark-256
" colo palenight
"
" Switches on syntax highlighting.
syntax enable

" Precedes each line with its line number.
set number

" When a bracket is inserted, briefly jumps to the matching one.
set showmatch

" A list of characters to show instead of tabs and trailing spaces.
set list listchars=tab:>-,trail:-

" ------------------------------------------------------------------------------
"                                    Splits
" ------------------------------------------------------------------------------

" Overrides vim default splitting settings
set splitbelow splitright

" Shortcuts for split navigation
map <leader>h <C-w>h
map <leader>j <C-w>j
map <leader>k <C-w>k
map <leader>l <C-w>l

" ------------------------------------------------------------------------------
"                                   Back up
" ------------------------------------------------------------------------------

set backup

if !isdirectory($HOME . "/.backup/vim")
    call mkdir($HOME . "/.backup/vim", "p", 0700)
endif

set backupdir=~/.backup/vim

" ------------------------------------------------------------------------------
"                                    Other
" ------------------------------------------------------------------------------

" To enable all vim features
set nocompatible

" Enable mouse for scrolling and resizing.
set mouse=a

" Increase the undo limit
set history=1000

" Do not display mode in status line
set noshowmode

" ------------------------------------------------------------------------------
"                             Function Definitions
" ------------------------------------------------------------------------------

" Relative number on or off.
function! ToggleRelativeNumber()
    if &relativenumber
        set norelativenumber
    else
        set relativenumber
    endif
endfunction

" Number on or off.
function! ToggleNumber()
    if &number || &relativenumber
        set nonumber
        set norelativenumber
    else
        set number
        set relativenumber
    endif
endfunction

" Switch colorschemes.
function! ToggleColorScheme()
    if g:colors_name == 'molokai'
        color atom-dark-256
    elseif g:colors_name == 'atom-dark-256'
        color palenight
    else
        color molokai
    endif
endfunction

" Color Column on or off.
function! ToggleColorColumn()
    if &cc == ''
        " Highlight column after 'textwidth'
        set cc=+1
    else
        set cc=
    endif
endfunction

" Remove traling whitespaces.
function! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

" Return the commenting token.
function! GetCommentToken()
    let l:hash = ['php', 'ruby', 'sh', 'make', 'python', 'perl']
    let l:slashes = ['javascript', 'c', 'cpp', 'java', 'objc', 'scala', 'go']
    if index(hash, &filetype) >= 0
        return '#'
    elseif index(slashes, &filetype) >= 0
        return '//'
    elseif &filetype == 'vim'
        return '"'
    else
        return '#'
    endif
endfunction

function! WriteVisualComment()
    let l:token  = GetCommentToken() " (e.g. #, //)
    let l:format = token . ' %s'
    let l:space  = 1                 " space character

    let l:text = input('Text: ')  " comment text
    " If no input text:
    if len(text) == 0
        echom 'Error: no input text.'
        return
    endif

    let l:char = input('Char: ')  " comment char
    " If comment char is too long:
    if len(char) != 1
        echom 'Error: char must be 1 character.'
        return
    endif

    " Get the number of char to add on left and right
    let l:length = &textwidth - len(text) - len(format)
    let l:left   = length / 2
    let l:right  = length - left

    " Insert in the buffer
    put = printf(format, repeat(char, &textwidth - len(token) * 2))
    put = printf(format, repeat(' ', left) . text)
    put = printf(format, repeat(char, &textwidth - len(token) * 2))
endfunction

" ------------------------------------------------------------------------------
"                                Abbreviations
" ------------------------------------------------------------------------------

iabbr #i #include
iabbr #d #define

" ------------------------------------------------------------------------------
"                                    Insert
" ------------------------------------------------------------------------------

" Disable arrows
inoremap <Left>  <nop>
inoremap <Right> <nop>
inoremap <Up>    <nop>
inoremap <Down>  <nop>

" Escape alternative
inoremap jk <esc>

" ------------------------------------------------------------------------------
"                                    Normal
" ------------------------------------------------------------------------------

" Disable arrows
nnoremap <Left>  <nop>
nnoremap <Right> <nop>
nnoremap <Up>    <nop>
nnoremap <Down>  <nop>

" Edit .vimrc
nnoremap <leader>ev :split $MYVIMRC  <CR>
" Source .vimrc
nnoremap <leader>sv :source $MYVIMRC <CR>

" Insert a character
nnoremap <C-i> i_<Esc>r
" Insert a new line
nnoremap <silent> <leader>o : <C-u>call append(line("."),   repeat([""], v:count1))<CR>
nnoremap <silent> <leader>O : <C-u>call append(line(".")-1, repeat([""], v:count1))<CR>

nnoremap <silent> <leader>w  :call TrimWhitespace()     <CR>
nnoremap <silent> <leader>v  :call WriteVisualComment() <CR>

" Toggles.
nnoremap <silent> <C-n> :call ToggleNumber()         <CR>
nnoremap <silent> <C-l> :call ToggleRelativeNumber() <CR>
nnoremap <silent> <C-c> :call ToggleColorScheme()    <CR>
nnoremap <silent> <C-x> :call ToggleColorColumn()    <CR>

if &filetype == 'c'
        " Write a C-style for loop.
        nnoremap <leader>r :<esc>Ifor (int i = 0; i < ; i++) {<enter>}<esc>O<esc>k6w2li
        " Write a printf.
        nnoremap <leader>d :<esc>Iprintf("\n");<esc>4hi
endif

" ------------------------------------------------------------------------------
"                                    Visual
" ------------------------------------------------------------------------------

" Disable arrows
vnoremap <Left>  <nop>
vnoremap <Right> <nop>
vnoremap <Up>    <nop>
vnoremap <Down>  <nop>