if exists('g:loaded_snippet')
    finish
endif

let g:snippet#location = get(g:, "snippet#location", stdpath("config") . "/snippets")
let g:snippet#edit_cmd = get(g:, "snippet#edit_cmd", "vs")

command! -nargs=0 Snippet call snippet#edit()

inoremap <silent> <expr> <tab> snippet#expand()

let g:loaded_snippet = 1
