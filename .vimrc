" Special terminal info.
if &term =~ "xterm"
    if has("terminfo")
        set t_Co=16
        set t_Sf=[3%p1%dm
        set t_Sb=[4%p1%dm
    else
        set t_Co=16
        set t_Sf=[3%dm
        set t_Sb=[4%dm
    endif
endif

set nocompatible
set backspace=indent,eol,start
set history=50
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " do incremental searching

map Q gq

nnoremap <silent> \ :noh<CR>

" Some code editing options.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif


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
  "if has("win32")
  "  let winhelpfile='windows.hlp'
  "  map K :execute "!start winhlp32 -k <cword> " . winhelpfile <CR>
  "endif

  " Set nice colors
  " background for normal text is light grey
  " Text below the last line is darker grey
  " Cursor is green, Cyan when ":lmap" mappings are active
  " Constants are not underlined but have a slightly lighter background
  highlight Normal ctermbg=Black ctermfg=White
  highlight Cursor ctermbg=Green
  highlight lCursor ctermbg=Green
  highlight Visual ctermbg=White ctermfg=DarkGrey
  highlight Visual guibg=DarkGrey guifg=grey50

endif

" Enable file type detection.
" Use the default filetype settings, so that mail gets 'tw' set to 72,
" 'cindent' is on in C files, etc.
" Also load indent files, to automatically do language-dependent indenting.
filetype plugin indent on



" Only do this part when compiled with support for autocommands.
if has("autocmd")

    " Put these in an autocmd group, so that we can delete them easily.
    augroup vimrcEx
        autocmd!
    
        " When editing a file, always jump to the last known cursor position.
        " Don't do it for commit messages, when the position is invalid, or when
        " inside an event handler (happens when dropping a file on gvim).
        autocmd BufReadPost *
          \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
          \   exe "normal g`\"" |
          \ endif
    
        " Set syntax highlighting for specific file types
        autocmd BufRead,BufNewFile Appraisals set filetype=ruby
        autocmd BufRead,BufNewFile *.md set filetype=markdown
        autocmd BufRead,BufNewFile .{jscs,jshint,eslint}rc set filetype=json
        autocmd BufRead,BufNewFile .j2 set filetype=jinja2
         
    au!
  
    " Spell check for text files
    autocmd FileType text,latex,tex,md,markdown,rst setlocal spell

    " For all text files set 'textwidth' to 78 characters.
    autocmd FileType text setlocal textwidth=80
else
"    set autoindent		" always set autoindenting on
endif " has("autocmd")

" Enable syntax-folding, and spice up the auto-formatting options.
set foldmethod=syntax
set fo+=n
set foldlevelstart=99

" Set the tabstop and shiftwidth.
set tabstop=4 shiftwidth=4 expandtab shiftround smarttab

" Some settings to make editing code nicer.
set cino=g0,(0,t1,w1,*60 number

let s:save_cpo = &cpo | set cpo&vim
if !exists('g:VeryLiteral')
  let g:VeryLiteral = 0
endif

function! s:VSetSearch(cmd)
  let old_reg = getreg('"')
  let old_regtype = getregtype('"')
  normal! gvy
  if @@ =~? '^[0-9a-z,_]*$' || @@ =~? '^[0-9a-z ,_]*$' && g:VeryLiteral
    let @/ = @@
  else
    let pat = escape(@@, a:cmd.'\')
    if g:VeryLiteral
      let pat = substitute(pat, '\n', '\\n', 'g')
    else
      let pat = substitute(pat, '^\_s\+', '\\s\\+', '')
      let pat = substitute(pat, '\_s\+$', '\\s\\*', '')
      let pat = substitute(pat, '\_s\+', '\\_s\\+', 'g')
    endif
    let @/ = '\V'.pat
  endif
  normal! gV
  call setreg('"', old_reg, old_regtype)
endfunction

vnoremap <silent> * :<C-U>call <SID>VSetSearch('/')<CR>/<C-R>/<CR>
vnoremap <silent> # :<C-U>call <SID>VSetSearch('?')<CR>?<C-R>/<CR>
vmap <kMultiply> *

nmap <silent> <Plug>VLToggle :let g:VeryLiteral = !g:VeryLiteral
  \\| echo "VeryLiteral " . (g:VeryLiteral ? "On" : "Off")<CR>
if !hasmapto("<Plug>VLToggle")
  nmap <unique> <Leader>vl <Plug>VLToggle
endif
let &cpo = s:save_cpo | unlet s:save_cpo


if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

filetype plugin indent on

" configure syntastic syntax checking to check on open as well as save
let g:syntastic_check_on_open=1
let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]
let g:syntastic_eruby_ruby_quiet_messages =
    \ {"regex": "possibly useless use of a variable in void context"}

" Set the statusline
set statusline=%f         " Path to the file
set statusline+=%y        " Filetype of the file
set statusline+=%=        " Switch to the right side
set statusline+=Current:\ %-4l " Display current line
set statusline+=Total:\ %-4L " Dispay total lines
set statusline+=%{fugitive#statusline()} " Git status

" map nerdtree viewport to CTRL+n

map <C-t> :NERDTreeToggle<CR>

" vim-plug configuration
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-fugitive'
Plug 'scrooloose/syntastic'
Plug 'nvie/vim-flake8'
Plug 'kien/ctrlp.vim'
let python_highlight_all=1

" Add plugins to &runtimepath
call plug#end()
