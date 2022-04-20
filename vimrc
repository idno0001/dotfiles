set nocompatible    " use vim settings

" load vundle
filetype off
if has('win32')
  set rtp+=$VIM/vimfiles/bundle/Vundle.vim
else
  set rtp+=~/.vim/bundle/Vundle.vim
endif
call vundle#begin()

" let Vundle manage Vundle
Plugin 'gmarik/Vundle.vim'

" tpope bundles:
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-obsession'
Plugin 'tpope/vim-speeddating'

" vim-scripts GitHub bundles:
Plugin 'vim-scripts/Smart-Tabs'
" Plugin 'vim-scripts/tex.vim--Tanzler'
Plugin 'vim-scripts/matchit.zip'
Plugin 'vim-scripts/Rename'

" other bundles:
Plugin 'altercation/vim-colors-solarized'
Plugin 'vim-latex/vim-latex'
Plugin 'mbbill/undotree'
Plugin 'jnurmine/Zenburn'
Plugin 'ervandew/supertab'
Plugin 'itchyny/lightline.vim'
Plugin 'spiiph/vim-space'
Plugin 'jeffkreeftmeijer/vim-numbertoggle'
Plugin 'justinmk/vim-ipmotion'
Plugin 'vim-pandoc/vim-pandoc'
Plugin 'vim-pandoc/vim-pandoc-syntax'
" Plugin 'jalvesaq/R-Vim-runtime'
Plugin 'jceb/vim-orgmode'
Plugin 'jalvesaq/Nvim-R'
Plugin 'git@github.com:vimwiki/vimwiki.git'
Plugin 'powerman/vim-plugin-AnsiEsc'
Plugin 'majutsushi/tagbar'

call vundle#end()

" lightline options
let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ }

colorscheme solarized       " solarized light
syntax enable               " enable syntax processing

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup    " do not keep a backup file, use versions instead
else
  set backup    " keep a backup file
  set backupcopy=yes    " copy the old file and write to the current file
endif
set history=50    " keep 50 lines of command line history
set ruler   " show the cursor position all the time
set showcmd   " display incomplete commands
set incsearch   " do incremental searching

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
  
  " Use text width of 70 for muttator and various embellishments.
  autocmd BufRead mutt-ator-mail* setlocal textwidth=70
  autocmd BufRead mutt-ator-mail* set formatprg=par\ -w70q
  autocmd BufRead mutt-ator-mail* set fo+=wan
  
  " Use text width of 70 for Gmail when using pentadactyl.
  autocmd BufRead pentadactyl.mail.google.com.txt* setlocal textwidth=70
  autocmd BufRead pentadactyl.mail.google.com.txt* set formatprg=par\ -w70q
  autocmd BufRead pentadactyl.mail.google.com.txt* set fo+=wan
  
  " " Fix Gmail's new compose experience: make plain text *plain*.
  " autocmd BufRead pentadactyl.mail.google.com.txt* %s/<br>/\r/g
  " autocmd BufWriteCmd pentadactyl.mail.google.com.txt* %s/\n/<br>/g

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

  set autoindent    " always set autoindenting on

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
nmap <leader>v :tabedit $MYVIMRC<CR>

" Font, window size and colour scheme.
if has('gui_running')
  " set lines=55 columns=85
  if has('win32')
    set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h8
  elseif has("unix")
    let s:uname = substitute(system("uname -s"), '\n', '', '')
    if s:uname == "Darwin"
      set guifont=Menlo:h12
    else
      set guifont=DejaVu\ Sans\ Mono\ 10
    endif
  endif
  let Powerline_symbols='fancy'
  
  "Hide the toolbar and menu bar in gvim.
  set guioptions-=T
  set guioptions-=m
endif

set expandtab        " tabs are spaces
set copyindent       " copies the indentation of the existing line
set preserveindent   " preserve the indentation of the line being edited
set tabstop=2        " number of visual spaces per tab
set softtabstop=2    " number of spaces in a tab when editing
set shiftwidth=2     " number of spaces for each step of autoindent

" Use SuperRetab to convert spaces to tabs (inverse of standard vim retab).
" Usage: Visually select the lines that you want to retab, then enter
" :'<,'> SuperRetab 2
" to replace all two-space indents with tab characters.
command! -nargs=1 -range SuperRetab <line1>,<line2>s/\v%(^ *)@<= {<args>}/\t/g

" Line numbers, highlight current line.
set cursorline
set number

" Disable warnings regarding modified buffers when switching buffers.
set hidden

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
set fo+=wan1cqt

" Toggle spell checking with `,s'.
nmap <silent> <leader>s :set spell!<CR>
set spelllang=en_gb

" Map `,g' to gundo.
" nnoremap <leader>g :GundoToggle<CR>

" ,g toggles the undo tree.
nnoremap <leader>g :UndotreeToggle<CR>

" Persistent undo: http://stackoverflow.com/a/22676189/1262569
" Put plugins and dictionaries in this dir (also on Windows)
let vimDir = '$HOME/.vim'
let &runtimepath.=','.vimDir

" Keep undo history across sessions by storing it in a file
if has('persistent_undo')
    let myUndoDir = expand(vimDir . '/undodir')
    " Create dirs
    call system('mkdir ' . vimDir)
    call system('mkdir ' . myUndoDir)
    let &undodir = myUndoDir
    set undofile
endif

" Unix like auto-completion
set wildmenu
set wildmode=list:longest

" Ignore files spat out by LaTeX and friends.
set wildignore+=*.aux,*.bbl,*.blg,*.fls,*.glg,*.glo,*.gls,*.gz,*.ist,*.log,*.out,*.pdf,*.sbl,*.sym,*.thm,*.toc,*~,*-blx.bib,*.fdb_latexmk,*.run.xml

" Ignore case sensitivity when searching
set ignorecase

" ...but only if lower case letters are used.
set smartcase

" Soft wrap long lines, navigate them using the j and k keys.
setlocal wrap nolist linebreak breakat=\ 
vmap <D-j> gj
vmap <D-k> gk
vmap <D-4> g$
vmap <D-6> g^
vmap <D-0> g^
nmap <D-j> gj
nmap <D-k> gk
nmap <D-4> g$
nmap <D-6> g^
nmap <D-0> g^

" Disable the arrow keys.
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

" Soft wrap keybinding.
command! -nargs=* Wrap set wrap linebreak nolist

" Use par to format text.
set formatprg=par\ -w78q

" Line endings.
set fileformat=unix
set fileformats=unix,dos

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

" Always show status line.
set laststatus=2

" Center searches.
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

" Use modified powerline fonts for airline.
let g:airline_powerline_fonts = 1

" Do not warn about trailing whitespace in Airline.
let g:airline_detect_whitespace=0

" Do not double space between sentences.
set nojoinspaces

" List all buffers and populate the prompt for buffer switching.
nnoremap gb :ls<CR>:b<Space>

" Rmd uses markdown syntax highlighting.
" au BufNewFile,BufRead *.Rmd set filetype=markdown

" Comment string for Rmd files.
autocmd FileType Rmd setlocal commentstring=#\ %s

" R script settings
let maplocalleader = ","
vmap <Space> <Plug>RDSendSelection
nmap <Space> <Plug>RDSendLine
let vimrplugin_applescript=0
let vimrplugin_vsplit=1

