" All system-wide defaults are set in $VIMRUNTIME/debian.vim (usually just
" /usr/share/vim/vimcurrent/debian.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vim/vimrc), since debian.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing debian.vim since it alters the value of the
" 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible

filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

let mapleader = ","

set t_Co=256

"colorscheme icansee

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

" Uncomment the following to have Vim load indentation rules according to the
" detected filetype. Per default Debian Vim only load filetype specific
" plugins.
if has("autocmd")
  filetype indent on
endif

set autowrite           " Automatically save before commands like :next and :make
set display=lastline
set expandtab
set hidden              " Hide buffers when they are abandoned
set history=1000
set hlsearch
set ignorecase          " Do case insensitive matching
set incsearch           " Incremental search
set mouse=a             " Enable mouse usage (all modes) in terminals
set number
set scrolloff=3         " (11/11/08 albert) when pushing the screen up/down with the cursor, scroll by more than 1 line at a time
set showcmd             " Show (partial) command in status line.
set showmatch           " Show matching brackets.
set smartcase           " Do smart case matching
set sts=4
set sw=4
set tabstop=4
set timeoutlen=200
set title
set wildmenu
set wildmode=list:longest
set shortmess+=I

set nobackup
set directory=/var/tmp,/tmp

" au! BufRead,BufNewFile * lc %:p:h

colorscheme desert256
syntax sync fromstart

" switch ' and `
nnoremap ' `
nnoremap ` '
nnoremap <C -e> 5<C -e> " scroll more than one line at a time Ctrl-e
nnoremap <C -y> 5<C -y> " scroll more than one line at a time Ctrl-y

imap <C-d> <C-[>ciw
imap <C-e> <C-[>eli<C-w>

" imap jkl <esc>

map <c-f10> :s/^/#<cr>:noh<cr>      " python comment
map <c-s-f10> :s/^#//<cr>:noh<cr>   " python uncomment
map <c-f8> :s/=/    =/g<cr>:noh<cr>
map <c-s-f8> :s/    =/=/g<cr>:noh<cr>
map <c-f9> :s/=/    =/gc<cr>
map <c-s-f9> :s/    =/=/gc<cr>
map :jj :tabnext
map :kk :tabprev

" my stuff

" Folding functions etc (just type 'za')
set foldmethod=indent
set foldlevel=99

" Opening, Saving, Quiting
map <leader>e :e 
map <leader>w :w<CR>
map <leader>q :q<CR>

" Window Navigation
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" Tasklists
map <leader>td <Plug>TaskList

" Revision History - XXX this doesn't work until vim 7.3 :(
map <leader>g :GundoToggle<CR> 

" Syntax Highlighting and Validation
syntax on                    " syntax highlighing
filetype on                  " try to detect filetypes
filetype plugin indent on    " enable loading indent file for filetype

let g:pyflakes_use_quickfix = 0

" Pep8 - XXX might not work right now
let g:pep8_map='<leader>8'

" Tab completion / Documetation
au FileType python set omnifunc=pythoncomplete#Complete
let g:SuperTabDefaultCompletionType = "context"

set completeopt=menuone,longest,preview

" File Browser
map <leader>n :NERDTreeToggle<CR>

" Refactoring and Go to definition - XXX this doesn't work right now :(
map <leader>j :RopeGotoDefinition<CR>
map <leader>r :RopeRename<CR>

" Searching - XXX this doesn't work right now :(
nmap <leader>a <Esc>:Ack!

" Test Integration - XXX figure out what this is good for
map <leader>dt :set makeprg=python\ manager.py\ test\|:call MakeGreen()<CR>

" Add the virtualenv's site-packages to vim path
py << EOF
import os.path
import sys
import vim
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    sys.path.insert(0, project_base_dir)
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
EOF
