" no compatibility to vi
set nocompatible

" pathogen
filetype off
call pathogen#infect()

syntax on                           " syntax highlighing
filetype on                          " try to detect filetypes
filetype plugin indent on    " enable loading indent file for filetype

" tabbing
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent

" set local indentaion settings for some file types
autocmd FileType python setlocal shiftwidth=4 softtabstop=4
autocmd FileType c setlocal expandtab shiftwidth=4 softtabstop=4
autocmd FileType cpp setlocal expandtab shiftwidth=4 softtabstop=4
autocmd FileType h setlocal expandtab shiftwidth=4 softtabstop=4

" folding
set foldmethod=indent
set foldnestmax=2
set foldminlines=3

" before inserting press <F2> to disable autoindent
set pastetoggle=<F2>

" misc
set encoding=utf-8
set showmode
set showcmd
set visualbell
set ttyfast
set backspace=indent,eol,start
set splitright

" filename completion as in bash
"set wildmenu
set wildmode=longest,list:full

" always show at least 3 lines at the top
set scrolloff=3
" use numbering relative to current line
set relativenumber

" searching
set ignorecase
set smartcase
set gdefault " work on whole line by default
set incsearch
set showmatch
set hlsearch

" disable arrow keys
nnoremap <up> <nop>
nnoremap <down> <nop>
"nnoremap <left> <nop>
"nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" use arrow keys for left right 
nnoremap <left> :tabprevious<CR>
nnoremap <right> :tabnext<CR>

" move by visual lines
nnoremap j gj
nnoremap k gk

" save on losing focus
au FocusLost * :wa

"automatic writing before compiling
set autowrite

" run python programs
nmap <F5> :!python % <CR>
nmap <F6> :!ipython % -gthread -noconfirm_exit -nomessages <CR>

" FileType specific settings
" Makefiles don't work properly with tabs
autocmd FileType make set noexpandtab
" recognize .py.example files as python files
autocmd BufRead *.py.example set filetype=python
