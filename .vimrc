"workaround for colors in neovim in tmux
"let $TERM="xterm-256color"

"neovim embedded terminal scrollback
let g:terminal_scrollback_buffer_size = 100000

"terminal in split windows
function! MyTerminal(cmd)
  let l:full_command = a:cmd
  split
  if a:cmd ==# ""
    terminal
  else
    enew
    call termopen(l:full_command)
"    startinsert
  endif
endfunction
command! -nargs=* Terminal call MyTerminal(<q-args>)
command! -nargs=* Te call MyTerminal(<q-args>)

"esc out of terminal
"tnoremap <Esc> <C-\><C-n>

colorscheme torte
set guifont=Lucida_Console:h9:cANSI
set langmenu=en_US.UTF-8
set history=2000
set viminfo+=:2000
set background=dark
set mouse=
syntax on
set hidden
set number
set relativenumber
set ruler
set hlsearch
set incsearch
set noreadonly
set laststatus=2
set wildmode=list:longest  "(file-listing when opening a new file)
set backspace=2
set completeopt+=longest
set completeopt+=menuone
"set completeopt-=preview
set updatetime=250
let mapleader = "\<Space>"
if has('nvim')
set ffs=unix,dos
else
set ffs=dos,unix
endif
set undofile
set undodir=~/.vim/undofiles
set diffopt+=vertical
set nostartofline

"tabs and text width and stuff
set cindent
set shiftwidth=2
set expandtab
set tabstop=4
set colorcolumn=100
set textwidth=100
set formatoptions-=l
set formatoptions-=t

"spell checking
set spell spelllang=en_us
set nospell
"let g:load_doxygen_syntax=1
au FileType qf                       setlocal nospell
au BufNewFile,BufRead,BufEnter *     setlocal nospell
au BufNewFile,BufRead,BufEnter *.dox setf doxygen
au BufNewFile,BufRead,BufEnter *.dox setlocal spell
au BufNewFile,BufRead,BufEnter *.h   setlocal spell
au BufNewFile,BufRead,BufEnter *.h.in setlocal spell
"Commit messages
au BufNewFile,BufRead,BufEnter *EDITMSG   setlocal spell
set complete+=kspell

"save session in case of instability...
autocmd BufWritePre * :mks! ~/vimsessions/autosave

"highlighting
highlight WhitespaceEOL ctermbg=darkred guibg=darkred
highlight Tabs ctermbg=blue guibg=blue
au BufNewFile,BufRead,BufEnter * match WhitespaceEOL /\s\+$/
au BufNewFile,BufRead,BufEnter * 2match Tabs /\t\+/

"sed swpfile dir
:set directory=$HOME/.vim/swapfiles//

"navigation stuff
nmap <Up> <c-w><c-k>
nmap <Down> <c-w><c-j>
nmap <Left> <c-w><c-h>
nmap <Right> <c-w><c-l>
imap <Up> <Nop>
imap <Down> <Nop>
imap <Left> <Nop>
imap <Right> <Nop>
"nmap <Tab> :tabnext<CR>
"nmap <S-Tab> :tabprevious<CR>

nmap <Leader>te :sp<CR>:te<CR>

nmap <Leader>m <c-w>_<c-w><Bar>
nmap <Leader>+ <c-w>_<c-w><Bar>
nmap <Leader>= <c-w>=
set splitright
set splitbelow

" resize
nmap <c-Left> :vertical res -10<cr>
nmap <c-Right> :vertical res +10<cr>
nmap <c-Up> :res +10<cr>
nmap <c-Down> :res -10<cr>

nmap <c-H> :vertical res +10<cr>
nmap <c-K> :res +10<cr>
nmap <c-J> :res -10<cr>

" If we have a saved position in the file, go there.
autocmd BufReadPost *
            \ if line("'\"") > 0 && line("'\"") <= line("$") |
            \   exe "normal g`\"" |
            \ endif

"eclim stuff/youcompleteme ycm stuff
if !has('nvim')
  set nocompatible
  filetype plugin indent on
  let g:EclimTodoSearchPattern = '\(\<fixme\>\|\<todo\>\|\<oyho\>\)\c'
  let g:EclimKeepLocalHistory = 1
  nmap <F3> :CSearchContext<CR>
  nmap <Leader>ee :EclimEnable<CR>
  nmap <Leader>ed :EclimDisable<CR>
  imap <c-u> <c-x><c-u>
