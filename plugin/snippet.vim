let g:snippet#location = get(g:, "snippet#location", stdpath("config") . "/snippets")
let g:snippet#edit_cmd = get(g:, "snippet#edit_cmd", "vs")

command! -nargs=? Snippet call snippet#edit(<args>)
inoremap <silent> <expr> <tab> snippet#expand()
