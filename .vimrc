source $HOME/dotfiles/vundle.vim

"workaround for colors in neovim in tmux
"let $TERM="xterm-256color"

"neovim embedded terminal scrollback
let g:terminal_scrollback_buffer_size = 100000

"esc out of terminal
"tnoremap <Esc> <C-\><C-n>

colorscheme torte
set guifont=Monospace\ 11
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
"complete from spell list
set complete+=kspell
"set updatetime=250
let mapleader = "\<Space>"
set undofile
set undodir=~/.vim/undofiles
set diffopt+=vertical
set nostartofline

"tabs and text width and stuff
set cindent
set shiftwidth=4
set expandtab
set tabstop=4
set colorcolumn=80
set textwidth=80
set formatoptions-=l
set formatoptions-=t

"syntax for jinja2 files.
function! Jinja2Filetype()
  if @% =~# '.*\h\.jinja2'
    setf c
  endif
  if @% =~# '.*\py\.jinja2'
    setf python
  endif
  if @% =~# '.*\dox\.jinja2'
    setf doxygen
  endif
endfunction

au BufNewFile,BufRead *.jinja2 call Jinja2Filetype()

"syntax for doxygen
au BufNewFile,BufRead *.dox setf doxygen

"ale syntax checker. Disable auto checking.
let g:ale_lint_on_text_changed=0
let g:ale_lint_on_enter=0
let g:ale_lint_on_save=0
let g:ale_lint_on_filetype_change=0

"spell checking
set spell spelllang=en_us
"Rebuild spell file if the word list has changed (e.g. from Git)
for d in glob('~/dotfiles/spell/*.add', 1, 1)
  if filereadable(d) && (!filereadable(d . '.spl') || getftime(d) > getftime(d . '.spl'))
    exec 'silent mkspell! ' . fnameescape(d)
  endif
endfor
set spellfile=~/dotfiles/spell/en.utf-8.add

hi clear SpellLocal
hi SpellLocal cterm=undercurl ctermfg=cyan
hi clear SpellBad
hi SpellBad cterm=undercurl ctermfg=red
hi clear SpellCap
hi SpellCap cterm=undercurl ctermfg=Blue
hi clear SpellRare
hi SpellRare cterm=undercurl ctermfg=Magenta

set spell
au FileType qf                       setlocal nospell
au BufRead *.fugitiveblame           setlocal nospell
au BufRead *.git//*                  setlocal nospell

"highlighting
au Bufenter * highlight WhitespaceEOL ctermbg=darkred guibg=darkred
au Bufenter * highlight Tabs ctermbg=blue guibg=blue
au BufEnter * match WhitespaceEOL /\s\+$/
au BufEnter * 2match Tabs /\t\+/
"disable highlighting for vim help
au BufEnter *vim/vim*/doc* match WhitespaceEOL //
au BufEnter *vim/vim*/doc* 2match Tabs //

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

nmap <Leader>m <c-w>_<c-w><Bar>
nmap <Leader>+ <c-w>_<c-w><Bar>
nmap <Leader>= <c-w>=
set splitright
set splitbelow

"Easymotion mappings
let g:EasyMotion_smartcase = 1
map <Leader>s <Plug>(easymotion-bd-f2)
"use overwin version in normal mode as it jumps between windows as well
nmap <Leader>s <Plug>(easymotion-overwin-f2)

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

"ctrlp stuff
" ignore gitignored files
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  let g:ctrlp_use_caching = 0
endif

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlPMixed'
"nmap <c-g> :CtrlPBuffer<CR>

"NERDTree stuff
nmap <Leader>nt :NERDTreeFind<CR>

"undotree stuff
nmap <Leader>ut :UndotreeToggle<CR>

"ctags
let g:tagsupdate = 0

if filereadable('tags')
  let g:tagsupdate = 1
endif

function! DoTagsUpdateIfSet()
  if g:tagsupdate > 0
    silent! !sh $HOME/dotfiles/bin/tagsupdate.sh force > /dev/null 2>&1 &
  endif
endfunction
au BufWritePost * call DoTagsUpdateIfSet()

function! EnableTagsUpdate()
  let g:tagsupdate = 1
  call DoTagsUpdateIfSet()
endfunction

command! TagsUpdate call EnableTagsUpdate()