else
  nmap <F3> :YcmCompleter 
  let g:ycm_autoclose_preview_window_after_completion = 1
  let g:ycm_autoclose_preview_window_after_insertion = 1
endif

"ctrlp stuff
" ignore gitignored files
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
"if executable('ag')
if has('nvim')
  let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlPMixed'
"nmap <c-g> :CtrlPBuffer<CR>

"grepping
"get rid of the /dev/null
set grepprg=grep\ -n\ $*
nmap <Leader>fc :cope<CR><c-W>W:gr! -r --include="*.[chsCHS]" -e "
nmap <Leader>fd :cope<CR><c-W>W:gr! -r --include="*.dita" --include="*.ditamap" -e "

"relative line numbers
function! NumberToggle()
  if(&relativenumber == 1)
    set norelativenumber
  else
    set relativenumber
  endif
endfunc

nnoremap <Leader>1 :call NumberToggle()<cr>

"GDB setup
"default: 50 is too slow (races, inconsistencies in vim tui buffer?
let g:ConqueGdb_ReadTimeout = 100
let g:ConqueGdb_SrcSplit = 'left'

function! NrfjprogHalt()
  if !exists('g:NrfjprogFamily')
    let g:NrfjprogFamily = "nrf52"
  endif

  if !exists('g:NrfjprogSerial')
    let g:NrfjprogSerial = "$OYHO_NRF52_DEV_KIT"
  endif

  exe "!nrfjprog --halt --family " . g:NrfjprogFamily . " --snr " . g:NrfjprogSerial
  "force update of tui buffer
  redraw!
  ConqueGdbCommand pwd
endfunction

function! GdbBreakTemp()
  call conque_gdb#command("tbreak " . expand("%") . ":" . line("."))
endfunction

"Starts ARM GDB with JLink server
function! GdbJlink()
  "run (continue)
  nmap <F5> :ConqueGdbCommand c<CR>
  imap <F5> <Esc><F5>
  "reset
  nmap <C-F5> :ConqueGdbCommand monitor reset<CR>
  imap <C-F5> <Esc><C-F5>
  "halt
  nmap <F6> :call NrfjprogHalt()<CR><CR>
  imap <F6> <Esc><F6>
  "add temporary breakpoint (for "run to line")
  nmap <F9> :call GdbBreakTemp()<CR>
  imap <F9> <Esc><F9>
  "step
"  nmap <F11> :ConqueGdbCommand monitor step<CR>
  nmap <F11> :ConqueGdbCommand step<CR>
  imap <F11> <Esc><F11>
  "step out of
  nmap <C-F10> :ConqueGdbCommand finish<CR>
  imap <C-F10> <Esc><C-F10>
  "step machine instruction
  nmap <S-F10> :ConqueGdbCommand stepi<CR>
  imap <S-F10> <Esc><S-F10>
  "Shortcut to add any gdb command
  nmap <F12> :ConqueGdbCommand 
  imap <F12> <Esc><F12>

  "open GDB and set up with Jlink server. This uses py version, standard works as well
  ConqueGdbExe ~/bin/gnutools/bin/arm-none-eabi-gdb-py.exe
  ConqueGdb
  ConqueGdbCommand target remote localhost:2331
  ConqueGdbCommand monitor clrbp
  ConqueGdbCommand monitor reset
  "exit insert mode in gdb tui buffer
  stopinsert
endfunction
command! GdbJlink call GdbJlink()

"Starts GDB (GCC)
function! GdbGcc()
  "run (continue)
  nmap <F5> :ConqueGdbCommand c<CR>
  imap <F5> <Esc><F5>
  "reset
  nmap <C-F5> :ConqueGdbCommand run<CR>
  imap <C-F5> <Esc><C-F5>
  "halt
  nmap <F6> :call NrfjprogHalt()<CR><CR>
  imap <F6> <Esc><F6>
  "add temporary breakpoint (for "run to line")
  nmap <F9> :call GdbBreakTemp()<CR>
  imap <F9> <Esc><F9>
  "step (shift version also where F11 means full screen
  nmap <S-F11> :ConqueGdbCommand step<CR>
  imap <S-F11> <Esc><S-F11>
  nmap <F11> :ConqueGdbCommand step<CR>
  imap <F11> <Esc><F11>
