set nocompatible
filetype off
set bg=light
set laststatus=2

set rtp+=/home/ives/.vim/bundle/Vundle.vim
call vundle#begin('/home/ives/.vim/bundle')
"call vundle#begin()


Plugin 'VundleVim/Vundle.vim'
"git interface
Plugin 'tpope/vim-fugitive'
"filesystem
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'kien/ctrlp.vim' 

"html
Plugin 'isnowfy/python-vim-instant-markdown'
Plugin 'jtratner/vim-flavored-markdown'
Plugin 'suan/vim-instant-markdown'
Plugin 'nelstrom/vim-markdown-preview'
"python sytax checker
"Plugin 'nvie/vim-flake8'
Plugin 'vim-scripts/Pydiction'
let g:pydiction_location = '/home/ives/.vim/bundle/Pydiction/complete-dict'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'scrooloose/syntastic'

"auto-completion stuff
Plugin 'Valloric/YouCompleteMe'
Plugin 'klen/rope-vim'
"Plugin 'davidhalter/jedi-vim'
Plugin 'ervandew/supertab'
""code folding
Plugin 'tmhedberg/SimpylFold'

"Colors!!!
Plugin 'altercation/vim-colors-solarized'
Plugin 'jnurmine/Zenburn'
Plugin 'rafi/awesome-vim-colorschemes'
"Plugin 'python-mode/python-mode'


"Ives recommend
Plugin 'Raimondi/delimitMate'
Plugin 'fholgado/minibufexpl.vim'
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1
let g:miniBufExplMoreThanOne=0
map <C-F11> :MBEbp<CR>
map <F12> :MBEbn<CR>
Plugin 'majutsushi/tagbar'
let g:tagbar_ctags_bin='/usr/bin/ctags'               
let g:tagbar_width=30          
map <F3> :Tagbar<CR>
Plugin 'scrooloose/nerdcommenter'
Plugin 'Chiel92/vim-autoformat'
"" remember download yapf, 
"let g:formatter_yapf_style = 'pep8'
noremap <C-F4> :Autoformat<CR>

set tabstop=4
Plugin 'r98522608/vim-test'
call vundle#end()

filetype plugin indent on    " enables filetype detection
let g:SimpylFold_docstring_preview = 1

"autocomplete
let g:ycm_autoclose_preview_window_after_completion=1

"custom keys
let mapleader="\\"
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
" space+g jump in
" ctl+i ctl+o =>jump back or forward
colorscheme zenburn
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree
set noswapfile
"turn on numbering
set rnu
set nu

"python with virtualenv support
"if has('python3')
py << EOF
import os.path
import sys
import vim
if 'VIRTUA_ENV' in os.environ:
	project_base_dir = os.environ['VIRTUAL_ENV']
      	sys.path.insert(0, project_base_dir)
      	activate_this = os.path.join(project_base_dir,'bin/activate_this.py')
      	execfile(activate_this, dict(__file__=activate_this))
EOF
"endif

"it would be nice to set tag files by the active virtualenv here
":set tags=~/mytags "tags for ctags and taglist
"omnicomplete
"autocmd FileType python set omnifunc=pythoncomplete#Complete

"------------Start Python PEP 8 stuff----------------
" Number of spaces that a pre-existing tab is equal to.
au BufRead,BufNewFile *py,*pyw,*.c,*.h,vimrc set tabstop=4

"spaces for indents
au BufRead,BufNewFile *.py,*pyw set shiftwidth=4
au BufRead,BufNewFile *.py,*.pyw set expandtab
au BufRead,BufNewFile *.py set softtabstop=4

" Use the below highlight group when displaying bad whitespace is desired.
highlight BadWhitespace ctermbg=red guibg=red

" Display tabs at the beginning of a line in Python mode as bad.
au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/
" Make trailing whitespace be flagged as bad.
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" Wrap text after a certain number of characters
au BufRead,BufNewFile *.py,*.pyw, set textwidth=100

" Use UNIX (\n) line endings.
au BufNewFile *.py,*.pyw,*.c,*.h set fileformat=unix

" Set the default file encoding to UTF-8:
set encoding=utf-8

" For full syntax highlighting:
let python_highlight_all=1
syntax on

" Keep indentation level from previous line:
autocmd FileType python set autoindent

" make backspaces more powerfull
set backspace=indent,eol,start


"Folding based on indentation:
autocmd FileType python set foldmethod=indent
"use space to open folds
nnoremap <F4>	<space> zR 
nnoremap <F5>	<space> zM 
nnoremap <F6>	<space> za 
"----------Stop python PEP 8 stuff--------------

"js stuff"
"autocmd FileType javascript setlocal shiftwidth=2 tabstop=2

let NERDTreeWinPos='left'
let NERDTreeWinSize=30
map <F2> :NERDTreeToggle<CR>
let delimitMate_expand_cr = 1
set tags=$TAGS;/
"set winwidth=122
"set winminwidth=35
"let g:ycm_python_binary_path='./venv/bin/python'

"""------------------------------ Key Mapping -------------------------"""
nnoremap <silent> # :s#^#\##<cr>:noh<cr>
nnoremap <silent> -# :s#^\###<cr>:noh<cr>
nnoremap <C-F6>   <Esc>:w<CR>:!python2.7 %<CR>
inoremap <F7>   <Esc>a<CR>print()<Esc>i
nnoremap <C-F7>   <Esc>:w<CR>:!python3 %<CR>
nnoremap <Tab>   <Esc>:set nornu!<CR><Esc>:set nonu!<CR>
nnoremap ;s   <Esc>:call Searchwindow(input("Enter search: "))<CR>

