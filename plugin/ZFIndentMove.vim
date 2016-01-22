" ZFIndentMove.vim - vim script to move cursor quickly accorrding indent
" Author:  ZSaberLv0 <http://zsaber.com/>

function! ZF_IndentGetIndentLevel(line)
    let line = substitute(a:line, '\t', '    ', 'g')
    return strlen(matchstr(line, "^\\s\\+")) / &tabstop
endfunction
function! ZF_IndentMoveParent()
    let cur_line = getpos(".")[1]
    let cur_indent = ZF_IndentGetIndentLevel(getline("."))
    if cur_indent < 0
        let cur_indent = 0
    endif

    for i in range(cur_line)
        normal! k
        let parent_indent = ZF_IndentGetIndentLevel(getline("."))
        if parent_indent < 0
            let parent_indent = 0
        endif

        if strlen(getline(".")) == 0
            continue
        endif
        if parent_indent == 0 && cur_indent == 0
            break
        endif
        if parent_indent < cur_indent
            break
        endif
    endfor
endfunction
function! ZF_IndentMoveParentEnd()
    let cur_line = getpos(".")[1]
    let cur_indent = ZF_IndentGetIndentLevel(getline("."))
    if cur_indent < 0
        let cur_indent = 0
    endif

    for i in range(cur_line, line("$"))
        normal! j
        let parent_indent = ZF_IndentGetIndentLevel(getline("."))
        if parent_indent < 0
            let parent_indent = 0
        endif

        if strlen(getline(".")) == 0
            continue
        endif
        if parent_indent == 0 && cur_indent == 0
            break
        endif
        if parent_indent < cur_indent
            break
        endif
    endfor
endfunction
function! ZF_IndentMovePrev()
    let cur_line = getpos(".")[1]
    let cur_indent = ZF_IndentGetIndentLevel(getline("."))
    if cur_indent < 0
        let cur_indent = 0
    endif

    let skip_flag = 0
    for i in range(cur_line)
        normal! k
        let parent_indent = ZF_IndentGetIndentLevel(getline("."))
        if parent_indent < 0
            let parent_indent = 0
        endif

        if strlen(getline(".")) == 0
            let skip_flag = 1
            continue
        endif
        if parent_indent == cur_indent && skip_flag == 1
            break
        endif
        if parent_indent < cur_indent
            break
        endif
    endfor
endfunction
function! ZF_IndentMoveNext()
    let cur_line = getpos(".")[1]
    let cur_indent = ZF_IndentGetIndentLevel(getline("."))
    if cur_indent < 0
        let cur_indent = 0
    endif

    let skip_flag = 0
    for i in range(cur_line, line("$"))
        normal! j
        let next_indent = ZF_IndentGetIndentLevel(getline("."))
        if next_indent < 0
            let next_indent = 0
        endif

        if strlen(getline(".")) == 0
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
endfunction

