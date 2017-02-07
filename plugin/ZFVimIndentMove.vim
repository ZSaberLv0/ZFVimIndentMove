" ZFVimIndentMove - vim script to move cursor quickly accorrding indent
" Author:  ZSaberLv0 <http://zsaber.com/>

function! ZF_IndentGetIndentLevel(line)
    let tabspace = ''
    for i in range(&tabstop)
        let tabspace .= ' '
    endfor
    let line = substitute(a:line, '\t', tabspace, 'g')
    return strlen(matchstr(line, "^\\s\\+")) / &tabstop
endfunction
function! ZF_IndentIsEmpty(line)
    return strlen(substitute(a:line, '[\t ]', '', 'g')) == 0
endfunction
function! ZF_IndentMoveParent(mode)
    normal! m`
    if a:mode=='v'
        execute "normal! gv\<esc>"
    endif
    let cur_line = getpos(".")[1]
    let cur_indent = ZF_IndentGetIndentLevel(getline("."))

    for i in range(cur_line)
        normal! k
        let parent_indent = ZF_IndentGetIndentLevel(getline("."))

        if ZF_IndentIsEmpty(getline("."))
            continue
        endif
        if parent_indent == 0 && cur_indent == 0
            break
        endif
        if parent_indent < cur_indent
            break
        endif
    endfor
    if a:mode=='v'
        normal! m>gv
    endif
endfunction
function! ZF_IndentMoveParentEnd(mode)
    normal! m`
    if a:mode=='v'
        execute "normal! gv\<esc>"
    endif
    let cur_line = getpos(".")[1]
    let cur_indent = ZF_IndentGetIndentLevel(getline("."))

    for i in range(cur_line, line("$"))
        normal! j
        let parent_indent = ZF_IndentGetIndentLevel(getline("."))

        if ZF_IndentIsEmpty(getline("."))
            continue
        endif
        if parent_indent == 0 && cur_indent == 0
            break
        endif
        if parent_indent < cur_indent
            break
        endif
    endfor
    if a:mode=='v'
        normal! m>gv
    endif
endfunction
function! ZF_IndentMoveChild(mode)
    normal! m`
    if a:mode=='v'
        execute "normal! gv\<esc>"
    endif
    let cur_line = getpos(".")[1]
    let cur_indent = ZF_IndentGetIndentLevel(getline("."))

    let child_exist=0
    for i in range(cur_line, line("$"))
        normal! j
        let child_indent = ZF_IndentGetIndentLevel(getline("."))

        if ZF_IndentIsEmpty(getline("."))
            continue
        endif
        if child_indent > cur_indent
            let child_exist=1
            break
        endif
    endfor
    if child_exist==0
        normal! ``
    endif
    if a:mode=='v'
        normal! m>gv
    endif
endfunction
function! ZF_IndentMovePrev(mode)
    normal! m`
    if a:mode=='v'
        execute "normal! gv\<esc>"
    endif
    let cur_line = getpos(".")[1]
    let cur_indent = ZF_IndentGetIndentLevel(getline("."))

    let skip_flag = 0
    for i in range(cur_line)
        normal! k
        let prev_indent = ZF_IndentGetIndentLevel(getline("."))

        if prev_indent > cur_indent
            let skip_flag = 1
        endif
        if ZF_IndentIsEmpty(getline("."))
            let skip_flag = 1
            continue
        endif
        if prev_indent == cur_indent && skip_flag == 1
            break
        endif
        if prev_indent < cur_indent
            break
        endif
    endfor
    if a:mode=='v'
        normal! m>gv
    endif
endfunction
function! ZF_IndentMoveNext(mode)
    normal! m`
    if a:mode=='v'
        execute "normal! gv\<esc>"
    endif
    let cur_line = getpos(".")[1]
    let cur_indent = ZF_IndentGetIndentLevel(getline("."))

    let skip_flag = 0
    for i in range(cur_line, line("$"))
        normal! j
        let next_indent = ZF_IndentGetIndentLevel(getline("."))

        if next_indent > cur_indent
            let skip_flag = 1
        endif
        if ZF_IndentIsEmpty(getline("."))
            let skip_flag = 1
            continue
        endif
        if next_indent == cur_indent && skip_flag == 1
            break
        endif
        if next_indent < cur_indent
            break
        endif
    endfor
    if a:mode=='v'
        normal! m>gv
    endif
endfunction

