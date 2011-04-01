"Font & colormap settings
set background=dark
"set background=light
if has("gui_macvim")
    " Font for the Mac
"    set guifont=Monaco:h12.00
    set guifont=Menlo\ Regular:h12.00
    set anti
    set columns=115
    set lines=42
elseif has("gui")
    " Font on the Linux
    set guifont=Terminus\ 11
endif

color solarized

function! ToggleBackground()
    if (g:solarized_style=="dark")
    let g:solarized_style="light"
    colorscheme solarized
else
    let g:solarized_style="dark"
    colorscheme solarized
endif
endfunction
command! Togbg call ToggleBackground()
nnoremap <F6> :call ToggleBackground()<CR>
inoremap <F6> <ESC>:call ToggleBackground()<CR>a
vnoremap <F6> <ESC>:call ToggleBackground()<CR>
