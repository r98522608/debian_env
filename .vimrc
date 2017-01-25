set nocompatible
filetype off

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
Plugin 'nvie/vim-flake8'
Plugin 'vim-scripts/Pydiction'
let g:pydiction_location = '~/.vim/bundle/Pydiction/complete-dict'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'scrooloose/syntastic'

"auto-completion stuff
"Plugin 'klen/python-mode'
Plugin 'Valloric/YouCompleteMe'
Plugin 'klen/rope-vim'
"Plugin 'davidhalter/jedi-vim'
Plugin 'ervandew/supertab'
""code folding
Plugin 'tmhedberg/SimpylFold'

"Colors!!!
Plugin 'altercation/vim-colors-solarized'
Plugin 'jnurmine/Zenburn'


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
" remember download yapf, 
"let g:formatter_yapf_style = 'pep8'
noremap <C-F4> :Autoformat<CR>


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


"
"call togglebg#map("<F5>")
"colorscheme zenburn
"set guifont=Monaco:h14

let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree

"I don't like swap files
set noswapfile

"turn on numbering
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
au BufRead,BufNewFile *py,*pyw,*.c,*.h set tabstop=4

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

nnoremap <C-F6>   <Esc>:w<CR>iimport sys<CR>from PyQt5.QtWidgets import QApplication, QWidget<CR>from PyQt5.QtGui import QIcon
nnoremap <C-F7>   <Esc>:w<CR>:!python2.7 %<CR>
nnoremap <silent> # :s#^#\##<cr>:noh<cr>
nnoremap <silent> -# :s#^\###<cr>:noh<cr>

