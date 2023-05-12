vim.cmd([[
    let g:rainbow_active = 1
    let g:rainbow_conf = {
    \   'guifgs': ['#FFD700', '#DA70D6', '#87CEFA'],
    \   'guis': [''],
    \   'cterms': [''],
    \   'operators': '_,_',
    \   'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
    \   'separately': {
    \       '*': {},
    \       'markdown': 0,
    \       'vim': {
    \           'parentheses_options': 'containedin=vimFuncBody'
    \       }
    \   }
    \}
]])

-- \   'ctermfgs': ['#FFD700', '#DA70D6', '#87CEFA'],
