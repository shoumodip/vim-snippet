" Dark magic. DO NOT TOUCH!
let s:snippet_jump  = "\<c-o>:if search('\\${\\~[^}]*}', 'c') != 0 | "
let s:snippet_jump .= "call snippet#jump() | "
let s:snippet_jump .= "else | "
let s:snippet_jump .= "call feedkeys('\t', 'n') | "
let s:snippet_jump .= "endif\<cr>"

let s:snippet_markers = v:false

" Jump to the next snippet cursor position
function! snippet#jump()
    let pattern = '\${\~\([^}]*\)}'
    let current = getline(".")
    let match = matchstrpos(current, pattern)
    let length = match[2] - match[1] - 5

    call setline(".", substitute(getline("."), pattern, '\1', ''))

    if length > 0
        execute "normal! v" . length . "l\<c-g>"
    endif
endfunction

" Evaluate the contents of a snippet block
function! snippet#eval(expr, cursor)
    if a:expr[0] ==# '!'
        let result = substitute(system(a:expr[1:-1]), "\n$", "", "")
    elseif a:expr[0] ==# ':'
        let result = eval(a:expr[1:-1])
    else
        let result = a:expr
    endif

    if a:cursor ==# "~"
        let s:snippet_markers = v:true
        let result = "${~" . result . "}"
    endif

    return result
endfunction

" Expand a snippet
function! snippet#expand()
    let current = getline(".")
    let word = matchstr(current, '\v\w+%' . col(".") . "c")

    let snippet = g:snippet#location . "/" . word
    let filetype_snippet = g:snippet#location . "/" . &filetype . "/" . word

    let s:snippet_markers = v:false

    if filereadable(filetype_snippet)
        let snippet = filetype_snippet
    endif

    let result = ""

    if filereadable(snippet)
        let snippet = readfile(snippet)
        let snippet[0] = repeat("\<bs>", strlen(word)) . snippet[0]

        for i in range(len(snippet))
            let snippet[i] = substitute(snippet[i], '\${\(\~\?\)\([^}]*\)}',
                        \ '\=snippet#eval(submatch(2), submatch(1))', "g")
        endfor

        let result  = "\<c-o>:set paste\<cr>" . join(snippet, "\n") . "\<c-o>:set nopaste\<cr>"

        if s:snippet_markers
            let result .= "\<c-o>:" . line(".") . "\<cr>\<c-o>" . (col(".") - strlen(word)) . "|"
            let s:snippet_markers = v:false
        else
            return result
        endif
    endif

    return result . s:snippet_jump
endfunction

" Create a new snippet
function! snippet#edit(...)
    let path = input("Edit: ")

    if len(path) > 0
        if exists("a:1")
            let path = g:snippet#location . "/" . a:1 . "/" . path
        else
            let path = g:snippet#location . "/" . path
        endif

        silent! call mkdir(fnamemodify(path, ":h"), "p")
        execute g:snippet#edit_cmd . " " . path

        if exists("a:1")
            let &l:filetype = a:1
        endif
    endif
endfunction
