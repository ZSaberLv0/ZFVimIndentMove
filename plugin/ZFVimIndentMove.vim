" ZFVimIndentMove - vim script to move cursor quickly accorrding indent
" Author:  ZSaberLv0 <http://zsaber.com/>

if !exists('g:ZFIndentMove_autoKeymap') || g:ZFIndentMove_autoKeymap
    nnoremap E <nop>
    nnoremap EE ``
    nnoremap <silent> EH :call ZF_IndentMoveParent('n')<cr>
    xnoremap <silent> EH :<c-u>call ZF_IndentMoveParent('v')<cr>
    nnoremap <silent> EL :call ZF_IndentMoveParentEnd('n')<cr>
    xnoremap <silent> EL :<c-u>call ZF_IndentMoveParentEnd('v')<cr>
    nnoremap <silent> EK :call ZF_IndentMovePrev('n')<cr>
    xnoremap <silent> EK :<c-u>call ZF_IndentMovePrev('v')<cr>
    nnoremap <silent> EJ :call ZF_IndentMoveNext('n')<cr>
    xnoremap <silent> EJ :<c-u>call ZF_IndentMoveNext('v')<cr>
    nnoremap <silent> EI :call ZF_IndentMoveChild('n')<cr>
    xnoremap <silent> EI :<c-u>call ZF_IndentMoveChild('v')<cr>
endif

" ============================================================
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
    call s:action('s:actionMoveParent', a:mode)
endfunction
function! ZF_IndentMoveParentEnd(mode)
    call s:action('s:actionMoveParentEnd', a:mode)
endfunction
function! ZF_IndentMoveChild(mode)
    call s:action('s:actionMoveChild', a:mode)
endfunction
function! ZF_IndentMovePrev(mode)
    call s:action('s:actionMovePrev', a:mode)
endfunction
function! ZF_IndentMoveNext(mode)
    call s:action('s:actionMoveNext', a:mode)
endfunction

" ============================================================
function! s:action(action, mode)
    normal! m`
    if a:mode=='v'
        execute "normal! gv\<esc>"
    endif

    silent! unlet s:target
    execute 'call ' . a:action . '()'
    if exists('s:target') && s:target != getpos('.')[1]
        let curPos = getcurpos()
        let curPos[1] = s:target
        call setpos('.', curPos)
    endif

    if a:mode=='v'
        normal! m>gv
    endif
endfunction

function! s:actionMoveParent()
    let curIndent = ZF_IndentGetIndentLevel(getline('.'))
    for i in range(getpos('.')[1] - 1, 1, -1)
        let line = getline(i)
        if ZF_IndentIsEmpty(line)
            if i == 1
                let s:target = i
            endif
            continue
        endif
        let targetIndent = ZF_IndentGetIndentLevel(line)
        if (targetIndent == 0 && curIndent == 0) || targetIndent < curIndent
            let s:target = i
            break
        endif
    endfor
endfunction
function! s:actionMoveParentEnd()
    let curIndent = ZF_IndentGetIndentLevel(getline('.'))
    for i in range(getpos('.')[1] + 1, line('$'))
        let line = getline(i)
        if ZF_IndentIsEmpty(line)
            if i == line('$')
                let s:target = i
            endif
            continue
        endif
        let targetIndent = ZF_IndentGetIndentLevel(line)
        if (targetIndent == 0 && curIndent == 0) || targetIndent < curIndent
            let s:target = i
            break
        endif
    endfor
endfunction
function! s:actionMoveChild()
    let curIndent = ZF_IndentGetIndentLevel(getline('.'))
    for i in range(getpos('.')[1] + 1, line('$'))
        let line = getline(i)
        if ZF_IndentIsEmpty(line)
            continue
        endif
        let targetIndent = ZF_IndentGetIndentLevel(line)
        if targetIndent < curIndent
            break
        elseif targetIndent > curIndent
            let s:target = i
            break
        endif
    endfor
endfunction
function! s:actionMovePrev()
    let curIndent = ZF_IndentGetIndentLevel(getline('.'))
    let skipFlag = 0
    for i in range(getpos('.')[1] - 1, 1, -1)
        let line = getline(i)
        if ZF_IndentIsEmpty(line)
            let skipFlag = 1
            if i == 1
                let s:target = i
            endif
            continue
        endif
        let targetIndent = ZF_IndentGetIndentLevel(line)
        if targetIndent > curIndent
            let skipFlag = 1
            continue
        endif
        if (targetIndent == curIndent && skipFlag == 1) || targetIndent < curIndent
            let s:target = i
            break
        endif
    endfor
endfunction
function! s:actionMoveNext()
    let curIndent = ZF_IndentGetIndentLevel(getline('.'))
    let skipFlag = 0
    for i in range(getpos('.')[1] + 1, line('$'))
        let line = getline(i)
        if ZF_IndentIsEmpty(line)
            let skipFlag = 1
            if i == line('$')
                let s:target = i
            endif
            continue
        endif
        let targetIndent = ZF_IndentGetIndentLevel(line)
        if targetIndent > curIndent
            let skipFlag = 1
            continue
        endif
        if (targetIndent == curIndent && skipFlag == 1) || targetIndent < curIndent
            let s:target = i
            break
        endif
    endfor
endfunction

