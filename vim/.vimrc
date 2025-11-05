" Boilerplate .vimrc template borrowed from https://gist.github.com/simonista/8703722 and extended

" Don't try to be vi compatible
set nocompatible

" Turn on syntax highlighting
syntax on

" For plugins to load correctly
filetype plugin indent on

" Set the leader key
let mapleader = ","

" Security
set modelines=0

" Show line numbers
set number

" Show file stats
set ruler

" Silence bells completely
set noerrorbells
set visualbell
set t_vb=

" Encoding
set encoding=utf-8

" Whitespace
set wrap
set textwidth=79
set formatoptions=tcqrn1
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set noshiftround

" Cursor motion
set scrolloff=3
set backspace=indent,eol,start
set matchpairs+=<:> " use % to jump between pairs
runtime! macros/matchit.vim

" Move up/down editor lines
nnoremap j gj
nnoremap k gk

" Allow hidden buffers
set hidden

" Status bar
set laststatus=2

" Last line
set showmode
set showcmd

" Searching
nnoremap / /\v
vnoremap / /\v
set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch
nnoremap <silent> <leader><space> :let @/=''<CR> " clear search

" Enable fzf
set rtp+=/opt/homebrew/opt/fzf

" Textmate holdouts

" Formatting
nnoremap <silent> <leader>q gqip

" Visualize tabs and newlines
set listchars=tab:▸\ ,eol:¬
" Use leader key + l to toggle on/off
nnoremap <silent> <leader>l :set list!<CR> " Toggle tabs and EOL

" Color scheme (terminal)
packadd! dracula
colorscheme dracula

" Set the CursorLine highlight group
augroup CursorLineHighlight
    autocmd!
    autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    autocmd WinLeave,BufWinLeave * setlocal nocursorline
augroup END

" Set the CursorLine color
highlight CursorLine cterm=underline ctermfg=81 ctermbg=NONE

" Set the CursorLineNr highlight group
highlight CursorLineNr ctermfg=yellow ctermbg=NONE
