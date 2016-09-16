"Use Vim settings, rather then Vi settings (much better!).
"This must be first, because it changes other options as a side effect.
set nocompatible

" Disable tsuquyomi for older vim
if v:version < 704
  let g:loaded_tsuquyomi = 1
endif

"allow backspacing over everything in insert mode
set backspace=indent,eol,start

"disable backups
set nobackup
set nowritebackup

set dir=~/.vim/backups//

"store lots of :cmdline history
set history=1000

set showcmd     "show incomplete cmds down the bottom
set showmode    "show current mode down the bottom

"statusline setup
set statusline=%f       "tail of the filename

"display a warning if fileformat isnt unix
set statusline+=%#warningmsg#
set statusline+=%{&ff!='unix'?'['.&ff.']':''}
set statusline+=%*

"display a warning if file encoding isnt utf-8
set statusline+=%#warningmsg#
set statusline+=%{(&fenc!='utf-8'&&&fenc!='')?'['.&fenc.']':''}
set statusline+=%*

set statusline+=%h      "help file flag
set statusline+=%y      "filetype
set statusline+=%r      "read only flag
set statusline+=%m      "modified flag

"display a warning if &et is wrong, or we have mixed-indenting
set statusline+=%#error#
set statusline+=%{StatuslineTabWarning()}
set statusline+=%*

set statusline+=%{StatuslineTrailingSpaceWarning()}

"display a warning if &paste is set
set statusline+=%#error#
set statusline+=%{&paste?'[paste]':''}
set statusline+=%*

set statusline+=%=      "left/right separator
"set statusline+=%{StatuslineCurrentHighlight()}\ \ "current highlight
set statusline+=%c,     "cursor column
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %P    "percent through file
set laststatus=2

"recalculate the trailing whitespace warning when idle, and after saving
autocmd cursorhold,bufwritepost * unlet! b:statusline_trailing_space_warning

"return '[\s]' if trailing white space is detected
"return '' otherwise
function! StatuslineTrailingSpaceWarning()
    if !exists("b:statusline_trailing_space_warning")
        if search('\s\+$', 'nw') != 0
            let b:statusline_trailing_space_warning = '[\s]'
        else
            let b:statusline_trailing_space_warning = ''
        endif
    endif
    return b:statusline_trailing_space_warning
endfunction

"return the syntax highlight group under the cursor ''
"function! StatuslineCurrentHighlight()
"    let name = synIDattr(synID(line('.'),col('.'),1),'name')
"    if name == ''
"        return ''
"    else
"        return '[' . name . ']'
"    endif
"endfunction

"recalculate the tab warning flag when idle and after writing
autocmd cursorhold,bufwritepost * unlet! b:statusline_tab_warning

"return '[&et]' if &et is set wrong
"return '[mixed-indenting]' if spaces and tabs are used to indent
"return an empty string if everything is fine
function! StatuslineTabWarning()
    if !exists("b:statusline_tab_warning")
        let tabs = search('^\t', 'nw') != 0
        let spaces = search('^ ', 'nw') != 0

        if tabs && spaces
            let b:statusline_tab_warning =  '[mixed-indenting]'
        elseif (spaces && !&et) || (tabs && &et)
            let b:statusline_tab_warning = '[&et]'
        else
            let b:statusline_tab_warning = ''
        endif
    endif
    return b:statusline_tab_warning
endfunction

"indent settings
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent

"folding settings
set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default

"display tabs and trailing spaces
set list
set listchars=tab:▷⋅,trail:⋅,nbsp:⋅

set formatoptions-=o "dont continue comments when pushing o/O

"vertical/horizontal scroll off settings
set scrolloff=3
set sidescrolloff=7
set sidescroll=1

"load ftplugins and indent files
filetype plugin on
filetype indent on

"turn on syntax highlighting
syntax on

"tell the term has 256 colors
"set t_Co=256

"hide buffers when not displayed
set hidden

"color vividchalk

" Don't use Ex mode, use Q for formatting
map Q gq

" In text files, always limit the width of text to 78 characters
autocmd BufRead *.txt set tw=78
autocmd BufRead Thorfile,*.thor setf ruby
autocmd BufRead *.ldg setf ledger

