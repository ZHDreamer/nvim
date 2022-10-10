vim.cmd([[
" Enable tab to spaces conversion
let g:neoformat_basic_format_retab = 0

" Enable trimmming of trailing whitespace
let g:neoformat_basic_format_trim = 0

let g:neoformat_c_clangformat = {
        \ 'exe': 'clang-format',
        \ 'args': ['-style="file"'],
        \ 'stdin': 1,
        \ }
let g:neoformat_enabled_cpp = ['clangformat']
let g:neoformat_enabled_c = ['clangformat']

let g:neoformat_python_black = {
        \ 'exe': 'black',
        \ 'args': ['--skip-string-normalization'],
        \ 'stdin': 0,
        \ 'replace': 1
        \ }

" let g:neoformat_python_autopep8 = {
"             \ 'exe': 'autopep8',
"             \ 'args': ['-s 4', '-E'],
"             \ 'replace': 1 " replace the file, instead of updating buffer (default: 0),
"             \ 'stdin': 1, " send data to stdin of formatter (default: 0)
"             \ 'env': ["DEBUG=1"], " prepend environment variables to formatter command
"             \ 'valid_exit_codes': [0, 23],
"             \ 'no_append': 1,
"             \ }

let g:neoformat_enabled_python = ['black']

" augroup fmt
"   autocmd!
"   autocmd BufWritePre * undojoin | Neoformat
" augroup END
]])
