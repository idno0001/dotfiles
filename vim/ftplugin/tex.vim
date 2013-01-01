" Word wrapping, tab width, etc.
set tx ts=2 sw=2 fo+=wa
 
" Indent options for tex files.
let g:tex_indent_brace = 1
let g:tex_indent_items = 1

" Using colons as a keyword so that tab completion is slick.
set iskeyword+=:

" Do not conceal (sub|super)scripts.
let g:tex_conceal="adgm"

" Various macros.
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

call IMAP('Asterisque', "Ast\\'{e}risque", 'tex')
call IMAP('Herve', "Herv\\'{e}", 'tex')
call IMAP('Hoelder', 'H\"{o}lder', 'tex')
call IMAP('Peigne', "Peign\\'{e}", 'tex')

