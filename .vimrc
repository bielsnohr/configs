" -----------------------------------------------------------------------------
"  Matthew Bluteau's vimrc file
" -----------------------------------------------------------------------------

"  Vundle
" -----------------------------------------------------------------------------
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Plugins
" -------
" Python code folding
Plugin 'tmhedberg/SimpylFold'
" Indent Python correctly
Plugin 'vim-scripts/indentpython.vim'
" PEP8 compliance
Plugin 'nvie/vim-flake8'
" Code completion
Plugin 'ycm-core/YouCompleteMe'
" Syntax checker
Plugin 'vim-syntastic/syntastic'
" LaTeX integration
Plugin 'vim-latex/vim-latex'
" File tree viewer NERDtree
Plugin 'preservim/nerdtree'
" Fuzzy file search
Plugin 'ctrlpvim/ctrlp.vim'
" Git client
Plugin 'tpope/vim-fugitive'
" Task list of future development items
Plugin 'vim-scripts/TaskList.vim'
" File history / change list tree
" TODO this doesn't work with Python 3. Find an alternative that does.
"Plugin 'sjl/gundo.vim'
" Enhanced status line
Plugin 'powerline/powerline', {'rtp': 'powerline/bindings/vim/'}
" Color schemes
Plugin 'jnurmine/Zenburn'
Plugin 'altercation/vim-colors-solarized'

"" The following are examples of different formats supported.
"" Keep Plugin commands between vundle#begin/end.
"" plugin on GitHub repo
"Plugin 'tpope/vim-fugitive'
"" plugin from http://vim-scripts.org/vim/scripts.html
"" Plugin 'L9'
"" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
"" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
"" The sparkup vim script is in a subdirectory of this repo called vim.
"" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
"" Install L9 and avoid a Naming conflict if you've already installed a
"" different version somewhere else.
"" Plugin 'ascenator/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
" -----------------------------------------------------------------------------

"  Python settings
" --------------------------------------
" TODO consider putting this into a separate file in
" .vim/after/ftplugin/python.vim
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix 
set encoding=utf-8
let python_highlight_all=1
" TODO supposedly this allows for virtual envs to work, test
let g:ycm_python_binary_path = 'python'
""virtualenv support TODO test if this works and how it will interact with conda
""there is also vim-conda plugin that handles conda environments
"python3 << EOF
"import os
"import sys
"if 'VIRTUAL_ENV' in os.environ:
"  project_base_dir = os.environ['VIRTUAL_ENV']
"  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
"  execfile(activate_this, dict(__file__=activate_this))
"EOF

"  C++ settings
" --------------------------------------
au Filetype cpp setlocal shiftwidth=2 softtabstop=2 expandtab

"  Latex-Suite settings
" --------------------------------------
" IMPORTANT: win32 users will need to have 'shellslash' set so that latex
" can be called correctly.
set shellslash
" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*
" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor = 'latex'
let g:tex_indent_items = 1
let g:tex_indent_brace = 1
let g:Tex_UseMakefile = 0
let g:Tex_DefaultTargetFormat = 'pdf'
autocmd Filetype tex setlocal ts=2 sw=2 expandtab

"  YouCompleteMe settings
" --------------------------------------
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>yg  :YcmCompleter GoToDefinitionElseDeclaration<CR>
map <leader>yd  :YcmCompleter GetDoc<CR>

"  Syntastic settings
" --------------------------------------
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 1
let g:syntastic_python_checkers = ['flake8', 'pyflakes']
"let g:syntastic_python_python_exec = '/home/matthew/anaconda3/bin/python'
let g:syntastic_enable_perl_checker = 1
let g:syntastic_perl_checkers = ['perl']
let g:syntastic_fortran_compiler = 'gfortran'

"  CtrlP settings
" --------------------------------------
let g:ctrlp_map = '<leader>p'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip 
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'

"  SimplyFold settings
" --------------------------------------


"  General settings
" --------------------------------------
"  Color schemes
if has('gui_running')
	set background=dark
	colorscheme solarized
else
	colorscheme zenburn
endif

"  Copying and pasting mappings
map <C-P> "+gP
map <C-p> "+gp
map <C-S> "+y

"  Swap file storage (to allow for recovery when editing on sshfs)
set directory=~/.tmp//
set backupdir=~/.bkp//

"  Syntax Highlighting and Indentation
syntax on

"  Key mappings
map <leader>td  <Plug>TaskList
map <leader>g :GundoToggle<CR>
map <leader>n :NERDTreeToggle<CR>
"edit vimrc quickly
nnoremap <leader>ev :sp $MYVIMRC<CR>
"source vimrc quickly
nnoremap <leader>sv :source $MYVIMRC<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>
nmap cp :let @" = expand("%:p")<CR>
"change the local current working directory
nnoremap ,cd :lcd %:p:h<CR>:pwd<CR>
"use grep-like programs to search word under cursor in other files
nnoremap gr :Ggrep! '\b<cword>\b' <CR>
"nnoremap gr :grep <cword> *<CR>
"nnoremap Gr :grep <cword> %:p:h/*<CR>
"nnoremap gR :grep '\b<cword>\b' *<CR>
"nnoremap GR :grep '\b<cword>\b' %:p:h/*<CR>

"  Code Folding
set foldmethod=indent
set foldlevel=99
" Enable folding with the spacebar
nnoremap<space> za

"  Hard text wrapping so the below never needs to be implemented
set tw=79
set formatoptions+=t

"  Indicate with colour where the 80 character column is
"  colorcolumn is only available after Vim 7.3
if version > 702
	set colorcolumn=80
else
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
	set guifont=Ubuntu\ Mono\ derivative\ Powerline\ 15
        let g:Powerline_symbols = 'fancy'
endif
"  Leave a highlight on the current line
set cursorline
" Always show status bar
set laststatus=2

" pandoc , markdown
command! -nargs=* RunSilent
      \ | execute ':silent !'.'<args>'
      \ | execute ':redraw!'
nmap <Leader>mc :RunSilent pandoc -o /tmp/vim-pandoc-out.pdf %<CR>
nmap <Leader>mp :RunSilent evince /tmp/vim-pandoc-out.pdf &<CR>
