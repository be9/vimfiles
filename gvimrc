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

"call togglebg#map("<F6>")
nmap <F6> :NERDTreeFind<CR>
