" Roxygen2 documentation template.
" Adapted from https://github.com/jiang-hang/vim4roxygen2
function ftplugin#R#GetParams()
    " Search from the current line to an opening brace.
    let s:start = line('.')
    let s:braceStart = search("{", "nW")
    let s:prototype = search("prototype", "nW")
    
    " Determine the end of the search area.
    let s:end = -1
    let endMode = ""
    if s:prototype != 0 && s:prototype <= s:braceStart
        " Subtract 1 because 'prototype' is assumed to start the line.
        let s:end = s:prototype - 1   
        let endMode = "prototype"
    elseif s:braceStart != 0  " Use the next brace.
        let s:end = s:braceStart
        let endMode = "brace"
    else
        echoerr "No 'prototype' string nor '{' found."
    endif
    
    " Look for a function or the slots for a class.
    while match(getline(s:start), "function") == -1 && 
          \ match(getline(s:start), "slots") == -1 && s:start <= s:end
        let s:start = s:start + 1
    endwhile
    
    " There is no starting function or there are no slots.
    if s:start > s:end
        echoerr "No function found."
    else
      " If the opening brace is the first character on the last search line, 
      " then we do not search this line.
      if endMode == "brace" && stridx(getline(s:end),"{") == 0
          let s:end = s:end - 1
      endif
      
      let s:lines=getline(s:start,s:end)
      let mlines=join(s:lines)
      let mlines=substitute(mlines," ","","g")
      let paraFlag1=stridx(mlines,'(')
      let paraFlag2=strridx(mlines,')')
      let paraLen=paraFlag2-paraFlag1-1
      let parastr=strpart(mlines,paraFlag1+1,paraLen)
      let alist=[]
      if  stridx(parastr,',') != -1
         let s:paras=split(parastr,',')
         let s:idx=0
         while s:idx < len(s:paras)
               if stridx(s:paras[s:idx],'=') != -1
                    let s:realpara = split(s:paras[s:idx],'=')[0]
               else
                    let s:realpara = s:paras[s:idx]
               endif
               "strip the leading blanks
               "call append(s:start - 1 + s:idx , "#' @param " . s:realpara)
               call add(alist,s:realpara)
               let s:idx = s:idx + 1
         endwhile
      else
         "call append(s:start-1,parastr) 
         if parastr != ""
            call add(alist,parastr)
         endif
      endif
      return alist
    endif
endfunction

function ftplugin#R#Rdoc()
    let s:wd=expand("")
    let s:lineNo=line('.')-1
    let plist=ftplugin#R#GetParams()
    call append(s:lineNo,"#' title ")
    call append(s:lineNo + 1,"#' ")
    call append(s:lineNo + 2,"#' description")
    call append(s:lineNo + 3,"#' ")
    let s:idx =0
    while s:idx < len(plist)
        call append(s:lineNo + 4 + s:idx , "#' @param " . plist[s:idx] . " value")
        let s:idx = s:idx + 1
    endwhile
    call append(s:lineNo + 4 + s:idx,"#'")
    call append(s:lineNo + 4 + s:idx + 1,"#' @return returndes")
    call append(s:lineNo + 4 + s:idx + 2,"#'")
    call append(s:lineNo + 4 + s:idx + 3,"#' @examples")
    call append(s:lineNo + 4 + s:idx + 4,"#' x=c(1,2,3)")
    call append(s:lineNo + 4 + s:idx + 5,"#'")
    call append(s:lineNo + 4 + s:idx + 6,"#' @export")
    call append(s:lineNo + 4 + s:idx + 7,"")
endfunction


