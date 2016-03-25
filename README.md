# ZFIndentMove.vim

vim script to move cursor quickly accorrding indent


# how to use

1. use [Vundle](https://github.com/VundleVim/Vundle.vim) or any other plugin manager you like to install

    ```
    Plugin 'ZSaberLv0/ZFIndentMove.vim'
    ```

1. have your own keymap in your vimrc, recommended keymap:

    ```
    nnoremap EE ``
    nnoremap EH :call ZF_IndentMoveParent('n')<cr>
    xnoremap EH :call ZF_IndentMoveParent('v')<cr>
    nnoremap EL :call ZF_IndentMoveParentEnd('n')<cr>
    xnoremap EL :call ZF_IndentMoveParentEnd('v')<cr>
    nnoremap EK :call ZF_IndentMovePrev('n')<cr>
    xnoremap EK :call ZF_IndentMovePrev('v')<cr>
    nnoremap EJ :call ZF_IndentMoveNext('n')<cr>
    xnoremap EJ :call ZF_IndentMoveNext('v')<cr>
    nnoremap EI :call ZF_IndentMoveChild('n')<cr>
    xnoremap EI :call ZF_IndentMoveChild('v')<cr>
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

