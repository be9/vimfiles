set nocompatible

set nobackup
set nowritebackup
set noet

set modeline

if has("gui_macvim")
	set guifont=Monaco:h12.00
	set noanti
elseif has("gui")

endif
if has("gui")
	color metacosm
else
	color vividchalk
endif

set background=dark

filetype plugin on
filetype indent on

set ts=4
set bs=2		" allow backspacing over everything in insert mode
set ai			" always set autoindenting on
set viminfo='20,\"50	" read/write a .viminfo file, don't store more
			" than 50 lines of registers
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time

" Don't use Ex mode, use Q for formatting
map Q gq

" Make p in Visual mode replace the selected text with the "" register.
vnoremap p <Esc>:let current_reg = @"<CR>gvdi<C-R>=current_reg<CR><Esc>

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
endif

" In text files, always limit the width of text to 78 characters
autocmd BufRead *.txt set tw=78
autocmd BufRead *.yml set ts=4 et

nmap <silent> <C-N> :silent noh<CR>
set hidden
nmap <C-J> <C-W>j<C-W>_
nmap <C-K> <C-W>k<C-W>_
map <Leader>zz  :let &scrolloff=999-&scrolloff<CR>

set guioptions-=T
set wmh=0

let g:proj_flags = 'imstgv'

nmap ,t :ToggleWord<CR>
nmap \t :NERDTreeToggle<CR>

autocmd FileType ruby,cmake,php set ts=2 sw=2 et autoindent smartindent smarttab
autocmd FileType python set ts=4 sw=4 et autoindent smartindent smarttab
