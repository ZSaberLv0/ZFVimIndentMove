# ZFVimIndentMove

vim script to move cursor quickly accorrding indent


# how to use

1. use [Vundle](https://github.com/VundleVim/Vundle.vim) or any other plugin manager you like to install

    ```
    Plugin 'ZSaberLv0/ZFVimIndentMove'
    ```

1. use keymap to move cursor, default keymap:

    ```
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
    ```

    you may disable the default keymap by

    ```
    let g:ZFIndentMove_autoKeymap=0
    ```

# functions

* `ZF_IndentGetIndentLevel(line)`

    get indent level of line, accorrding to your `tabstop`

* `ZF_IndentIsEmpty(line)`

    true if line is empty or contains spaces or tabs only

* `ZF_IndentMoveParent(mode)`

    move up to nearest parent indent
    (whose indent is less than current line)

    ```
    move >> foo
                foo

     cur >>     foo
    ```

* `ZF_IndentMoveParentEnd(mode)`

    move down to nearest parent indent
    (whose indent is less than current line)

    ```
     cur >>     foo

                foo
    move >> foo
    ```

* `ZF_IndentMoveChild(mode)`

    move down to nearest child indent
    (whose indent is larger than current line)

    ```
     cur >> foo
            foo

    move >>     foo
    ```

* `ZF_IndentMovePrev(mode)`

    move up to nearest sibling or parent indent
    (whose indent is equal to or less than current line, skip first empty or same indent line)

    ```
    move >> foo

            foo
     cur >> foo
    ```

    or

    ```
    move >> foo
                foo
     cur >>     foo
    ```

* `ZF_IndentMoveNext(mode)`

    move down to nearest sibling or parent indent
    (whose indent is equal to or less than current line, skip first empty or same indent line)

    ```
     cur >> foo
            foo

    move >> foo
    ```

    or

    ```
     cur >>     foo
                foo
    move >> foo
    ```

