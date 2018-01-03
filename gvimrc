"Font & colormap settings
set background=dark
"set background=light
if has("gui_macvim")
    " Font for the Mac
"    set guifont=Monaco:h12.00
"    set guifont=Menlo\ Regular:h12.00
    set guifont=Fira\ Code:h10
    set macligatures
    set anti
    set columns=115
    set lines=42
elseif has("gui")
    " Font on the Linux
    "set guifont=Terminus\ 11
    set guifont=Ubuntu\ Mono\ 12
endif

color solarized
set background=light

function! ToggleBackground()
    if (g:solarized_style=="dark")
    let g:solarized_style="light"
    colorscheme solarized
else
    let g:solarized_style="dark"
    colorscheme solarized
endif
endfunction

call togglebg#map("<F5>")
nmap <F6> :NERDTreeFind<CR>