" Javascript
autocmd BufRead *.js set tw=78 sw=2 ts=2 sts=2 et
autocmd BufRead *.js setlocal cinoptions=j1,J1,:0,(0

"Make <c-l> clear the highlight as well as redraw
nnoremap <C-L> :nohls<CR><C-L>
inoremap <C-L> <C-O>:nohls<CR>

"Use C-J and C-K for convenient jumping between the hor splits
nmap <C-J> <C-W>j<C-W>_
nmap <C-K> <C-W>k<C-W>_

"bufexplorer
nnoremap <C-B> :BufExplorer<cr>

"Toggle scrolling from the center
map <Leader>zz  :let &scrolloff=999-&scrolloff<CR>

"Disable toolbar in the GUI
set guioptions-=T
set wmh=0

let g:proj_flags = 'imstgv'

nmap <silent> <Leader>p :NERDTreeToggle<CR>

autocmd FileType ruby,cmake,php set ts=2 sw=2 smartindent smarttab
autocmd FileType python set ts=4 sw=4 smartindent smarttab
autocmd FileType cpp set ts=4 sw=4 smartindent smarttab et
autocmd FileType html imap <F2> «
autocmd FileType html imap <F3> »
autocmd FileType html imap <F4> &nbsp;— 
autocmd BufNewFile,BufRead Gemfile setf ruby

autocmd FileType ledger iab nal Активы:Наличные
autocmd FileType ledger iab cred Обязательства:Кредитная альфа
autocmd FileType ledger iab tcre Обязательства:Таня:Кредитка
autocmd FileType ledger iab alfa Активы:Альфа
autocmd FileType ledger iab zk Активы:Золотая Корона
autocmd FileType ledger iab vtb Активы:ВТБ24
autocmd FileType ledger iab tan Люди:Таня
autocmd FileType ledger iab parf Люди:Парфиненко
autocmd FileType ledger iab pit Расходы:Питание
autocmd FileType ledger iab prod Расходы:Продукты

autocmd BufRead *.otl setf vo_base
autocmd FileType vo_base set nolist noet

command! TexMode call s:TexMode()
function! s:TexMode()
"    colo eclipse
    set guifont=DejaVu\ Sans\ Mono\ 11
endfunction

function! s:TexOnLoad()
    set tw=80
    call s:TexMode()
endfunction

autocmd FileType tex call s:TexOnLoad()

let NERDTreeIgnore=['\.vim$', '\~$', '\.pyc']

"define :HighlightExcessColumns command to highlight the offending parts of
"lines that are "too long". where "too long" is defined by &textwidth or an
"arg passed to the command
command! -nargs=? HighlightExcessColumns call s:HighlightExcessColumns('<args>')
function! s:HighlightExcessColumns(width)
    let targetWidth = a:width != '' ? a:width : &textwidth
    if targetWidth > 0
        exec 'match Todo /\%>' . (targetWidth+1) . 'v/'
    else
        echomsg "HighlightExcessColumns: set a &textwidth, or pass one in"
    endif
endfunction

"let g:clj_highlight_builtins=1
"let g:clj_paren_rainbow=1

command ChDir lcd %:p:h

if !has('gui_macvim')
    let g:ackprg="ack-grep -H --nocolor --nogroup --column"
endif

syntax on

" Command-T configuration
let g:CommandTMaxHeight=20

map <Leader>rt :!ctags --extra=+f -R *<CR><CR>
map <C-\> :tnext<CR>

" gist-vim defaults
if has("mac")
  let g:gist_clip_command = 'pbcopy'
elseif has("unix")
  let g:gist_clip_command = 'xclip -selection clipboard'
endif
let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 1

" RSpec.vim mappings
"map <Leader>t :call RunCurrentSpecFile()<CR>
"map <Leader>s :call RunNearestSpec()<CR>
"map <Leader>l :call RunLastSpec()<CR>
"map <Leader>a :call RunAllSpecs()<CR>

"let g:rspec_command = "Dispatch bin/rspec {spec}"
"let g:rspec_command = "compiler rspec | set makeprg=zeus | Make rspec {spec}"
"let g:rspec_command = "compiler rspec | set makeprg=bin/rspec | Make {spec}"
"
"
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

call plug#begin('~/.vim/plugged')

"Plug 'derekwyatt/vim-sbt'
"Plug 'derekwyatt/vim-scala'

Plug 'Quramy/tsuquyomi'
Plug 'Shougo/vimproc.vim'
Plug 'altercation/vim-colors-solarized'
Plug 'briancollins/vim-jst'
Plug 'cakebaker/scss-syntax.vim'
Plug 'cespare/vim-toml'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'ekalinin/Dockerfile.vim'
Plug 'guns/vim-clojure-static'
Plug 'kchmck/vim-coffee-script'
Plug 'leafgarland/typescript-vim'
Plug 'mattn/gist-vim'
Plug 'mileszs/ack.vim'
Plug 'pangloss/vim-javascript'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'slim-template/vim-slim'
Plug 'thoughtbot/vim-rspec'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-classpath'
Plug 'tpope/vim-cucumber'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fireplace'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'
Plug 'tpope/vim-ragtag'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-surround'
"Plug 'vim-scripts/VimClojure'
"Plug 'vim-scripts/ZoomWin'
Plug 'vim-scripts/a.vim'
"Plug 'vim-scripts/paredit.vim'
"Plug 'vim-scripts/taglist.vim'
"Plug 'vimoutliner/vimoutliner'
Plug 'wting/rust.vim'

call plug#end()