"  nmap <F11> :ConqueGdbCommand monitor step<CR>
  nmap <F10> :ConqueGdbCommand next<CR>
  imap <F10> <Esc><F10>
  "step out of
  nmap <C-F10> :ConqueGdbCommand finish<CR>
  imap <C-F10> <Esc><C-F10>
  "step machine instruction
  nmap <S-F10> :ConqueGdbCommand stepi<CR>
  imap <S-F10> <Esc><S-F10>
  "Shortcut to add any gdb command
  nmap <F12> :ConqueGdbCommand 
  imap <F12> <Esc><F12>

  "open GDB and set up with Jlink server. This uses py version, standard works as well
  "ConqueGdbExe /cygdrive/c/cygwin32/bin/gdb
  ConqueGdb
endfunction
command! GdbGcc call GdbGcc()


"open JLink server
function! GdbJlinkServer()
  exe '!/cygdrive/c/Program\ Files\ \(x86\)/SEGGER/JLink_V510n/JLinkGDBServer.exe -select USB -device nRF52832_xxAA -if SWD -speed 1000 -noir &'
endfunction
command! GdbJlinkServer call GdbJlinkServer()

"kill JLink server
function! GdbJlinkServerKill()
  exe '!taskkill -f -im JLinkGDBServer.exe'
endfunction
command! GdbJlinkServerKill call GdbJlinkServerKill()

"commenting
"put comment string into c register
autocmd BufEnter *.c,*.cpp,*.h,*.hpp :let CommentString = "//"
autocmd BufEnter *.s :let CommentString = ";"
autocmd BufEnter *.py,*.sh :let CommentString = "#"
autocmd BufEnter *.vimrc,*.vim :let CommentString = "\""
"get characters in comment string into u register
autocmd BufEnter *.c,*.cpp,*.h,*.hpp :let CommentStringLength = 2
autocmd BufEnter *.s :let CommentStringLength = 1
autocmd BufEnter *.py,*.sh :let CommentStringLength = 1
autocmd BufEnter *.vimrc,*.vim :let CommentStringLength = 1

"line
nmap \ :normal 0i<c-r>=CommentString<CR><CR>+
nmap <bar> :normal _<c-r>=CommentStringLength<CR>x<CR>+
"selection
vmap \ :normal 0i<c-r>=CommentString<CR><CR>+
vmap <bar> :normal _<c-r>=CommentStringLength<CR>x<CR>+

"GPIO debugging
function! PinDebug()
  normal o
  normal o#ifndef PIN_DEBUG_ENABLE
  normal o#define PIN_DEBUG_ENABLE
  normal o#endif
  normal o#include "pin_debug_transport.h"
  normal o
endfunction
:command! PinDebug call PinDebug()

function! PinDebugInit()
  normal oDBP_PORTA_ENABLE;
endfunction
:command! PinDebugInit call PinDebugInit()

function! SpiDebug()
  "blank line below DEBUG_SPI_END
  normal o
  normal O/***********DEBUG_SPI_END***************/
  normal -
  r~/devel/debug-tools/debug_spi.c
  normal -
  call PinDebug()
endfunction
:command! SpiDebug call SpiDebug()

function! SpiDebugInit()
  normal odebug_spi_config(DBP6, DBP7);
endfunction
:command! SpiDebugInit call SpiDebugInit()

"quickfix window height
au FileType qf call AdjustWindowHeight(3, 20)
function! AdjustWindowHeight(minheight, maxheight)
  exe max([min([line("$")+5, a:maxheight]), a:minheight]) . "wincmd _"
  "exe max([min([a:maxheight, a:maxheight]), a:minheight]) . "wincmd _"
endfunction

function! FindConflict()
  normal /\(=======\|<<<<<<<\|>>>>>>>\)
endfunction
:command! FindConflict call FindConflict()

