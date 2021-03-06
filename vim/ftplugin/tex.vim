" Latex-Suite-specific things.
" REQUIRED. This makes vim invoke Latex-Suite when you open a tex file.
filetype plugin on

" IMPORTANT: win32 users will need to have 'shellslash' set so that latex
" can be called correctly.
if has('win32')
  set shellslash
endif

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a single file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

" OPTIONAL: This enables automatic indentation as you type.
filetype indent on

" Stop autofolding in Latex-Suite.
let g:Tex_AutoFolding = 0
let g:Tex_FoldedSections=""
let g:Tex_FoldedEnvironments=""
let g:Tex_FoldedMisc=""
autocmd Filetype tex setlocal nofoldenable

" Default to PDF.
" let g:Tex_DefaultTargetFormat = 'pdf'

" Use okular for viewing things.
" let g:Tex_ViewRule_ps = 'evince'
" let g:Tex_ViewRule_pdf = 'evince'
" let g:Tex_ViewRule_dvi = 'evince'
let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_MultipleCompileFormats = 'dvi,pdf'
let g:Tex_CompileRule_pdf = 'pdflatex -synctex=1 -shell-escape -interaction=nonstopmode $*'

if has('win32')
  let g:Tex_ViewRule_pdf = 'SumatraPDF -reuse-instance'
else
  if executable('evince')
    let g:Tex_ViewRule_ps = 'evince'
    let g:Tex_ViewRule_pdf = 'evince'
    let g:Tex_ViewRule_dvi = 'evince'
  endif
endif


" End of Latex-Suite-specific things.

" Automatically insert line breaks for tex files.
" au BufEnter *.tex setl tx ts=2 sw=2 fo+=wa

" Indent options for tex files.
" let g:tex_indent_brace = 1
" let g:tex_indent_items = 1

" Word wrapping, tab width, etc.
set ts=2 sw=2 fo+=wa
 
" Conceal. Do not conceal (sub|super)scripts.
set cole=2
let g:tex_conceal= 'adgm'
if has("unix")
  let s:uname = substitute(system("uname -s"), '\n', '', '')
  if s:uname == "Darwin"
    " Mac colour scheme is for Solarized light (reflective displays).
    hi Conceal guibg=#fdf6e3 guifg=#2aa198 font='Menlo'
  else
    " Linux colour scheme is for Zenburn (matte displays).
    hi Conceal guibg=#3f3f3f guifg=#dcdccc font='DejaVu Sans Mono'
  endif
endif
" let g:tex_conceal="adgm"

" Indent options for tex files.
let g:tex_indent_brace = 1
let g:tex_indent_items = 1

" Using colons as a keyword so that tab completion is slick.
set iskeyword+=:

" Do not conceal (sub|super)scripts.
let g:tex_conceal="adgm"

" Various macros.
call IMAP(',e', '\veps', 'tex')

call IMAP('IFF', 'if and only if', 'tex')
call IMAP('MPT', 'measure-preserving transformation', 'tex')
call IMAP('WLOG', 'without loss of generality', 'tex')
call IMAP('WRT', 'with respect to', 'tex')
call IMAP('\sigmaa', '$\sigma$-algebra', 'tex')
call IMAP('<=', '\le', 'tex')
call IMAP('>=', '\ge', 'tex')
call IMAP('!=', '\ne', 'tex')
call IMAP('::', '\colon', 'tex')
call IMAP(':=', '\colonequals', 'tex')
call IMAP('=:', '\equalscolon', 'tex')

call IMAP('Asterisque', "Ast\\'{e}risque", 'tex')
call IMAP('Gouezel', 'Gou\"{e}zel', 'tex')
call IMAP('Herve', "Herv\\'{e}", 'tex')
call IMAP('Hoelder', 'H\"{o}lder', 'tex')
call IMAP('Peigne', "Peign\\'{e}", 'tex')

call IMAP('vc', '\vec{<++>}<++>', 'tex')
call IMAP('ovc', '\overline{\vec{<++>}}_<++>', 'tex')
call IMAP('oO', '\overline{\Omega}_<++>', 'tex')
call IMAP('htj', '\hat{T}_{\vec{j}<++>}<++>', 'tex')

call IMAP('Cabg', '\C_{\alpha, \beta, \gamma}', 'tex')
call IMAP('nholder', '\abs{\<++>}_{\alpha, \beta}<++>', 'tex')
call IMAP('nuniform', '\abs{<++>}_\gamma<++>', 'tex')
call IMAP('nl1', '\abs{<++>}^{(1)}<++>', 'tex')
call IMAP('nabg', '\norm{<++>}_{\alpha, \beta, \gamma}<++>', 'tex')
call IMAP('nab1', '\norm{<++>}_{\alpha, \beta}^{(1)}<++>', 'tex')

