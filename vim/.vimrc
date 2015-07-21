set nocompatible
set rtp+=~/.vim/bundle/Vundle.vim
colorscheme default
call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-fugitive'
Plug 'kien/ctrlp.vim'
Plug 'gmarik/Vundle.vim'
Plug 'bling/vim-airline'
Plug 'scrooloose/nerdtree'

call plug#end()

set laststatus=2
syntax enable
filetype plugin indent on

set noswapfile number
set hidden autochdir nowrap
set backspace=2
set smartindent tabstop=4 shiftwidth=4
set encoding=utf-8
set timeoutlen=50
set t_Co=256 background=light
set ignorecase autochdir
:imap jk <Esc>
:imap kj <Esc>

"Write to readonly file
command ROW execute "w !sudo tee % >/dev/null"

"delete buffer without quitting the window
command BUFD execute "bp | bd #"

let mapleader = " "
noremap <Leader>w :w<CR>
noremap <leader>t :tabnew<CR>
noremap <leader>c :nohl<CR>
noremap <leader>n :NERDTreeToggle<CR>
noremap <leader>d :BUFD<CR>

"move through split windows using Shift
if has ('nvim')
	tnoremap <C-h> <C-\><C-n><C-w>h<CR>
	tnoremap <C-j> <C-\><C-n><C-w>j<CR>
	tnoremap <C-k> <C-\><C-n><C-w>k<CR>
	tnoremap <C-l> <C-\><C-n><C-w>l<CR>
endif
map <C-h> <C-\><C-n><C-w>h<CR>
map <C-j> <C-\><C-n><C-w>j<CR>
map <C-k> <C-\><C-n><C-w>k<CR>
map <C-l> <C-\><C-n><C-w>l<CR>

"cycle through open buffers in one window
:map <S-l> :bn!<CR>
:map <S-h> :bp!<CR>

"use arrow keys to resize
noremap <C-up>    <C-W>+
noremap <C-down>  <C-W>-
noremap <C-left>  3<C-W><
noremap <C-right> 3<C-W>>

"move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv


"customize airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#right_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#right_alt_sep = '|'
let g:airline_right_sep = ' '
let g:airline_left_sep = ' '
let g:airline_left_alt_sep = '|'
let g:airline_right_alt_sep = '|'
let g:airline_section_y = ''
let g:airline_theme = 'bubblegum'

"function to delete any trailing whitespace in current file
function! ShowSpaces(...)
	let @/='\v(\s+$)|( +\ze\t)'
	let oldhlsearch=&hlsearch
		if !a:0
		let &hlsearch=!&hlsearch
		else
		let &hlsearch=a:1
		end
	return oldhlsearch
endfunction
function! TrimSpaces() range
	let oldhlsearch=ShowSpaces(1)
	execute a:firstline.",".a:lastline."substitute ///ge"
	let &hlsearch=oldhlsearch
endfunction

command! -bar -nargs=? ShowSpaces call ShowSpaces(<args>)
command! -bar -nargs=0 -range=% TrimSpaces <line1>,<line2>call TrimSpaces()
nnoremap <F12>     :ShowSpaces 1<CR>
nnoremap <S-F12>   m`:TrimSpaces<CR>``
vnoremap <S-F12>   :TrimSpaces<CR>
