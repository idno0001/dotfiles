" Use pathogen.
call pathogen#infect()

" Use vim (not vi) settings.
set nocompatible

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
      \ | wincmd p | diffthis
endif

" Use `,' as a mapleader instead of `\'.
let mapleader = ","

" Map `,v' to open the .vimrc file in a new tab.
nmap <leader>v :edit $MYVIMRC<CR>

" Font, window size and colour scheme.
if has('gui_running')
  set lines=55 columns=85
  if has('win32')
    set guifont=Consolas:h9
  else
    set guifont=DejaVu\ Sans\ Mono\ 8
  endif
endif

:colorscheme zenburn

" Use tabs for indentation only, width = 4.
:set noet ci pi sts=0 sw=2 ts=2

" Line numbers, highlight current line.
:set number
:set cursorline

" Disable warnings regarding modified buffers when switching buffers.
:set hidden

" %% expands the directory of the current file. In addition, we have mappings
" to open files relative to the current file: ew (open in window), es (open in
" split), ev (open in vertical split) and et (open in tab).
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%
map <leader>et :tabe %%

" Make the netrw file explorer use tree-mode and a few other nice tweaks.
let g:netrw_liststyle=3 " Use tree-mode as default view
let g:netrw_browse_split=4 " Open file in previous buffer
let g:netrw_preview=1 " preview window shown in a vertically split

" Reformat the hard linebreaks in a paragraph when changes are made. (Screws a
" lot of things up when it's not just raw text.)
" :set fo+=a

" Toggle spell checking with `,s'.
nmap <silent> <leader>s :set spell!<CR>
set spelllang=en_gb

" Map `,g' to gundo.
nnoremap <leader>g :GundoToggle<CR>

" Unix like auto-completion
set wildmenu
set wildmode=list:longest

" Ignore files spat out by LaTeX and friends.
set wildignore+=*.aux,*.bbl,*.blg,*.glg,*.glo,*.ist,*.log,*.out,*.pdf,*.sbl,*.sym,*.thm,*.toc,*~,*-blx.bib,*.fdb_latexmk,*.run.xml

" Ignore case sensitivity when searching
set ignorecase

" ...but only if lower case letters are used.
set smartcase

" Soft wrap long lines, navigate them using the j and k keys.
setlocal wrap nolist linebreak breakat=\ 
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" Automatically insert line breaks for tex files.
au BufEnter *.tex setl tx ts=2 sw=2 fo+=wa

" Indent options for tex files.
let g:tex_indent_brace = 1
let g:tex_indent_items = 1

" Soft wrap keybinding.
command! -nargs=* Wrap set wrap linebreak nolist

" Use par to format text.
:set formatprg=par\ -w78q

" Line endings.
:set fileformats=unix,dos
:set fileformat=unix

" Conceal. Colour scheme is for Zenburn. Do not conceal (sub|super)scripts.
set cole=2
hi Conceal guibg=#3f3f3f guifg=#dcdccc font='DejaVu Sans Mono'
let g:tex_conceal="adgm"

" Unicode support.
if has("multi_byte")
  if &termencoding == ""
    let &termencoding = &encoding
  endif
  set encoding=utf-8
  setglobal fileencoding=utf-8
  "setglobal bomb
  set fileencodings=ucs-bom,utf-8,latin1
endif

" Latex-Suite-specific things.
" REQUIRED. This makes vim invoke Latex-Suite when you open a tex file.
filetype plugin on

" IMPORTANT: win32 users will need to have 'shellslash' set so that latex
" can be called correctly.
if has('win32')
  set shellslash
endif

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

" Stop autofolding in Latex-Suite.
let g:Tex_AutoFolding = 0

