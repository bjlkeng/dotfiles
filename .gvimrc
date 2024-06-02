" An example for a gvimrc file.
" The commands in this are executed when the GUI is started.
"
" Make external commands work through a pipe instead of a pseudo-tty
set noguipty

" set the X11 font to use
" set guifont=-misc-fixed-medium-r-normal--14-130-75-75-c-70-iso8859-1

# if has("gui_gtk2")
#     set guifont=Luxi\ Mono\ 9
# elseif has("x11")
#     " Also for GTK 1
#     set guifont=*-lucidatypewriter-medium-r-normal-*-*-180-*-*-m-*-*
# elseif has("gui_win32")
#     set guifont=Luxi_Mono:h9:cANSI
# endif

set ch=2                " Make command line two lines high
set mousehide           " Hide the mouse when typing text

" set the initial window size
set lines=40
set columns=150

" Only do this for Vim version 5.0 and later.
if version >= 500

  " I like highlighting strings inside C comments
  let c_comment_strings=1

  " Switch on syntax highlighting if it wasn't on yet.
  if !exists("syntax_on")
    syntax on
  endif

  " Switch on search pattern highlighting.
  set hlsearch

  " For Win32 version, have "K" lookup the keyword in a help file
  if has("win32")
    let winhelpfile='windows.hlp'
    map K :execute "!start winhlp32 -k <cword> " . winhelpfile <CR>
  endif

  " Set nice colors
  colorscheme koehler
  highlight Visual guibg=DarkGrey guifg=grey50
  highlight Folded guibg=grey10   guifg=grey30

  " A better font for the gui.
  set guifont=Monaco:h18
endif

" Setup multiple tabs.
if version >= 700
  map th :tabnext<CR>
  map tl :tabprev<CR>
  map tn :tabnew<CR>
  map td :tabclose<CR>
endif

if version >= 700
  map gc :SwitchCppHpp<CR>
endif