imap <silent> <C-D><C-D> <C-R>=strftime("%e %b %Y")<CR>
imap <silent>  <C-D>#  <C-R>=Commentblock(input("Enter comment: "),'#','#')<CR>
imap <silent>  <C-D>]  <C-R>=Commentblock(input("Enter comment: "),'"""','-')<CR>
imap <silent>  <C-D>\  <C-R>=Commentblock(input("Enter comment: "),'//','//')<CR>
nnoremap <silent> <C-D>h  <ESC>:call Pydocccc(input("pydoc file: "))<CR>

"""window resize
noremap <C-w>, <C-w><
noremap <C-w>. <C-w>>

"""------------------------------ Key Mapping ------------------------------"""
"""
"""
"""
"""------------------------------ Private Function -------------------------"""
function Pydocccc(keyw)
		exec "!pydoc " . a:keyw
endfunction
function Commentblock(cmt, ...)
let intro = a:0 >= 1 ? a:1 : "#"
let box_char = a:0 >= 2 ? a:2 : "="
"let width = a:0 >= 3 ? a:3 : strlen(a:cmt) + 2
let width = 79
return intro . repeat(box_char,width) . "\<CR>"
			\ . intro . "  " . strftime("%b %e, %Y") . ", Ives" . "\<CR>"
			\ . intro . "  1. Intro: " . a:cmt . "\<CR>"
			\ . intro . repeat(box_char,width) . "\<CR>"
endfunction	

function AlignAssignments ()
    "Patterns needed to locate assignment operators...
    :let ASSIGN_OP   = '[-+*/%|&]\?=\@<!=[=~]\@!'
    let ASSIGN_LINE = '^\(.\{-}\)\s*\(' . ASSIGN_OP . '\)'
 
    "Locate block of code to be considered (same indentation, no blanks)
    let indent_pat = '^' . matchstr(getline('.'), '^\s*') . '\S'
    "echom indent_pat
    let firstline  = search('^\%('. indent_pat . '\)\@!','bnW') + 1
    "echom firstline
    let lastline   = search('^\%('. indent_pat . '\)\@!', 'nW') - 1
    "echom lastline
    if lastline < 0
        let lastline = line('$')
    endif
 
    "Find the column at which the operators should be aligned...
    let max_align_col = 0
    let max_op_width  = 0
    for linetext in getline(firstline, lastline)
        "Does this line have an assignment in it?
        let left_width = match(linetext, '\s*' . ASSIGN_OP)
 
        "If so, track the maximal assignment column and operator width...
        if left_width >= 0
            let max_align_col = max([max_align_col, left_width])
 
            let op_width      = strlen(matchstr(linetext, ASSIGN_OP))
            let max_op_width  = max([max_op_width, op_width+1])
         endif
    endfor
 
    "Code needed to reformat lines so as to align operators...
    let FORMATTER = '\=printf("%-*s%*s", max_align_col, submatch(1),
    \                                    max_op_width,  submatch(2))'
 
    " Reformat lines with operators aligned in the appropriate column...
    for linenum in range(firstline, lastline)
        let oldline = getline(linenum)
        let newline = substitute(oldline, ASSIGN_LINE, FORMATTER, "")
        call setline(linenum, newline)
    endfor
endfunction
 
nmap <silent>  ;=  :call AlignAssignments()<CR>

function Helloworld()
python << EOF
import vim

#print("Hello world! {}".format(vim.current.buffer.name))
EOF
endfunction

function Searchwindow(...)
let keyw = a:0 >= 1 ? a:1 : "none"
let pbuffer = a:0 >= 2 ? a:2 : buffer_name("%")
let sflag = 0
let mylist = []
if  a:0 >= 1
		echom "enter if"
	let sflag = 1
	while 1
		let num = search(keyw,'W')
		echom num
		if num == 0
			break
		endif
		let mylist = add(mylist,num)
	endwhile
endif

set splitright
vsplit tmp
set nu
set nornu
vertical resize 50%
set nosplitright
endfunction
"""------------------------------ End Private Function -------------------------"""
"""---------------------status line
hi User1 ctermbg=green 			ctermfg=red   
hi User2 ctermbg=blue  			ctermfg=green 
hi User3 ctermbg=darkmagenta   	ctermfg=black
hi User4 ctermbg=red   			ctermfg=black
function! Modevim()
    redraw
    let l:mode = mode()
    if     mode ==# "n"  | return "NORMAL"
    elseif mode ==# "i"  | return "INSERT"
    elseif mode ==# "R"  | return "REPLACE"
    elseif mode ==# "v"  | return "VISUAL"
    elseif mode ==# "V"  | return "V-LINE"
    elseif mode ==# "" | return "V-BLOCK"
    else                 | return l:mode
    endif
endfunc 
function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction
function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0?'git:'.l:branchname.' ':''
endfunction
function! Getpercent()
	return line('.') * 100 / line('$') . '%'
endfunction
set statusline=
set statusline+=%4*%{Modevim()}%0*\ |
set statusline+=%1*%{StatuslineGit()}
"set statusline+=%1*%{StatuslineGit()}%0*\ |
set statusline+=%2*Current\ line:\ %l\ 
set statusline+=/\%-L(%2p%%), 
set statusline+=\ col:\ %c%0*\ | 
set statusline+=%3*Filetype:\ %y\ Filepath:\ %F%0*
"""-------------------------------------------------------------------------------