"Jedi-vim stuff
autocmd FileType python setlocal omnifunc=jedi#completions

"TagBar stuff
"also enable tags updating by opening the tagbar window this way
nmap <Leader>bta :TagbarToggle<CR>:let g:tagsupdate=1<CR>:let g:tagsupdate<CR>
nmap <Leader>tb :TagbarToggle<CR>:let g:tagsupdate=1<CR>:let g:tagsupdate<CR>

"grepping
"get rid of the /dev/null
set grepprg=grep\ -n\ $*
let grepexcludedirsall = '"*.git/*","build/*",outdir,CMakeFiles'
let grepexcludedirstest = grepexcludedirsall . ',"*deploy*"'
let grepexcludedirs = grepexcludedirsall . ',"*test","*deploy*"'
let grepexcludefiles = '"objdump*","assert_table*","*.ninja*","flash_placement.xml","*.map","*.ld",tags,"tags.*"'
"nmap <Leader>fc :cope<CR><c-W>W:gr! -r --include="*.[chsCHS]" -e "
"nmap <Leader>fd :cope<CR><c-W>W:gr! -r --include="*.dita" --include="*.ditamap" -e "
nmap <Leader>fa :cope<CR><c-W>W:gr! -r -I --exclude-dir={<c-r>=grepexcludedirsall<CR>} --exclude={<c-r>=grepexcludefiles<CR>} -i -e "
nmap <Leader>ft :cope<CR><c-W>W:gr! -r -I --exclude-dir={<c-r>=grepexcludedirstest<CR>} --exclude={<c-r>=grepexcludefiles<CR>} -i -e "
nmap <Leader>ff :cope<CR><c-W>W:gr! -r -I --exclude-dir={<c-r>=grepexcludedirs<CR>} --exclude={<c-r>=grepexcludefiles<CR>} -i -e "
nmap <Leader>f/ :cope<CR><c-W>W:gr! -r -I --exclude-dir={<c-r>=grepexcludedirs<CR>} --exclude={<c-r>=grepexcludefiles<CR>} -i -e "<c-r>/"<CR>

"relative line numbers
function! NumberToggle()
  if(&relativenumber == 1)
    set norelativenumber
  else
    set relativenumber
  endif
endfunc

nnoremap <Leader>1 :call NumberToggle()<cr>

"commenting
function! GenerateCommentString()
  "Remove the %s
  let localCommentString = substitute(&commentstring, '%s', '', '')

  " If localCommentString is /**/, replace with //
  if localCommentString =~# '/\*\*/'
    let localCommentString = '//'
  endif

  "Strip trailing spaces
  let localCommentString = substitute(localCommentString, '\s\+', '', '')
  return localCommentString
endfunction

function! InsertCommentString()
  let localCommentString = GenerateCommentString()
  let line = localCommentString . getline('.')
  "deletes the current line
  delete
  put! =line
  +
endfunction

function! DeleteCommentString()
  let localCommentString = GenerateCommentString()
  let line=getline('.')
  if line =~# '^\s*' . localCommentString
    let line = substitute(line, localCommentString, '', '')
    "deletes the current line
    delete
    put! =line
    +
  endif
endfunction

nmap \ :call InsertCommentString()<CR>
nmap <bar> :call DeleteCommentString()<CR>
"selection
vmap \ :call InsertCommentString()<CR>
vmap <bar> :call DeleteCommentString()<CR>
"NERDcommenter nerdcommenter
let g:NERDSpaceDelims = 1

"quickfix window height
au FileType qf call AdjustWindowHeight(3, 20)
function! AdjustWindowHeight(minheight, maxheight)
  exe max([min([line("$")+5, a:maxheight]), a:minheight]) . "wincmd _"
  "exe max([min([a:maxheight, a:maxheight]), a:minheight]) . "wincmd _"
endfunction

"minimap stuff
let g:minimap_highlight='Visual'

if getcwd() =~ 'zephyr'
    set noexpandtab
    set tabstop=8
    set shiftwidth=8
    set textwidth=80
    set colorcolumn=80
    au BufEnter * 2match Tabs /^\ \ \ \ \+/
endif

if getcwd() =~ 'connomesikom'
    au BufEnter * 2match none
    au BufEnter * match none
endif