call IMAP('niholder', '\abs{<++>}_{<++>, \alpha, \beta}<++>', 'tex')
call IMAP('niuniform', '\abs{<++>}_{<++>, \gamma}<++>', 'tex')
call IMAP('nil1', '\abs{<++>}_<++>^{(1)}<++>', 'tex')
call IMAP('niabg', '\norm{<++>}_{<++>, \alpha, \beta, \gamma}<++>', 'tex')
call IMAP('niab1', '\norm{<++>}_{<++>, \alpha, \beta}^{(1)}<++>', 'tex')

call IMAP('nxholder', '\abs{<++>}_{X_<++>, \alpha, \beta}<++>', 'tex')
call IMAP('nxuniform', '\abs{<++>}_{X_<++>, \gamma}<++>', 'tex')
call IMAP('nxl1', '\abs{<++>}_{X_<++>}^{(1)}<++>', 'tex')
call IMAP('nxabg', '\norm{<++>}_{X_<++>, \alpha, \beta, \gamma}<++>', 'tex')
call IMAP('nxab1', '\norm{<++>}_{X_<++>, \alpha, \beta}^{(1)}<++>', 'tex')

call IMAP('Coabg', '\C_{\Omega, \alpha, \beta, \gamma}', 'tex')
call IMAP('noholder', '\abs{<++>}_{\Omega, \alpha, \beta}<++>', 'tex')
call IMAP('nouniform', '\abs{<++>}_{\Omega, \gamma}<++>', 'tex')
call IMAP('nol1', '\abs{<++>}_\Omega^{(1)}<++>', 'tex')
call IMAP('noabg', '\norm{<++>}_{\Omega, \alpha, \beta, \gamma}<++>', 'tex')
call IMAP('noab1', '\norm{<++>}_{\Omega, \alpha, \beta}^{(1)}<++>', 'tex')

call IMAP(' . ', '\seedot', 'tex')


" Defining and redefining various environments.
let g:Tex_Env_lemma = "\\begin{lemma} \\label{lem:<++>}\<CR><++>\<CR>\\end{lemma}<++>"
let g:Tex_Env_theorem = "\\begin{theorem} \\label{thm:<++>}\<CR><++>\<CR>\\end{theorem}<++>"
let g:Tex_Env_figure = "\\begin{figure}[<+htpb+>]\<cr>\\centering\<cr>\\includesvg[<+width+>]{<+file+>}\<cr>\\caption{<+caption text+>}\<cr>\\label{fig:<+label+>}\<cr>\\end{figure}<++>"
let g:Tex_Env_equation = "\\begin{equation} \\label{eqn:<++>}\<CR><++>\<CR>\\end{equation}<++>"
let g:Tex_Env_frame = "\\begin{frame}\<CR>\\frametitle{<++>}\<CR><++>\<CR>\\end{frame}<++>"

" Delete a surrounding attribute/macro.
nmap <silent> dsa ds}dF\

let g:Tex_SmartKeyDot=0
call IMAP('...', '\dots', 'tex')

" In insert mode, the key sequence ^& makes the previous two characters into a 
" subscript and superscript respectively. For example, x12^& will change to 
" x_1^2.
function! <SID>SubSuperscripts(keyOne, keyTwo)
  let l = strpart(getline("."), col(".")-4, 3)
  if len(l) == 3 && l[2] == a:keyOne
    return join(["\<bs>\<bs>\<bs>_", l[0], "^",  l[1]], "")
  else
    return a:keyTwo
  endif
endfunction
inoremap & <C-R>=<SID>SubSuperscripts("^", "&")<CR>

" Custom mappings as per <http://vim.1045645.n5.nabble.com/understanding-Alt-key-mapping-in-latex-suite-tp1216914p1216919.html>.
augroup MyTeXIMAPs
  imap <D-b> <Plug>Tex_MathBF
  imap <D-c> <Plug>Tex_MathCal
  imap <D-l> <Plug>Tex_LeftRight
  imap <D-i> <Plug>Tex_InsertItemOnThisLine
  imap <D-u> <Plug>Tex_InsertItemOnThisLine
  imap <D-y> <Plug>Tex_InsertItemOnNextLine
  " Note that <C-CR> is mapped to Tex_InsertItemOnNextLine

  imap <C-b> <Plug>Tex_MathBF
  imap <C-c> <Plug>Tex_MathCal
  imap <C-l> <Plug>Tex_LeftRight
  imap <C-u> <Plug>Tex_InsertItemOnThisLine
  imap <C-y> <Plug>Tex_InsertItemOnNextLine

  imap <A-u> <Plug>Tex_InsertItemOnThisLine
  imap <A-y> <Plug>Tex_InsertItemOnNextLine
augroup END 

" Disable wrapping
set wrap linebreak nolist
set fo=

" Indentation
set tw=0 ts=2 sw=2

