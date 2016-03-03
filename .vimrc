set encoding=utf-8

set autoindent
set ts=4
filetype on

set mouse=a

syntax on
set ignorecase
set smartcase
set hlsearch
set modelines=0
set wildmenu
set wildmode=longest:full
set nu "line numbers

"for indenting
set shiftwidth=4
set tabstop=4
set smarttab
vmap <Tab> >gv
vmap <S-Tab> <gv
inoremap <S-Tab> <C-D>

set lbr "word wrap
set tw=500

set wrap "Wrap lines
set scrolloff=3

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = " " " Leader is the space key
let g:mapleader = " "
"auto indent for brackets
inoremap {<CR> {<CR>}<Esc>O<Tab>
" easier write
nmap <leader>w :w!<cr>
" easier quit
nmap <leader>q :q<cr>
" silence search highlighting
nnoremap <leader>sh :nohlsearch<Bar>:echo<CR>
"paste from outside buffer
nnoremap <leader>p :set paste<CR>"+p:set nopaste<CR>
vnoremap <leader>p <Esc>:set paste<CR>gv"+p:set nopaste<CR>
"copy to outside buffer
vnoremap <leader>y "+y
"select all
nnoremap <leader>a ggVG
"paste from 0 register
"Useful because `d` overwrites the <quote> register
nnoremap <leader>P "0p
vnoremap <leader>P "0p

nnoremap <C-l> :tabnext<CR>
nnoremap <C-h> :tabprevious<CR>

"nnoremap tj  :tabnext<CR>

set mouse=a

" move in long lines
nnoremap k gk
nnoremap j gj

" runners
" Run ruby when typing <leader>r
noremap <buffer> <leader>r :w<cr> :exec '!ruby' shellescape(@%, 1)<cr>
noremap <buffer> <leader>rn :w<cr> :exec '!node' shellescape(@%, 1)<cr>
