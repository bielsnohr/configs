" -----------------------------------------------------------------------------
"  Matthew Bluteau's vimrc file
" -----------------------------------------------------------------------------
let g:gundo_prefer_python3 = 1 
" Pathogen stuff for autoloading packages in $VIM/bundles
filetype off
"call pathogen#incubate()
call pathogen#infect()
call pathogen#helptags()
filetype on

"  Latex-Suite settings
" --------------------------------------
" REQUIRED. This makes vim invoke Latex-Suite when you open a tex file.
filetype plugin on
" IMPORTANT: win32 users will need to have 'shellslash' set so that latex
" can be called correctly.
set shellslash
" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*
" OPTIONAL: This enables automatic indentation as you type.
filetype indent on
" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'
let g:tex_indent_items = 1
let g:tex_indent_brace = 1

"  Python settings
" --------------------------------------

"  Supertab settings
" --------------------------------------
au FileType python set omnifunc=python3complete#Complete
let g:SuperTabDefaultCompletionType = "context"
set completeopt=menuone,longest,preview

"  Syntastic settings
" --------------------------------------
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 1
let g:syntastic_python_checkers = ['pyflakes']
let g:syntastic_python_python_exec = '/home/matthew/anaconda3/bin/python'
let g:syntastic_enable_perl_checker = 1
let g:syntastic_perl_checkers = ['perl']

"  CommandT settings
" --------------------------------------
let g:CommandTWildIgnore=&wildignore . ",anaconda3/**"

"  General settings
" --------------------------------------
"  Copying and pasting mappings
map <C-P> "+gP
map <C-p> "+gp
map <C-S> "+y

"  Swap file storage (to allow for recovery when editing on sshfs)
set directory=~/.tmp//
set backupdir=~/.bkp//

"  Syntax Highlighting and Indentation
syntax on
filetype indent plugin on
filetype plugin indent on

"  Key mappings
map <leader>td  <Plug>TaskList
map <leader>g :GundoToggle<CR>
map <leader>n :NERDTreeToggle<CR>
"edit vimrc quickly
nnoremap <leader>ev :sp $MYVIMRC<CR>
"source vimrc quickly
nnoremap <leader>sv :source $MYVIMRC<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>
nmap cp :let @" = expand("%")
"change the local current working directory
nnoremap ,cd :lcd %:p:h<CR>:pwd<CR>

"  Code Folding
set foldmethod=indent
set foldlevel=99

"  Hard text wrapping so the below never needs to be implemented
set tw=79
set formatoptions+=t

"  Indicate with colour where the 80 character column is
"  colorcolumn is only available after Vim 7.3
if version > 702
	set colorcolumn=80
else
	"autocmd BufWinEnter * call matchadd('ErrorMsg', '\%>'.&l:textwidth.'v.\+', -1)
	match ErrorMsg /\%>80v.\+/
endif
"  Keep closed buffers in the background
set hidden
"  Set line numbering
set number
"  Set spell checking on
set spell
"  Control auto-complete behaviour: complete to longest string, and list alt
set wildmode=list:longest
"  Make moving between vim windows quicker
map <c-n> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h
"  Search visually selected text
vnorem // y/<c-r>"<cr>
"  Make sure backspace works
set backspace=2
"  Set gui relevant parameters
if has("gui_running")
	"  Set window size
	set lines=999 columns=85
	"  Set the font for gui application
	set guifont=Monospace\ 11
endif
"  Leave a highlight on the current line
set cursorline
