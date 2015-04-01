" Word wrapping, tab width, etc.
set ts=2 sw=2 fo+=wa
 
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
call IMAP('NN', 'neural network', 'tex')
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

