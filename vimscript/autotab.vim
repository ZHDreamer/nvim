function AutoTab()
    let line = getline('.')
    let col = col('.')
    if line[col('.') - 2] == ' ' && line[col(.) - 3] == '-'
        return execute('norm! K<Tab>')
    else
        return execute('<Tab>')
    endif
endf
